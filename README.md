# Slide per tesi triennale su Quantum metrology

Codice typst per la generazione delle slide che ho usato per la mia tesi triennale in Fisica all'Università di Pisa con titolo *Quantum metrology enhancement through quantum processing*, con relatore il professor V. Giovannetti.

Il PDF finale compilato è consultabile qui: [`SlidesArtico.pdf`](SlidesArtico.pdf).

Per compilare in typst esegui:

```bash
typst compile --font-path fonts main.typ SlidesArtico.pdf
```

Per generare l'immagine di GW150914 esegui:
```bash
cd generazione_immagini
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python immagine.py
```