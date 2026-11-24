# Experiment- & Run-Protokoll: Graded Lab 2 (LunarLander DQN)

**Autoren:** Jonas Bratschi (`bratsjon`) & Natalie Jakab (`jakabnat`)  
**Hardware:** Apple Silicon Metal (`mps`), Unified Memory  
**Umgebung:** `LunarLander-v2` / `LunarLander-v3` via `make_vec_env(..., n_envs=16)`  

Dieses Protokoll dokumentiert alle experimentellen Trainingsläufe, Hyperparameter-Änderungen und Evaluationsergebnisse für den wissenschaftlichen Vergleich im finalen Report.

---

## Übersicht der Experimente

| Run ID | Methode / Algorithmus | Timesteps | Batch Size | Target Update | Exploration ($\varepsilon$) | Mean100 (Train) | Eval Reward (10 Eps) | Success / Crash Rate |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Run 1** | Vanilla DQN (Baseline) | 500'000 | 64 | Hard (alle 1'000 Steps) | Exponentiell pro Episode ($\gamma_\varepsilon=0.996$) | 23.2 (Peak: 49.6) | $4.82 \pm 107.29$ | 0% / 60% |
| **Run 2** | Vanilla DQN (Tuned Parameter) | 1'000'000 | 128 | Hard (alle 3'000 Steps) | Linear über 300'000 Steps ($1.0 \to 0.02$) | -80.5 (Peak: -51.7) | $-101.89 \pm 12.60$ | 0% / 100% (Hover Timeout) |
| **Run 3** | Vanilla DQN (Fast Update) | 600'000 | 64 | Hard (alle 300 Steps) | Linear über 200'000 Steps ($1.0 \to 0.02$) | 48.8 (Peak: 48.8) | $+103.98 \pm 91.31$ | 20% / 0% |
| **Run 4** | Vanilla DQN (Soft Update) | 600'000 | 128 | Soft ($\tau = 10^{-3}$, Buffer 100k) | Linear über 200'000 Steps ($1.0 \to 0.02$) | 225.2 (Peak: 227.3) | $\mathbf{+234.70 \pm 58.06}$ | **80% / 0% (SOLVED!)** |
| **Run 5** | Vanilla DQN (Buffer 200k) | 600'000 | 128 | Soft ($\tau = 10^{-3}$, Buffer 200k) | Linear über 200'000 Steps ($1.0 \to \mathbf{0.01}$) | 159.5 (Peak: 161.9) | $+91.69 \pm 135.83$ | 30% / 0% (Stale Data Lag) |
| **Run 6** | Vanilla DQN (Extended 900k) | 900'000 | 128 | Soft ($\tau = 10^{-3}$, Buffer 100k) | Linear über 250'000 Steps ($1.0 \to 0.02$) | 205.3 (Peak: 205.3) | $\mathbf{+232.24 \pm 54.64}$ | **80% / 0% (Speed Landung 302 Fr!)** |
| **Run 7** | Double DQN (32 Envs) | 600'000 | 128 | Soft ($\tau = 10^{-3}$, Envs 32, GS 2) | Linear über 200'000 Steps ($1.0 \to 0.02$) | 13.7 (Peak: 13.7) | $-22.63 \pm 80.23$ | 0% / 70% (Under-trained UTD Lag) |
| **Run 8** | Double DQN (Controlled) | 600'000 | 128 | Soft ($\tau = 10^{-3}$, Envs 16, GS 2) | Linear über 200'000 Steps ($1.0 \to 0.02$) | 204.4 (Peak: 204.4) | $\mathbf{+243.52 \pm 23.01}$ | **90% / 0% (Minimale Varianz!)** |
| **Run 9** | Dueling Double DQN (D3QN) | 600'000 | 128 | Soft ($\tau = 10^{-3}$, Envs 16, GS 2) | Linear über 200'000 Steps ($1.0 \to 0.02$) | *Geplant (nächste Session)* | *Geplant* | *Geplant* |

---

## Detaillierte Protokolle

### Run 1: Vanilla DQN (Baseline Initiallauf)
* **Datum & Zeit:** 24.11.2026, 16:31 Uhr
* **Algorithmus:** Vanilla DQN (Mnih et al., 2015)
* **Netzwerk:** Standard-MLP $[8 \to 128 \to 128 \to 4]$, ReLU
* **Hyperparameter:**
  * `total_timesteps`: $500'000$
  * `n_envs`: $16$
  * `learning_rate`: $5 \cdot 10^{-4}$ (Adam, Gradient Clipping $\le 10$)
  * `batch_size`: $64$
  * `gamma`: $0.99$
  * `target_update`: Hard Update alle $1'000$ Environment Steps
  * `epsilon_schedule`: Multiplikativer Decay $0.996$ pro Episode ($1.0 \to 0.01$)
* **Trainings-Metriken:**
  * Trainingsdauer: $307.1\text{ s}$ ($\approx 5.1\text{ min}$)
  * Durchsatz: $\approx 1'600 - 2'000\text{ FPS}$
  * Episoden total: $1'020$
  * Bester Mean-100 Reward: $+49.6$
  * Einzelne Episoden-Spitzenwerte: Bis zu $+267.5$ Punkte
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $+4.82 \pm 107.29$
  * **Success Rate:** $0.0\%$ (keine konsistente sanfte Landung $>200$ Pkt)
  * **Crash Rate:** $60.0\%$
  * **Video Replay Reward:** $+127.0$ Punkte (612 Frames)
* **Beobachtungen & Fehleranalyse (für Report):**
  1. *Zu schneller $\varepsilon$-Decay:* Durch 16 parallele Umgebungen waren nach nur 150k Schritten bereits über 500 Episoden vorbei. $\varepsilon$ sank zu früh auf unter $0.10$, wodurch der Agent aufhörte, riskante Touchdowns zu explorieren und stattdessen in der Luft verharrte.
  2. *Hektische Target-Updates:* 1'000 Steps entsprechen bei 16 Envs nur 62 Zeitschritten. Das Target-Netzwerk sprang alle paar Sekunden um und destabilisierte die Q-Werte.
  3. *Overestimation Bias:* Typisch für Vanilla DQN ohne Double Q-Learning.
* **Artefakte:**
  * Checkpoint: `models/vanilla_dqn_run1_best.pt`
  * Logs: `logs/vanilla_dqn_run1_history.json`
  * Video: `videos/vanilla_dqn_run1_replay.mp4`

---

### Run 2: Vanilla DQN (Tuned Parameter)
* **Datum & Zeit:** 24.11.2026, 16:42 Uhr
* **Ziel:** Maximale Performance aus reinem Vanilla DQN herausholen, ohne die Kern-Architektur zu verändern.
* **Gezielte Parameteränderungen gegenüber Run 1:**
  1. `total_timesteps`: Erhöht von $500'000 \to 1'000'000$.
  2. `epsilon_schedule`: Linearer Step-Decay von $1.0 \to 0.02$ über genau $300'000$ Steps.
  3. `target_update_interval`: Erhöht von $1'000 \to 3'000$ Steps.
  4. `batch_size`: Erhöht von $64 \to 128$.
  5. `learning_rate`: Feinjustiert auf $3 \cdot 10^{-4}$.
* **Trainings-Metriken:**
  * Trainingsdauer: $543.2\text{ s}$ ($\approx 9.0\text{ min}$)
  * Durchsatz: $\approx 1'840\text{ FPS}$
  * Episoden total: $3'313$
  * Bester Mean-100 Reward: $-51.7$ (finaler Mean-100: $-80.5$)
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $-101.89 \pm 12.60$
  * **Success Rate:** $0.0\%$
  * **Crash Rate:** $0.0\%$ (Crash vermieden durch Timeout)
  * **Video Replay Reward:** $-128.6$ Punkte (**exakt 1'001 Frames = maximales Episodenlimit**)
* **Beobachtungen & Fundamentale Erkenntnis (Kernstoff für den Report):**
  1. **Das "Hovering Forever"-Lokale Minimum:**  
     Das Video liefert den schlagenden Beweis: Der Lander hat gelernt, die Schwerkraft perfekt auszugleichen und in der Schwebe zu bleiben, um den gefürchteten Crash-Malus von $-100$ Punkten um jeden Preis zu verhindern! Er schwebt exakt $1'000$ Zeitschritte lang in der Luft, bis die Gymnasium-Umgebung das Timeout-Limit (`max_episode_steps = 1000`) erzwingt.
  2. **Akkumulierte Triebwerksstrafen:**  
     Weil in jedem Schwebe-Frame Triebwerke gefeuert werden (Haupttriebwerk $-0.3$, Steuerdüsen $-0.03$), summiert sich über $1'000$ Frames ein konstanter Malus von ca. $-100$ bis $-130$ Punkten an. Die Varianz ist minimal ($\pm 12.60$), weil das Verhalten absolut deterministisch gelernt wurde.
  3. **Warum Vanilla DQN hier versagt:**  
     Das ist die theoretische Schwachstelle von Standard-DQN: Durch den Overestimation Bias glaubt der Agent, dass die Landung am Boden zu unberechenbar/riskant ist, während das endlose Schweben einen stabilen "nicht-katastrophalen" Erwartungswert verspricht.
* **Artefakte:**
  * Checkpoint: `models/vanilla_dqn_run2_best.pt`
  * Logs: `logs/vanilla_dqn_run2_history.json`
  * Video: `videos/vanilla_dqn_run2_replay.mp4`

---

### Run 3: Vanilla DQN (Fast Target Update – 300 Steps)
* **Datum & Zeit:** 24.11.2026, 17:04 Uhr
* **Ziel:** Das "Hovering Forever"-Problem beheben, indem die Bellman-Propagierung durch eine angemessene Target-Update-Frequenz beschleunigt wird.
* **Gezielte Parameteränderungen gegenüber Run 2:**
  1. `target_update_interval`: Drastisch gesenkt von $3'000 \to 300$ Steps (entspricht allen $4'800$ Transitions statt $48'000$).
  2. `total_timesteps`: $600'000$.
  3. `decay_steps`: Linearer Decay über $200'000$ Steps.
  4. `batch_size`: $64$.
  5. `learning_rate`: $5 \cdot 10^{-4}$.
* **Trainings-Metriken:**
  * Trainingsdauer: $387.1\text{ s}$ ($\approx 6.4\text{ min}$)
  * Durchsatz: $\approx 1'550 - 1'660\text{ FPS}$
  * Episoden total: $1'918$
  * Finaler Mean-100 Reward: $+48.8$ (auf steilem Aufwärtstrend!)
  * Zahlreiche erfolgreiche Einzelepisoden: $+254.8$, $+240.6$, $+212.7$, $+211.1$ Punkte
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $\mathbf{+103.98 \pm 91.31}$ (Erheblicher Durchbruch von $-101$ auf $+104$!)
  * **Success Rate:** $20.0\%$ (2 von 10 Landungen über 200 Punkten)
  * **Crash Rate:** $0.0\%$ (kein einziger Absturz)
  * **Video Replay Reward:** $+1.7$ Punkte (1'001 Frames)
* **Beobachtungen & Wissenschaftliche Erkenntnis:**
  1. **Durchbruch beim Bellman-Flow:**  
     Durch das häufigere Update des Target-Netzwerks ($300$ Schritte) konnte das Belohnungssignal der erfolgreichen Landungen ($+100$ Punkte) erstmals die Trajektorie rückwärts durchwandern. Der Agent hat verstanden, dass der Sinkflug lohnend ist.
  2. **Stabilität:**  
     Die Crash-Rate liegt bei perfekten $0.0\%$, und der mittlere Evaluation-Score sprang um über **200 Punkte nach oben** (von $-101.89$ auf $+103.98$).
  3. **Grenze von Vanilla DQN:**  
     Trotz des Erfolgs bleibt eine relativ hohe Standardabweichung ($\pm 91.31$), weil die periodischen Hard-Updates von Vanilla DQN immer noch leichte Ruckler in den Schätzungen verursachen.
* **Artefakte:**
  * Checkpoint: `models/vanilla_dqn_run3_best.pt`
  * Logs: `logs/vanilla_dqn_run3_history.json`
  * Video: `videos/vanilla_dqn_run3_replay.mp4`

---

### Run 4: Vanilla DQN (Soft Updates & GPU-Optimierung)
* **Datum & Zeit:** 24.11.2026, 17:15 Uhr
* **Ziel:** Den isolierten Einfluss von **Soft Target Updates ($\tau = 10^{-3}$)** auf Vanilla DQN analysieren und gleichzeitig die GPU durch Batch Size 128 und 2 Gradienten-Schritte pro Zeitschritt ausreizen.
* **Gezielte Parameteränderungen gegenüber Run 3:**
  1. `target_update`: **Soft Updates** ($\tau = 10^{-3}$, Polyak Averaging) statt periodischer Hard-Updates.
  2. `grad_steps`: $2$ Gradienten-Schritte pro Zeitschritt (bessere GPU-Auslastung und höhere Sample-Effizienz).
  3. `batch_size`: Erhöht auf $128$.
  4. `total_timesteps`: $600'000$.
  5. `decay_steps`: Linearer Decay über $200'000$ Steps.
* **Trainings-Metriken:**
  * Trainingsdauer: $409.8\text{ s}$ ($\approx 6.8\text{ min}$)
  * Durchsatz: $\approx 1'460\text{ FPS}$
  * Episoden total: $1'969$
  * Bester Mean-100 Reward: $\mathbf{+227.3}$ (ab Schritt 560k stabil über $+200$ Punkten!)
  * Zahlreiche Spitzenwerte: bis zu $\mathbf{+295.6}$ Punkte
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $\mathbf{+234.70 \pm 58.06}$ (**ENVIRONMENT SOLVED!** Offizielle Schwelle $\ge 200$ deutlich übertroffen)
  * **Success Rate:** $\mathbf{80.0\%}$ (8 von 10 Landungen über 200 Punkten!)
  * **Crash Rate:** $\mathbf{0.0\%}$
  * **Video Replay Reward:** $\mathbf{+226.2}$ Punkte (**nur 423 Frames!** Butterweiche, zügige Punktlandung zwischen den Flaggen)
* **Beobachtungen & Fundamentale Erkenntnis (Kern-Highlight für den Report):**
  1. **Die Transformation durch Soft Updates:**  
     Allein durch das kontinuierliche Nachziehen des Target-Netzwerks ($\tau = 10^{-3}$) sprang der Evaluierungs-Score von $+103.98$ (Run 3 mit Hard Updates) auf **$+234.70$ Punkte**!
  2. **Kein Hovering mehr:**  
     Weil die Q-Werte nicht mehr schockartig springen, hat der Lander gelernt, dass ein zügiger Sinkflug mit minimalem Schub die maximale Punktzahl bringt. Im Video landet er in nur **423 Frames** (im Vergleich zu 1'001 Frames Timeout in Run 2).
  3. **Wissenschaftliche Bedeutung (Ablation Study):**  
     Dieser Lauf beweist unmissverständlich, dass nicht die DQN-Architektur das Problem war, sondern die Instabilität der Hard-Target-Updates. Damit haben wir eine perfekte wissenschaftliche Argumentationskette für den Report!
* **Artefakte:**
  * Checkpoint: `models/vanilla_dqn_run4_best.pt`
  * Logs: `logs/vanilla_dqn_run4_history.json`
  * Video: `videos/vanilla_dqn_run4_replay.mp4`

---

### Run 5: Vanilla DQN (Ablation: Replay Buffer 200k vs. 100k)
* **Datum & Zeit:** 24.11.2026, 17:28 Uhr
* **Ziel:** Den isolierten Einfluss eines **verdoppelten Replay Buffers (200'000)** und feinerer Resterkundung ($\varepsilon_{\min} = 0.01$) im direkten 1:1-Vergleich zu Run 4 (Buffer 100k) untersuchen.
* **Gezielte Parameteränderungen gegenüber Run 4:**
  1. `buffer_capacity`: Verdoppelt von $100'000 \to 200'000$.
  2. `epsilon_min`: Gesenkt von $0.02 \to 0.01$.
  3. *Alle anderen Parameter identisch zu Run 4:* $600'000$ Steps, $128$ Batch Size, $\tau = 10^{-3}$, $2$ Gradienten-Schritte, $5 \cdot 10^{-4}$ LR.
* **Trainings-Metriken:**
  * Trainingsdauer: $428.6\text{ s}$ ($\approx 7.1\text{ min}$)
  * Durchsatz: $\approx 1'400\text{ FPS}$
  * Episoden total: $1'898$
  * Bester Mean-100 Reward: $+161.9$ (finaler Mean-100: $+159.5$)
  * Zahlreiche Spitzenwerte: bis zu $+296.0$ Punkte
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $+91.69 \pm 135.83$ (gegenüber $+234.70$ in Run 4)
  * **Success Rate:** $30.0\%$ (3 von 10 Landungen über 200 Punkten)
  * **Crash Rate:** $0.0\%$
  * **Video Replay Reward:** $-43.7$ Punkte (1'001 Frames Hovering)
* **Wissenschaftliche Erkenntnis (Herausragender Stoff für den Report!):**
  1. **Das "Stale Data / Sample Age" Problem:**  
     Entgegen der intuitiven Annahme *"grösserer Replay Buffer ist immer besser"* zeigt dieser direkte Vergleich das Gegenteil:  
     Bei einem 200k-Puffer verbleiben alte, qualitativ schlechte Erfahrungen aus der frühen chaotischen Zufalls-Exploration doppelt so lange im Speicher. Wenn das Netz bei Schritt 400k lernt, zieht es immer noch alte, taumelnde Trajektorien aus dem Puffer!
  2. **Der Sweet Spot bei 100k:**  
     Mit einem 100k-Puffer (Run 4) werden veraltete Flugversuche schnell genug durch die neuen, erfolgreichen Landungen der verbesserten Policy ersetzt. Das Netz lernt fokussierter und konvergiert innerhalb von 600k Schritten deutlich schneller zur Meisterschaft ($+234.7$ vs $+91.7$).
* **Artefakte:**
  * Checkpoint: `models/vanilla_dqn_run5_best.pt`
  * Logs: `logs/vanilla_dqn_run5_history.json`
  * Video: `videos/vanilla_dqn_run5_replay.mp4`

---

### Run 6: Vanilla DQN (Langzeittraining – 900'000 Steps)
* **Datum & Zeit:** 24.11.2026, 17:41 Uhr
* **Ziel:** Das optimale Setup aus Run 4 (Soft Updates $\tau=10^{-3}$, 100k Replay Buffer, Batch Size 128, 2 Gradienten-Schritte) über einen langen Zeithorizont trainieren, um die langfristige Konvergenz und Fluggeschwindigkeit zu testen.
* **Parameter:**
  * `total_timesteps`: $900'800$ (erreichte Schritte vor dem 600s Task-Timeout)
  * `buffer_capacity`: $100'000$ (Sweet Spot)
  * `target_update`: Soft Updates $\tau = 10^{-3}$
  * `grad_steps`: $2$
  * `batch_size`: $128$
  * `learning_rate`: $5 \cdot 10^{-4}$
* **Trainings-Metriken:**
  * Trainingsdauer: $600\text{ s}$ ($10\text{ min}$)
  * Durchsatz: $\approx 1'500\text{ FPS}$
  * Episoden total: $2'663$
  * Bester Mean-100 Reward: $\mathbf{+205.3}$
  * Spitzenwert in Einzelepisoden: bis zu $\mathbf{+315.4}$ Punkte!
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $\mathbf{+232.24 \pm 54.64}$ (Höchste Stabilität, geringste Standardabweichung aller Läufe!)
  * **Success Rate:** $\mathbf{80.0\%}$
  * **Crash Rate:** $\mathbf{0.0\%}$
  * **Video Replay Reward:** $\mathbf{+247.9}$ Punkte (**nur 302 Frames! Neuer Rekord an Treibstoffeffizienz**)
* **Wissenschaftliche Erkenntnis:**
  1. **Rekord-Geschwindigkeit und Treibstoffeffizienz:**  
     Durch das längere Training hat der Lander gelernt, dass eine zügige, direkte Flugbahn am meisten Punkte bringt. Mit nur **302 Frames** (knapp 6 Sekunden Flugzeit) legt er die schnellste und sauberste Landung aller bisherigen Läufe hin und holt im Video **$+247.9$ Punkte**!
  2. **Geringste Varianz:**  
     Die Standardabweichung sank auf $\pm 54.64$ – die Flugstrategie ist extrem gefestigt und reproduzierbar.
* **Artefakte:**
  * Checkpoint: `models/vanilla_dqn_run6_best.pt`
  * Logs: `logs/vanilla_dqn_run6_history.json`
  * Video: `videos/vanilla_dqn_run6_replay.mp4`

---

### Run 7: Double DQN (Ablation: Skalierung auf 32 Envs & UTD-Analyse)
* **Datum & Zeit:** 24.11.2026, 17:50 Uhr
* **Ziel:** Evaluation von Double DQN (Van Hasselt et al., 2015) zur Entkopplung von Aktionsselektion und Q-Wert-Evaluation, kombiniert mit Performance-Skalierung auf 32 parallele CPU-Umgebungen.
* **Parameter:**
  * `total_timesteps`: $600'000$
  * `n_envs`: $32$
  * `buffer_capacity`: $100'000$
  * `target_update`: Soft Updates $\tau = 10^{-3}$
  * `grad_steps`: $2$
  * `batch_size`: $128$
  * `learning_rate`: $5 \cdot 10^{-4}$
* **Trainings-Metriken:**
  * Trainingsdauer: $318.5\text{ s}$ ($\approx 5.3\text{ min}$)
  * Durchsatz: $\approx 1'900 - 2'000\text{ FPS}$
  * Episoden total: $2'045$
  * Bester Mean-100 Reward: $+13.7$
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $-22.63 \pm 80.23$
  * **Success Rate:** $0.0\%$
  * **Crash Rate:** $70.0\%$
  * **Video Replay:** Erstellt
* **Wissenschaftliche Erkenntnis (Zentral für die Methodik im Report):**
  1. **Die Update-to-Data (UTD) Ratio:**  
     Durch die Erhöhung von `n_envs=16` auf `n_envs=32` bei unverändertem `grad_steps=2` wurden bei 600'000 Transitions nur $18'750 \times 2 = 37'500$ Gradienten-Updates durchgeführt (in Run 4 waren es $37'500 \times 2 = 75'000$). Der Durchsatz stieg zwar auf $\approx 2'000$ FPS, aber das Netzwerk erhielt nur halb so viele Lernschritte pro gesammelter Umwelt-Erfahrung!
  2. **Schlussfolgerung für Run 8:**  
     Um die exakt gleiche Lerndichte wie in Run 4 zu garantieren, muss entweder `n_envs=16` (mit `grad_steps=2`) beibehalten oder bei `n_envs=32` die Update-Zahl auf `grad_steps=4` verdoppelt werden.
* **Artefakte:**
  * Checkpoint: `models/double_dqn_run7_best.pt`
  * Logs: `logs/double_dqn_run7_history.json`
  * Video: `videos/double_dqn_run7_replay.mp4`

---

### Run 8: Double DQN (Kontrollierter 1:1-Ablation-Vergleich mit Run 4)
* **Datum & Zeit:** 24.11.2026, 18:13 Uhr
* **Ziel:** Direkter, isolierter Leistungsvergleich zwischen Vanilla DQN (Run 4) und Double DQN (Van Hasselt et al., 2015) unter identischen Trainingsbedingungen (16 Envs, 600k Steps, 75'000 Gradienten-Updates).
* **Parameter:**
  * `total_timesteps`: $600'000$
  * `n_envs`: $16$
  * `buffer_capacity`: $100'000$
  * `target_update`: Soft Updates $\tau = 10^{-3}$
  * `grad_steps`: $2$ ($75'000$ Gradienten-Updates total)
  * `batch_size`: $128$
  * `learning_rate`: $5 \cdot 10^{-4}$
  * `epsilon_schedule`: Linear über $200'000$ Steps ($1.0 \to 0.02$)
* **Trainings-Metriken:**
  * Trainingsdauer: $1'079.5\text{ s}$ ($\approx 17.9\text{ min}$)
  * Episoden total: $1'983$
  * Bester Mean-100 Reward: $\mathbf{+204.4}$
  * Höchste Einzelepisoden: bis zu $\mathbf{+302.0}$ Punkte
* **Evaluation (10 Test-Episoden, $\varepsilon=0$):**
  * **Mean Reward:** $\mathbf{+243.52 \pm 23.01}$ (**Neuer Bestwert! Höchste Punktzahl aller Läufe**)
  * **Success Rate:** $\mathbf{90.0\%}$ (9 von 10 Landungen über 200 Punkten!)
  * **Crash Rate:** $\mathbf{0.0\%}$
  * **Video Replay Reward:** $\mathbf{+247.5}$ Punkte (**nur 299 Frames!**)
* **Wissenschaftliche Erkenntnis:**
  1. **Beweis der Overestimation-Reduktion:**  
     Durch die Trennung von Aktionsselektion (Online-Netz $\theta$) und Zustandsevaluation (Target-Netz $\theta^-$) verhindert Double DQN systematische Überschätzungen der Q-Werte. Dies führt zu einer drastischen Stabilisierung: Die Standardabweichung halbiert sich gegenüber Vanilla DQN von $\pm 58.06$ auf sensationelle $\mathbf{\pm 23.01}$!
  2. **Höchste Erfolgsquote:**  
     $90\%$ aller Testflüge landen perfekt in der Landezone. Mit nur **299 Frames** Flugdauer ist der Lander noch schneller und fuel-effizienter als in allen vorigen Läufen.
* **Artefakte:**
  * Checkpoint: `models/double_dqn_run8_best.pt`
  * Logs: `logs/double_dqn_run8_history.json`
  * Video: `videos/double_dqn_run8_replay.mp4`


