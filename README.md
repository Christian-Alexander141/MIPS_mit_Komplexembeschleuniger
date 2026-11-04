# MIPS_mit_Komplexembeschleuniger

Projekt zur Anbindung eines Hardware-Beschleunigers für komplexe Zahlen an eine bestehende MIPS-CPU über ein Bus-System. Ziel ist der Vergleich der Entwicklungszeit und -qualität zwischen menschlicher Implementierung und KI-gestützter Entwicklung (VHDL-Agent).

---

## 📌 Projektübersicht

### Gegebene Komponenten
- **MIPS-CPU**: Bestehende Implementierung einer MIPS-Architektur
- **Bus-System**: Kommunikationsinfrastruktur zur Anbindung externer Module an die CPU

### Zu generierende Komponenten

#### 🤖 Durch Claude/KI zu generieren:
- **UART-Testblock**: I/O-Einheit zum Laden von Assemblerskripten und Testen der Ausgaben
- **Speicherblock**: Externer Speicher (nicht im ursprünglichen Design enthalten)

#### 👤 Durch Mensch (Entwickler) zu implementieren:
- **Komplexzahl-Beschleuniger**: Hardware-Modul für Operationen mit komplexen Zahlen
- **Bus-Anbindung**: Integration des Beschleunigers in das bestehende Bus-System

---

## 🖼️ Architekturübersicht

![Busstruktur](Busstruktur_logisch(1).svg)

## 🏗️ Projektstruktur

```
MIPS_mit_Komplexembeschleuniger/
├── src/
│   ├── mips_cpu/           # Bestehende MIPS-CPU
│   ├── bus_system/         # Gegebenes Bus-System
│   ├── accelerator/        # Komplexzahl-Beschleuniger (menschl. Implementierung)
│   ├── uart/               # UART-Testblock (KI-generiert)
│   └── memory/             # Speicherblock (KI-generiert)
├── test/
│   ├── assembly/           # Test-Assemblerskripte
│   └── benchmarks/         # Performance-Tests
├── constraints/            # Constraint-Files für FPGA
├── docs/                   # Dokumentation & Entwicklungsprotokolle
│   ├── human_development/  # Zeitdokumentation menschl. Entwicklung
│   └── agent_development/  # Zeitdokumentation KI-Entwicklung
├── vivado/                 # Vivado-Projektdateien
└── README.md
```

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
- **Vivado**: Xilinx Vivado für FPGA-Synthese und Implementierung
- **Simulator**: ModelSim/Vivado Simulator für Verifikation
- **Hardware**: Ziel-FPGA (zu spezifizieren)

### Workflow
```bash
# 1. Synthese
vivado -mode batch -source synth.tcl

# 2. Implementierung
vivado -mode batch -source impl.tcl

# 3. Bitstream-Generierung
vivado -mode batch -source bitstream.tcl

# 4. Flashen
# (Hardware-spezifisch)
```

---

## 📝 Changelog

| Datum | Version | Änderungen |
|-------|---------|------------|
| [TT.MM.JJJJ] | 0.1 | Initiales Projekt-Setup |
| [TT.MM.JJJJ] | 0.2 | Menschliche Implementierung abgeschlossen |
| [TT.MM.JJJJ] | 0.3 | KI-Implementierung abgeschlossen |
| [TT.MM.JJJJ] | 1.0 | Vergleichsdokumentation final |

---

## 🤝 Beitrag

1. Fork des Repositories
2. Branch für neue Features (`git checkout -b feature/[name]`)
3. Commit der Änderungen (`git commit -m 'Add some feature'`)
4. Push zum Branch (`git push origin feature/[name]`)
5. Pull Request erstellen

---

## 📜 Lizenz

[Hier Lizenzinformationen einfügen, z.B. MIT, Apache 2.0 etc.]

---

## 📞 Kontakt

Bei Fragen oder Anregungen:
- [Ihr Name] - [Ihre E-Mail]
- Projekt-Link: [GitHub-Repository]
