#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
gp_gui_calculator.py
A click-friendly PARI/GP-like calculator GUI built with Tkinter + cypari2.

Requirements:
  pip install cypari2

Usage:
  python gp_gui_calculator.py
"""

import sys
import tkinter as tk
from tkinter import ttk, messagebox

# Ensure cypari2 is available
try:
    from cypari2 import Pari
except Exception as e:
    raise SystemExit(
        "cypari2 ist nicht installiert.\n"
        "Installiere es mit:\n"
        "  pip install cypari2\n"
        f"Detail: {e}\n"
    )


class HelpWindow:
    def __init__(self, parent):
        self.window = tk.Toplevel(parent)
        self.window.title("PARI/GP Hilfe - Wie man rechnet")
        self.window.geometry("800x600")
        self.window.resizable(True, True)

        # Make it modal
        self.window.transient(parent)
        self.window.grab_set()

        self._build_help_ui()

    def _build_help_ui(self):
        # Main frame with scrollbar
        main_frame = ttk.Frame(self.window)
        main_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        # Create canvas and scrollbar
        canvas = tk.Canvas(main_frame)
        scrollbar = ttk.Scrollbar(main_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = ttk.Frame(canvas)

        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )

        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)

        # Pack canvas and scrollbar
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # Help content
        help_text = """
PARI/GP RECHNER - ANLEITUNG

═══════════════════════════════════════════════════════════════

📊 GRUNDRECHENARTEN
═══════════════════════════════════════════════════════════════
• Addition: 5 + 3
• Subtraktion: 10 - 4
• Multiplikation: 7 * 8
• Division: 15 / 3
• Potenz: 2^10
• Klammern: (5 + 3) * 2

📐 MODULO-ARITHMETIK
═══════════════════════════════════════════════════════════════
• Einfacher Rest: 17 % 5          → gibt: 2
• Modulo-Objekt: Mod(17, 5)       → gibt: Mod(2, 5)
• Addition: Mod(17, 5) + Mod(23, 5) → gibt: Mod(0, 5)
• Multiplikation: Mod(3, 7) * Mod(4, 7)
• Inverses: Mod(2, 11)^(-1)       → gibt: Mod(6, 11)

🧮 ZAHLENTHEORIE
═══════════════════════════════════════════════════════════════
• Größter gemeinsamer Teiler: gcd(98, 280)
• Kleinstes gemeinsames Vielfaches: lcm(12, 18)
• Primzahltest: isprime(97)
• n-te Primzahl: prime(100)
• Faktorisierung: factor(2^127-1)
• Euler'sche φ-Funktion: eulerphi(14)

🔢 MULTIPLIKATIVE GRUPPEN
═══════════════════════════════════════════════════════════════
• Gruppe Z*₁₄: znstar(14)
• Elemente von Z*₁₄: select(x->gcd(x,14)==1, [1..13])
• Generatoren: znstar(14).gen
• Ordnung eines Elements: znorder(Mod(3, 14))

🔍 PRIMZAHLEN & FAKTORISIERUNG
═══════════════════════════════════════════════════════════════
• Große Primzahl finden: nextprime(10^10)
• Mersenne-Zahlen: factor(2^61-1)
• Primzahl-Zählung: primepi(1000)
• Primfaktorzerlegung: factor(123456789)
  Primitivwurzel: znprimroot(17) (in Z*₁₇)
  Primitivwurzel(Z*1237): wie lässt sich aud der primitivwurzel 2, ein Element der Ordnung n bilden: lift(Mod(2,1237)^(1236/n))

📈 SPEZIELLE FUNKTIONEN
═══════════════════════════════════════════════════════════════
• Quadratwurzel: sqrt(2)
• Riemannsche Zeta-Funktion: zeta(2)
• Bernoulli-Zahlen: bernfrac(12)
• Fakultät: 10!
• Binomialkoeffizient: binomial(10, 3)

⚙️ ERWEITERTE EINSTELLUNGEN
═══════════════════════════════════════════════════════════════
• Präzision setzen: default(realprecision, 100)
• Primzahllimit: default(primelimit, 200000)
• Debug-Modus: default(debug, 1)


RSA Verschlüsselung
═══════════════════════════════════════════════════════════════
• Zwei große Primzahlen p, q generieren:
    p = nextprime(10^1000 + random(10^1000))
    q = nextprime(10^1000 + random(10^1000))
    
Anzahle mögliche Verschlüsselungsexponente e, N gegeben:
eulerphi(eulerphi(N))-1    

