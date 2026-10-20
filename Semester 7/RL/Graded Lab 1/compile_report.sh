#!/bin/bash
set -e

# Wechsel ins Verzeichnis des Skripts
cd "$(dirname "$0")"

# 1. Prüfen, ob pandoc installiert ist, andernfalls via Homebrew installieren
if ! command -v pandoc &> /dev/null; then
    echo "pandoc wurde nicht gefunden. Versuche Installation via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install pandoc
    else
        echo "FEHLER: Weder 'pandoc' noch 'brew' (Homebrew) gefunden."
        echo "Bitte installiere pandoc manuell: https://pandoc.org/installing.html"
        exit 1
    fi
fi

# 2. Prüfen, ob xelatex (TeX-Distribution) verfügbar ist
if ! command -v xelatex &> /dev/null; then
    echo "FEHLER: 'xelatex' wurde nicht im PATH gefunden."
    echo "Für macOS kannst du TeX z.B. installieren via:"
    echo "  brew install --cask basictex"
    exit 1
fi

# 3. Kompilieren des Reports
echo "Kompiliere Graded-Lab-1_jakabnat+bratsjon_Report.md zu PDF..."
pandoc -s Graded-Lab-1_jakabnat+bratsjon_Report.md --pdf-engine=xelatex -o Graded-Lab-1_jakabnat+bratsjon_Report.pdf

echo "Erfolgreich erstellt: Graded-Lab-1_jakabnat+bratsjon_Report.pdf"

# 4. Seitenzahl ausgeben (falls pdfinfo vorhanden ist)
if command -v pdfinfo &> /dev/null; then
    pdfinfo Graded-Lab-1_jakabnat+bratsjon_Report.pdf | grep "Pages:"
fi
