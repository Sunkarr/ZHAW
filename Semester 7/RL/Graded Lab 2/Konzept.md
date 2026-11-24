# Konzept: Graded Lab 2 – Deep Q-Learning für LunarLander

**Autoren:** Jonas Bratschi (`bratsjon`) & Natalie Jakab (`jakabnat`)  
**Modul:** Reinforcement Learning (ZHAW – Semester 7)  
**Umgebung:** `LunarLander-v2` (Gymnasium / Box2D)  
**Hardware-Beschleunigung:** Apple Silicon Metal (`mps`), Fallback auf `cuda` / `cpu`

---

## 1. Ausgangslage & Zielsetzung

In diesem Lab soll ein Deep Q-Network (DQN) von Grund auf implementiert und auf die Umgebung `LunarLander-v2` angewendet werden. 

* **Erfolgsmetrik:** Ein Agent gilt ab einem Durchschnitts-Score von $\ge 200$ Punkten über 100 Episoden als gelöst. Unser Ziel ist ein konsistent landender Spitzen-Agent mit durchschnittlich **$250$ bis $280+$ Punkten**.
* **Schnittstellen-Vorgabe:** Standardisierte Methode `actions = agent.select_action(states)`, kompatibel mit `env.step(actions)`.
* **Vektorisierte Umgebung:** Das offizielle Notebook setzt auf `make_vec_env('LunarLander-v2', n_envs=16)`. Der Agent muss daher 16 parallele Umgebungen effizient bedienen.

---

## 2. Technische Vorabklärung: Frame-Skipping / Action-Repeat

* **Erkenntnis:** Lunar Lander verwendet standardmässig keinen Bild-Input (Pixel), sondern einen **8-dimensionalen Zustandsvektor** ($x, y, v_x, v_y, \theta, \dot{\theta}, l_1, l_2$).
* **Entscheidung:** Auf Frame-Skipping (z. B. jeden 5. oder 10. Frame) wird verzichtet:
  1. *Kein Rechenzeitengpass:* Das MLP-Netzwerk benötigt für einen 8D-Vektor nur Mikrosekunden.
  2. *Flugstabilität:* Bei 50 Hz Physik-Simulation würde ein 10-Frame-Repeat bedeuten, dass ein Triebwerk 0.2 Sekunden durchgehend feuert. Das führt bei der feinen Balancierung des Landers schnell zu fatalem Taumeln oder Abstürzen. Jeder Zeitschritt wird daher einzeln bewertet.

---

## 3. Die 5 Säulen für eine Bestnote

```
                               ┌────────────────────────────────────────────────┐
                               │       Graded Lab 2: Deep Q-Learning            │
                               │           Lunar Lander Excellence              │
                               └───────────────────────┬────────────────────────┘
                                                       │
         ┌───────────────────┬─────────────────────────┼─────────────────────────┬───────────────────┐
         │                   │                         │                         │                   │
         ▼                   ▼                         ▼                         ▼                   ▼
┌─────────────────┐ ┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐ ┌─────────────────┐
│ Säule 1         │ │ Säule 2         │       │ Säule 3         │       │ Säule 4         │ │ Säule 5         │
│ Algorithmen-    │ │ Vectorized      │       │ Erweiterte      │       │ Empirische      │ │ Video mit       │
│ Ablationsstudie │ │ High-Perf DRL   │       │ Metriken &      │       │ Hyperparameter- │ │ Telemetrie-HUD  │
│ (DQN, DDQN,     │ │ (Vec Replay &   │       │ Flugdynamik     │       │ Methodik &      │ │ & Akademischer  │
│ Dueling DDQN)   │ │ Boundary Fix)   │       │ (Flugpfade,     │       │ Multi-Seed CI   │ │ Report (PDF)    │
│                 │ │                 │       │ Treibstoff)     │       │                 │ │                 │
└─────────────────┘ └─────────────────┘       └─────────────────┘       └─────────────────┘ └─────────────────┘
```

### Säule 1: Algorithmen-Ablationsstudie
Anstatt nur eine einzige Standard-Implementierung abzuliefern, bauen wir eine saubere, modulare Architektur zum direkten Leistungsvergleich:
1. **Vanilla DQN (Baseline):** Replay Buffer + Target Network (gezieltes Aufzeigen der Q-Wert-Überschätzung).
2. **Double DQN (DDQN):** Entkopplung von Aktionswahl (Online-Netz) und Evaluierung (Target-Netz):
   $$Y_t = R_{t+1} + \gamma Q(S_{t+1}, \operatorname{argmax}_a Q(S_{t+1}, a; \theta_t); \theta_t^-)$$
3. **Dueling Double DQN (D3QN – Flaggschiff):**
   Aufteilung in Value Stream $V(s)$ und Advantage Stream $A(s, a)$:
   $$Q(s, a) = V(s) + \left(A(s, a) - \frac{1}{|\mathcal{A}|}\sum_{a'} A(s, a')\right)$$