📋 PRAKTISCHE BEISPIELE
═══════════════════════════════════════════════════════════════

Beispiel 1 - Modulare Arithmetik:
    Berechne 3⁻¹ in Z₁₁:
    Eingabe: Mod(3, 11)^(-1)
    Ergebnis: Mod(4, 11)

Beispiel 2 - Große Zahlen faktorisieren:
    Eingabe: factor(2^127-1)
    Ergebnis: Faktorisierung der 127. Mersenne-Zahl

Beispiel 3 - Primzahltest:
    Eingabe: isprime(982451653)
    Ergebnis: 1 (ist Primzahl) oder 0 (ist zusammengesetzt)

Beispiel 4 - GGT und KGV:
    Eingabe: gcd(98, 280)
    Ergebnis: 14

    Eingabe: lcm(98, 280)
    Ergebnis: 1960

Beispiel 5 - Elemente einer multiplikativen Gruppe:
    Eingabe: select(x->gcd(x,14)==1, [1..13])
    Ergebnis: [1, 3, 5, 9, 11, 13]

Beispiel 6 - Ordnung in multiplikativer Gruppe:
    Eingabe: znorder(3, 14)
    Ergebnis: Ordnung von 3 in Z*₁₄

Beispiel 7 - Kombinierte Berechnungen:
    Eingabe: for(i=1, 10, print(prime(i), " ", isprime(i^2+1)))
    Ergebnis: Liste der ersten 10 Primzahlen und Test ob i²+1 prim ist

Beispiel 8 - Anzahl Ordnung(Modulo 17 die von 2 erzeugten untergruppe):
    Eingabe: znorder(Mod(2,17))
    Ergebnis: integer(8)
🔧 TIPPS & TRICKS

Beispiel 9 - Unterguppen (der von 2 in Z*₁₇ erzeugten Gruppe):
Eingabe: vector(8, k, lift(Mod(2,17)^(k-1)))
die 8 ist die Ordnung von 2 in Z*₁₇(siehe Beispiel 8)
Ergebnis: [1, 2, 4, 8, 16, 15, 13, 9, 1]
═══════════════════════════════════════════════════════════════
• Verwende Semikolon (;) für mehrere Befehle in einer Zeile
• Drücke Pfeil-hoch/runter für Befehlshistorie
• Shift+Enter für neue Zeile ohne Ausführung
• Klicke Buttons für häufig verwendete Funktionen
• Präzision anpassen für genauere Dezimalberechnungen

📞 HÄUFIGE FEHLER
═══════════════════════════════════════════════════════════════
• Vergessene Klammern bei Funktionen: sqrt(2) nicht sqrt 2
• Modulo mit 0: Mod(5, 0) ist ungültig
• Division durch 0: 5/0 gibt Fehler
• Zu große Zahlen ohne genügend Präzision

