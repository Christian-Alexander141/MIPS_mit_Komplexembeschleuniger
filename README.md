# MIPS_mit_Komplexembeschleuniger

Zur evaluation des im rahmen meiner Bachelorarbeit entwickelten vhdl agenten 
"Mensch gegen automatik" wird diese aufgabe zunächt händisch und anschliesend
von der Automatik entwickelt und bis auf das FPGA gebracht, die Entwicklungszeit wird dabei dokumentiert. 
Zur besseren vergleichbarketi wird der lauf bei der automatik 3 mal wiederholt 
sowohl die einzelwerte als auch der mittelwert wird angegeben. 



Projekt zur Anbindung eines Hardware-Beschleunigers für komplexe Zahlen an eine bestehende MIPS-CPU über ein Bus-System. Ziel ist der Vergleich der Entwicklungszeit und -qualität zwischen menschlicher Implementierung und KI-gestützter Entwicklung (VHDL-Agent).

---

## 📌 Projektübersicht
### Gegebene Komponenten
- **MIPS-CPU**: Bestehende Implementierung einer MIPS-Architektur (`MIPS/CPU`)
- **Bus-System**: Logische Busstruktur laut Abbildung unten

### Zu generierende Komponenten
Beschleuniger, Bus-Anbindung, UART-Testblock und Speicherblock (siehe unten).

#### 👤 Durch Mensch (Entwickler) zu implementieren:
- **Komplexzahl-Beschleuniger**: Hardware-Modul für Operationen mit komplexen Zahlen
- **Bus-Anbindung**: Integration des Beschleunigers in das bestehende Bus-System
- **UART-Testblock**: I/O-Einheit zum Laden von Assemblerskripten und Testen der Ausgaben
- **Speicherblock**: Externer Speicher (nicht im ursprünglichen Design enthalten)
---

## 🖼️ Architekturübersicht

![Busstruktur](Busstruktur_logisch(1).svg)

## 🏗️ Projektstruktur

```
MIPS_mit_Komplexembeschleuniger/
├── Busstruktur_logisch(1).svg   # Abbildung der Busstruktur
├── MIPS/                        # Menschliche Implementierung (siehe MIPS/Readme)
│   ├── CPU/                     # Bestehende MIPS-CPU
│   ├── soc_top.vhd              # Bus (bisher Democode)
│   ├── RAM/                     # Speicherblock
│   ├── UART/                    # UART-Testblock
│   └── KomplexerBeschläuniger/  # Komplexzahl-Beschleuniger
├── Voraufgaben /                # Vorübungen (siehe Voraufgaben /README)
│   ├── addierer/                # 4-Bit-Addierer
│   ├── KomplexMult/             # Komplexmultiplikation
│   ├── sram/                    # Übung 9: generischer SRAM
│   ├── rechner/                 # Python-Kontrollrechner
│   └── KomplexerBeschleuniger_demo/
└── README.md
```

Geplant, aber noch nicht angelegt: Test-Assemblerskripte und Benchmarks, Constraint-Files für
das Gesamtsystem, Zeitdokumentation (Mensch / KI-Agent) und die KI-generierten Komponenten.

---

## 🧪 Versuchsablauf

### Phase 1: Menschliche Implementierung
1. **Aufgabenanalyse**: Anforderungen an den Komplexzahl-Beschleuniger definieren
2. **Implementierung**: 
   - Entwicklung des Beschleuniger-Moduls in VHDL
   - Anbindung an das Bus-System
   - Integration der gegebenen Komponenten (MIPS, Bus)
3. **Constraint-File**: Erstellung der FPGA-spezifischen Constraints
4. **Testing**:
   - Assemblerskripte über UART laden
   - Funktionalität des Beschleunigers verifizieren
   - Ausgaben über UART testen
5. **Dokumentation**: Entwicklungszeit von Projektstart bis zum ersten erfolgreich durchgelaufenen Assemblerskript

✅ **Abschlusskriterium**: Erfolgreicher Test aller geplanten Assembler-Operationen