4. **Soft Target Updates (Polyak Averaging):**
   Glättung des Target-Netzwerks mittels $\theta^- \leftarrow \tau \theta + (1-\tau)\theta^-$ mit $\tau = 10^{-3}$ statt sprunghafter Hard-Updates.

### Säule 2: Vectorized Training & Apple Silicon Acceleration
* **Hardware:** Nutzung von `torch.device("mps")` (Apple Silicon Metal) mit Fallback auf `cuda` oder `cpu`.
* **Vectorized Replay Buffer:** Speichert 16 parallele Transitions pro Zeitschritt kompakt in Pre-allocated NumPy- oder PyTorch-Tensoren.
* **Korrektes Terminal-State Handling:** `make_vec_env` führt bei `done` automatisch einen Umgebungs-Reset durch. Der wahre finale Zustand für das Bellman-Ziel wird korrekt aus `infos["final_observation"]` ausgelesen.

### Säule 3: Erweiterte Metriken & Flugdynamik
Neben dem reinen Episoden-Reward erfassen wir vertiefende ingenieurmässige Kennzahlen:
* **Landing Success Rate (%):** Anteil der Episoden mit erfolgreicher Landung zwischen den Flaggen.
* **Crash Rate (%):** Anteil der Abstürze (-100 Punkte Strafe).
* **Treibstoff-Effizienz:** Analyse der Triebwerksstrafen (Haupttriebwerk: -0.3 Pkt/Frame, Steuertriebwerk: -0.03 Pkt/Frame).
* **2D-Trajektorien-Visualisierung:** Darstellung von Flugpfaden $(x, y)$ zur Veranschaulichung der Flugstabilität (untrainiert vs. DDQN vs. D3QN).

### Säule 4: Systematische Hyperparameter-Methodik
* Begründete Wahl der Hyperparameter (Learning Rate $\alpha$, Discount Factor $\gamma=0.99$, Replay Buffer $10^5$, Batch Size 64/128, $\epsilon$-Greedy Schedule von 1.0 auf 0.01).
* Multi-Seed-Evaluation (z. B. 3 Seeds) mit Mittelwert und Konfidenzbändern (Shaded Error Bands) in den Plots.

### Säule 5: Video mit Telemetrie-HUD & Report
* **Video:** Generierung eines MP4-Replays mit visuellem **HUD-Overlay** (Geschwindigkeitsvektoren, Winkel, Treibstoffverbrauch sowie ein Live-Balkendiagramm der 4 Q-Werte).
* **Report:** 4-seitiges PDF (max. 3 Seiten Methoden/Resultate + max. 1 Seite Diskussion) im bewährten Pandoc/LaTeX-Layout aus Lab 1.

---

## 4. Neuronale Netzwerk-Architekturen & Begründung

### 4.1 Die beiden Netzwerk-Architekturen

#### A) Standard Q-Netzwerk (für Vanilla & Double DQN)
Ein kompaktes 2-Schicht Multi-Layer Perceptron (MLP) mit 128 Neuronen:

```
Zustand s (8) ──► Linear(8 -> 128) ──► ReLU ──► Linear(128 -> 128) ──► ReLU ──► Linear(128 -> 4) ──► Q(s, a) [4 Werte]
```
* **Parameteranzahl:** ca. 18'200 Parameter ($\approx 73\text{ KB}$ als PyTorch State Dict).

#### B) Dueling Q-Netzwerk (für Dueling Double DQN)
Gemeinsame Merkmals-Extraktion zur Erkennung der Fluglage, danach getrennte Streams für **Zustandswert** $V(s)$ (Skalar) und **Aktionsvorteil** $A(s, a)$ (4 Werte):

```
Zustand s (8)
     │
     ▼
Linear(8 -> 128) ──► ReLU
     │
     ▼
Linear(128 -> 128) ──► ReLU  (Gemeinsame Fluglage-Repräsentation)
     │
     ├────────────────────────────────────────┬────────────────────────────────────────┐
     ▼                                        ▼                                        ▼
[Value Stream V(s)]                      [Advantage Stream A(s, a)]
Linear(128 -> 64) ──► ReLU               Linear(128 -> 64) ──► ReLU
Linear(64 -> 1)   ──► V(s) [1 Skalar]    Linear(64 -> 4)   ──► A(s, a) [4 Werte]
     │                                        │
     └───────────────────┬────────────────────┘
                         ▼
             Kombinationsschicht (Aggregation):
        Q(s, a) = V(s) + ( A(s, a) - mean(A(s, :)) )
```
* **Parameteranzahl:** ca. 35'100 Parameter ($\approx 140\text{ KB}$ als PyTorch State Dict).