💡 KEYBOARD SHORTCUTS
═══════════════════════════════════════════════════════════════
• Enter: Berechnung ausführen
• Shift+Enter: Neue Zeile
• Pfeil hoch/runter: Verlauf durchblättern
• Strg+A: Alles markieren in Eingabefeld
"""

        # Add text to scrollable frame
        text_widget = tk.Text(scrollable_frame, wrap="word", font=("Consolas", 10),
                              bg="white", fg="black", padx=10, pady=10)
        text_widget.pack(fill="both", expand=True)
        text_widget.insert("1.0", help_text)
        text_widget.configure(state="disabled")

        # Close button
        close_frame = ttk.Frame(self.window)
        close_frame.pack(side=tk.BOTTOM, fill=tk.X, padx=10, pady=10)

        ttk.Button(close_frame, text="Schließen", command=self.window.destroy).pack(side=tk.RIGHT)
        ttk.Button(close_frame, text="Beispiele testen", command=self._load_examples).pack(side=tk.RIGHT, padx=(0, 10))

    def _load_examples(self):
        # This will be connected to parent window
        if hasattr(self, 'parent_callback'):
            examples = [
                "Mod(3, 11)^(-1)",
                "gcd(98, 280)",
                "select(x->gcd(x,14)==1, [1..13])",
                "factor(2^127-1)",
                "isprime(982451653)"
            ]
            for example in examples:
                self.parent_callback(example)
        self.window.destroy()


class GPApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("PARI/GP Klick-Rechner (cypari2)")
        self.geometry("920x620")
        self.minsize(820, 520)

        # PARI engine
        self.pari = Pari()
        self.realprecision = 38

        # History
        self.history = []
        self.history_index = None

        self._build_ui()
        self._set_precision(self.realprecision)

        # Show help window on startup
        self.after(500, self._show_help_on_startup)

    def _show_help_on_startup(self):
        """Show help window when application starts"""
        result = messagebox.askyesno(
            "Willkommen!",
            "Willkommen beim PARI/GP Rechner!\n\n"
            "Möchten Sie die Hilfe-Anleitung öffnen?\n"
            "Dort sehen Sie, wie Sie verschiedene mathematische\n"
            "Berechnungen eingeben können.",
            icon="question"
        )
        if result:
            self._show_help()

    def _build_ui(self):
        # Top bar: precision, version, clear, help
        top = ttk.Frame(self, padding=(8, 8))
        top.pack(side=tk.TOP, fill=tk.X)

        ttk.Label(top, text="Präzision (realprecision):").pack(side=tk.LEFT)
        self.prec_var = tk.IntVar(value=self.realprecision)
        self.prec_spin = ttk.Spinbox(top, from_=10, to=1000, textvariable=self.prec_var, width=6,
                                     command=self._on_precision_change)
        self.prec_spin.pack(side=tk.LEFT, padx=(6, 12))

        self.btn_set_prec = ttk.Button(top, text="Setzen", command=self._on_precision_change)
        self.btn_set_prec.pack(side=tk.LEFT)

        self.btn_version = ttk.Button(top, text="Version", command=self._show_version)
        self.btn_version.pack(side=tk.LEFT, padx=(12, 0))

        # Help button - prominently placed
        self.btn_help = ttk.Button(top, text="📖 Hilfe & Anleitung", command=self._show_help)
        self.btn_help.pack(side=tk.LEFT, padx=(12, 0))

        self.btn_clear_out = ttk.Button(top, text="Ausgabe leeren", command=self._clear_output)
        self.btn_clear_out.pack(side=tk.RIGHT)

        # Output box
        out_frame = ttk.LabelFrame(self, text="Ausgabe", padding=(8, 8))
        out_frame.pack(side=tk.TOP, fill=tk.BOTH, expand=True, padx=8, pady=(0, 8))

        self.txt_out = tk.Text(out_frame, wrap="word", height=16, undo=False)
        self.txt_out.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.txt_out.configure(state=tk.DISABLED)

        yscroll = ttk.Scrollbar(out_frame, orient=tk.VERTICAL, command=self.txt_out.yview)
        yscroll.pack(side=tk.RIGHT, fill=tk.Y)
        self.txt_out.configure(yscrollcommand=yscroll.set)

        # Input area
        input_frame = ttk.LabelFrame(self, text="Eingabe (Enter = Ausführen, Shift+Enter = neue Zeile)", padding=(8, 8))
        input_frame.pack(side=tk.TOP, fill=tk.BOTH, expand=False, padx=8, pady=(0, 8))

        self.txt_in = tk.Text(input_frame, wrap="word", height=5, undo=True)
        self.txt_in.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.txt_in.bind("<Return>", self._on_enter)
        self.txt_in.bind("<Shift-Return>", self._on_shift_enter)
        self.txt_in.bind("<Up>", self._on_up_history)
        self.txt_in.bind("<Down>", self._on_down_history)

        in_scroll = ttk.Scrollbar(input_frame, orient=tk.VERTICAL, command=self.txt_in.yview)
        in_scroll.pack(side=tk.RIGHT, fill=tk.Y)
        self.txt_in.configure(yscrollcommand=in_scroll.set)

        # Buttons panel
        btns = ttk.LabelFrame(self, text="Schnell-Eingabe", padding=(8, 8))
        btns.pack(side=tk.BOTTOM, fill=tk.X, padx=8, pady=(0, 8))

        # Row 1: numbers and basic ops
        row1 = ttk.Frame(btns)
        row1.pack(side=tk.TOP, fill=tk.X, pady=2)
        for label in ["7", "8", "9", "+", "-", "*", "/", "^", "(", ")"]:
            ttk.Button(row1, text=label, width=4, command=lambda t=label: self._insert(t)).pack(side=tk.LEFT, padx=2)

        # Row 2: common GP functions
        row2 = ttk.Frame(btns)
        row2.pack(side=tk.TOP, fill=tk.X, pady=2)
        funcs = [
            ("factor()", "factor()"),
            ("isprime()", "isprime()"),
            ("znorder(", "znorder("),
            ("gcd(", "gcd("),
            ("lcm(", "lcm("),
            ("sqrt(", "sqrt("),
            ("Mod(", "Mod("),
            ("prime(", "prime("),
            ("bernfrac(", "bernfrac("),
            ("zeta(", "zeta("),
        ]
        for label, token in funcs:
            ttk.Button(row2, text=label, command=lambda t=token: self._insert(t)).pack(side=tk.LEFT, padx=2)

        # Row 3: control buttons
        row3 = ttk.Frame(btns)
        row3.pack(side=tk.TOP, fill=tk.X, pady=2)
        ttk.Button(row3, text="Ausführen (Enter)", command=self._evaluate).pack(side=tk.LEFT, padx=2)
        ttk.Button(row3, text="Eingabe leeren", command=self._clear_input).pack(side=tk.LEFT, padx=8)
        ttk.Button(row3, text="Beispiel: gcd(98,280)", command=lambda: self._set_input("gcd(98, 280)")).pack(
            side=tk.LEFT, padx=2)
        ttk.Button(row3, text="Beispiel: Mod(2,11)^(-1)", command=lambda: self._set_input("Mod(2, 11)^(-1)")).pack(
            side=tk.LEFT, padx=2)

        # Status bar
        self.status = tk.StringVar(value="Bereit - Drücke '📖 Hilfe & Anleitung' für Beispiele!")
        status_bar = ttk.Label(self, textvariable=self.status, relief=tk.SUNKEN, anchor="w")
        status_bar.pack(side=tk.BOTTOM, fill=tk.X)

    # ---------- Actions ----------

    def _show_help(self):
        """Show the help window"""
        help_win = HelpWindow(self)
        # Set callback for loading examples
        help_win.parent_callback = self._set_input

    def _set_precision(self, n):
        try:
            n = int(n)
            self.pari(f"default(realprecision, {n})")
            self.realprecision = n
            self.status.set(f"realprecision = {n}")
        except Exception as e:
            self._append_output(f"[Fehler] Konnte Präzision nicht setzen: {e}\n")

    def _on_precision_change(self):
        self._set_precision(self.prec_var.get())

    def _show_version(self):
        try:
            v = self.pari("version()")
            messagebox.showinfo("PARI/GP Version", f"PARI/GP {v}")
        except Exception as e:
            messagebox.showerror("Fehler", str(e))

    def _append_output(self, text):
        self.txt_out.configure(state=tk.NORMAL)
        self.txt_out.insert(tk.END, text)
        self.txt_out.see(tk.END)
        self.txt_out.configure(state=tk.DISABLED)

    def _clear_output(self):
        self.txt_out.configure(state=tk.NORMAL)
        self.txt_out.delete("1.0", tk.END)
        self.txt_out.configure(state=tk.DISABLED)

    def _clear_input(self):
        self.txt_in.delete("1.0", tk.END)

    def _set_input(self, content):
        self._clear_input()
        self.txt_in.insert("1.0", content)
        self.txt_in.focus()

    def _insert(self, token):
        self.txt_in.insert(tk.INSERT, token)
        self.txt_in.focus()

    def _get_input_text(self):
        return self.txt_in.get("1.0", tk.END).strip()

    def _on_enter(self, event):
        # Enter: evaluate unless Shift is pressed
        self._evaluate()
        return "break"

    def _on_shift_enter(self, event):
        # Insert newline
        self.txt_in.insert(tk.INSERT, "\n")
        return "break"

    def _on_up_history(self, event):
        if not self.history:
            return "break"
        if self.history_index is None:
            self.history_index = len(self.history) - 1
        else:
            self.history_index = max(0, self.history_index - 1)
        self._set_input(self.history[self.history_index])
        return "break"

    def _on_down_history(self, event):
        if self.history_index is None:
            return "break"
        self.history_index = min(len(self.history) - 1, self.history_index + 1)
        self._set_input(self.history[self.history_index])
        return "break"

    def _evaluate(self):
        expr = self._get_input_text()
        if not expr:
            return

        # Update history
        self.history.append(expr)
        self.history_index = None

        # Split by semicolons if present, but keep simple: run each non-empty chunk
        chunks = [c.strip() for c in expr.split(";") if c.strip()]
        if not chunks:
            chunks = [expr]

        for chunk in chunks:
            self._append_output(f">>> {chunk}\n")
            try:
                res = self.pari(chunk)
                self._append_output(str(res) + "\n\n")
            except Exception as e:
                self._append_output(f"[Fehler] {e}\n\n")

        self.status.set("Fertig")


if __name__ == "__main__":
    app = GPApp()
    try:
        app.mainloop()
    except KeyboardInterrupt:
        pass