### Phase 2: KI-gestützte Implementierung (VHDL-Agent)
1. **Aufgabenstellung**: Gleiche Anforderungen wie Phase 1
2. **Autonome Entwicklung**:
   - Beschreibung der Aufgabe an den VHDL-Agent
   - Agent entwickelt Beschleuniger und Bus-Anbindung
3. **Integration**: Einbindung der KI-generierten Komponenten (UART, Speicher)
4. **Testing**:
   - Identische Testprozedur wie Phase 1
   - UART-basierte Verifikation
5. **Dokumentation**: Entwicklungszeit von Aufgabenstellung bis zum besten Test

✅ **Abschlusskriterium**: Erfolgreicher Test aller geplanten Operationen

---

## 📊 Dokumentation

### Zeiterfassung
Beide Phasen werden detailliert dokumentiert:
- **Startzeitpunkt**: Beginn der Implementierung
- **Meilensteine**: Wichtige Fortschritte (z.B. erste kompilierbare Version, erste erfolgreiche Simulation)
- **Endzeitpunkt**: Erstes erfolgreiches Assemblerskript / bestätigter Test
- **Gesamtzeit**: Summe der aktiven Entwicklungszeit

### Metriken zum Vergleich
| Metrik | Mensch | VHDL-Agent |
|--------|--------|-------------|
| Entwicklungszeit | [zu dokumentieren] | [zu dokumentieren] |
| Codezeilen | [zu dokumentieren] | [zu dokumentieren] |
| Testabdeckung | [zu dokumentieren] | [zu dokumentieren] |
| Ressourcenverbrauch (FPGA) | [zu dokumentieren] | [zu dokumentieren] |

Entwicklungsbegin Mensch 09.11.26: 11Uhr
* recherche anbindung einer cpu an einen bus 
* durchgehen der vorübungen 

---

## 🔧 Technische Anforderungen

### Komplexzahl-Beschleuniger
- **Funktionen**: Addition, Subtraktion, Multiplikation, Division komplexer Zahlen
- **Datenformat**: zu definieren (z.B. IEEE 754 Single-Precision für Real-/Imaginärteil)
- **Schnittstelle**: Bus-kompatibles Interface

### Bus-System
- **Protokoll**: Zu dokumentieren (Adressierung, Datenbreite, Steuerungssignale)
- **Arbitrierung**: Mechanismus für gleichzeitige Zugriffe

### UART-Testblock
- **Baudrate**: Konfigurierbar (z.B. 115200 baud)
- **Protokoll**: Einfaches Textprotokoll für Assembler-Übertragung

### Speicherblock
- **Kapazität**: Ausreichend für Test-Assemblerskripte (z.B. 8KB)
- **Zugangszeit**: Kompatibel mit MIPS-Timing

---

## 🚀 Deployment

### Tools
- **Simulator**: GHDL (VHDL-2008) mit GTKWave zur Wellenformansicht
- **Synthese und Place & Route**: GHDL + yosys und openXC7 (`nextpnr-xilinx`), wie in den Voraufgaben verwendet
- **Laden auf das FPGA**: `openFPGALoader`
- **Alternativ**: Vivado (Xilinx) für Synthese und Implementierung
- **Hardware**: Arty S7-50 (`xc7s50csga324-1`), wie in den Voraufgaben verwendet; für das Gesamtsystem zu bestätigen

### Simulation (Beispiel `Voraufgaben /sram`)

```bash
mkdir -p sim
ghdl -a --std=08 --workdir=sim sram.vhd sram_tb.vhd
ghdl -e --std=08 --workdir=sim -o sim/sram_tb sram_tb
./sim/sram_tb --wave=sim/sram_tb.ghw
gtkwave sim/sram_tb.ghw
```

Weitere Hinweise (FPGA-Skript `fpga.sh`) stehen in `Voraufgaben /README`.

---

## 📝 Changelog

| Datum | Version | Änderungen |
|-------|---------|------------|
| [TT.MM.JJJJ] | 0.1 | Initiales Projekt-Setup |
| [TT.MM.JJJJ] | 0.2 | Menschliche Implementierung abgeschlossen |
| [TT.MM.JJJJ] | 0.3 | KI-Implementierung abgeschlossen |
| [TT.MM.JJJJ] | 1.0 | Vergleichsdokumentation final |

---