---

### 4.2 Wissenschaftliche Begründung (für den Methodenteil des Reports)

1. **Wahl der Schichtgrösse (128 Neuronen):**
   * *Nicht zu klein (32/64):* Die Physik von Lunar Lander ist stark nicht-linear (gekoppelte Schwerkraft- und Schubvektoren, Winkelbeschleunigung $\ddot{\theta}$, Bodenkontakt-Impulse). Ein zu kleines Netz glättet diese feinen Kopplungen zu stark ab.
   * *Nicht zu gross (512+):* Bei nur 8 kontinuierlichen Zustandsvariablen führen übergrosse Netze im Reinforcement Learning rasch zu Overfitting auf frühe Trajektorien, verlangsamen das Sample-Lernen und benötigen unnötige Rechenzeit. 128 Neuronen bieten die ideale Kapazität.
2. **Physikalische Eignung der Dueling-Architektur:**
   * *In grosser Höhe (Sinkflug / Freier Fall):* Befindet sich der Lander bei $y \approx 1.4$, ist der Wert des Zustands $V(s)$ nahezu identisch, egal ob in diesem Moment kurz ein Steuertriebwerk zündet oder nicht. Hier dominiert der Zustandswert $V(s)$.
   * *Kurz vor dem Touchdown:* Wenige Meter über der Landezone entscheidet das Zünden der Gegendüse über eine weiche Landung (+100) oder einen fatalen Überschlag (-100). Hier wird der relative Vorteil $A(s, a)$ der Aktion hochkritisch.
   * *Statistischer Vorteil:* Der $V(s)$-Stream lernt bei **jedem Zeitschritt** über alle Aktionen hinweg, wie gut die allgemeine Flugposition ist. Der $A(s,a)$-Stream muss nur noch die relative Triebwerksdifferenz lernen. Das beschleunigt die Konvergenz erheblich.
3. **Mittelwert-Zentrierung (`mean(A)`):**
   * Mathematisch ist die Zerlegung $Q = V + A$ ohne Nebenbedingung unterbestimmt (unendlich viele Kombinationen von $V$ und $A$ ergeben dieselbe Summe).
   * Durch Subtraktion des Mittelwerts $\frac{1}{|\mathcal{A}|}\sum_{a'} A(s, a')$ wird der Vorteil auf $\sum A(s, a) = 0$ zentriert. Das garantiert mathematische Eindeutigkeit (*Identifiability*) und stabilisiert die Gradienten bei Backpropagation.
4. **Modell-Ablage im Repository (`models/`):**
   * Aufgrund der geringen Grösse ($\approx 140\text{ KB}$ pro Modell) werden alle trainierten Checkpoints direkt ins Git-Repo eingecheckt.
   * Dadurch können Evaluationen, Plots und Videos jederzeit in Sekundenschnelle ohne erneutes Training reproduziert werden.

---

## 5. Geplante Projektstruktur

```
Semester 7/RL/Graded Lab 2/
├── Konzept.md                               # Dieses Dokument
├── README.md                                # Setup & Environment Guide
├── Task Description.txt                     # Offizielle Aufgabenstellung
├── DQN_lands_on_the_moon updated.ipynb      # Auszufüllendes Abgabe-Notebook
├── models/                                  # Trainierte Checkpoints (.pt, je ca. 140 KB)
│   ├── vanilla_dqn.pt
│   ├── double_dqn.pt
│   └── dueling_ddqn.pt
├── src/
│   ├── networks.py                          # QNetwork & DuelingQNetwork (PyTorch / MPS)
│   ├── replay_buffer.py                     # Vectorized Replay Buffer
│   ├── dqn_agent.py                         # DQNAgent (unterstützt DQN, DDQN, D3QN)
│   └── telemetry_recorder.py                # Video-Renderer mit Q-Value & Status-HUD
├── run_experiments.py                       # Skript für Training aller Varianten & Seeds
├── figures/                                 # Exportierte Plots für den Report
└── report/
    ├── Report.md                            # Akademischer Bericht (Markdown)
    ├── compile_report.sh                    # Pandoc-Kompilierskript nach PDF
    └── Report.pdf                           # Finales PDF
```

---

## 6. Konkrete nächste Schritte

1. **`src/networks.py` & `src/replay_buffer.py` implementieren:** PyTorch-Netzwerke mit MPS-Unterstützung und performantem Vectorized Buffer.
2. **`src/dqn_agent.py` erstellen:** Mit `select_action(states)` für Vektor-Umgebungen und umschaltbarem Modus (`vanilla`, `double`, `dueling`).
3. **Trainingsläufe starten:** Schneller Testlauf auf dem Mac (MPS), danach vollständige 1M-Step-Läufe.
4. **Notebook & Report befüllen:** Übernahme der Ergebnisse und Grafiken.
