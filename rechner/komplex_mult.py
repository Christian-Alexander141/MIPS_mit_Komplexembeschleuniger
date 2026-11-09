#!/usr/bin/env python3
"""Rechner fuer die Multiplikation zweier komplexer Zahlen.

Eingabe z.B. als 3+4i, 3-4j, -2i oder 5. Mit q wird der Rechner beendet.
"""


class Beenden(Exception):
    pass


def lese_komplex(prompt):
    """Liest eine komplexe Zahl ein, bis die Eingabe gueltig ist."""
    while True:
        text = input(prompt).strip()
        if text.lower() == "q":
            raise Beenden
        try:
            # Python erwartet j als imaginaere Einheit und keine Leerzeichen
            return complex(text.replace(" ", "").replace("i", "j"))
        except ValueError:
            print("  Ungueltige Eingabe, Beispiel: 3+4i")


def formatiere(z):
    """Gibt z als a + bi aus."""
    vorzeichen = "-" if z.imag < 0 else "+"
    return f"{z.real:g} {vorzeichen} {abs(z.imag):g}i"


def binaer_signed(x, bits=4):
    """Gibt x als Zweierkomplement mit bits Stellen zurueck, sonst None."""
    minimum, maximum = -(2 ** (bits - 1)), 2 ** (bits - 1) - 1
    if x != int(x) or not minimum <= x <= maximum:
        return None
    # Maske bildet negative Zahlen auf ihr Zweierkomplement ab
    return format(int(x) & (2 ** bits - 1), f"0{bits}b")


def binaer_komplex(z, bits=4):
    """Obere bits Stellen: Realteil, untere bits Stellen: Imaginaerteil."""
    re, im = binaer_signed(z.real, bits), binaer_signed(z.imag, bits)
    if re is None or im is None:
        minimum, maximum = -(2 ** (bits - 1)), 2 ** (bits - 1) - 1
        return (f"nicht darstellbar (Re und Im ganzzahlig "
                f"in {minimum}..{maximum})")
    return f"{re}{im}  (Re {re} | Im {im})"


def main():
    print("Multiplikation komplexer Zahlen (Beenden mit q)")
    while True:
        try:
            z1 = lese_komplex("z1 = ")
            z2 = lese_komplex("z2 = ")
        except (Beenden, EOFError, KeyboardInterrupt):
            print("\nRechner beendet.")
            break

        # (a + bi)(c + di) = (ac - bd) + (ad + bc)i
        a, b = z1.real, z1.imag
        c, d = z2.real, z2.imag
        ergebnis = complex(a * c - b * d, a * d + b * c)

        print(f"({formatiere(z1)}) * ({formatiere(z2)}) = {formatiere(ergebnis)}")
        print(f"  Binaer: {binaer_komplex(ergebnis)}\n")


if __name__ == "__main__":
    main()
