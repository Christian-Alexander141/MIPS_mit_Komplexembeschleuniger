library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- NOTIZ (Korrektur 04.11.2026):
--  Fehler:   "use ieee.numeric_std.all;" fehlte. Ohne diese Bibliothek ist der
--            Typ signed unbekannt -> ghdl: no declaration for "signed".
--  Geaendert: Zeile "use ieee.numeric_std.all;" ergaenzt.
--  Hinweis:  Ueberlauf moeglich: a = b = -2-2i ergibt Im = +8, passt nicht in
--            4 Bit signed (-8..7) und wird als -8 ausgegeben.

-- schaltung zur multiplikation zweier koplexer zahlen 
--  a 2 bit realteil, 2 bit imag teil
--  b 2 bit realteil, 2 bit imag teil
--  c 4 bit realteil, 4 bit imag teil

entity complexmult is
    port(
        a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        c : out std_logic_vector(7 downto 0)
    );
end entity complexmult;

architecture rtl of complexmult is
    -- signale definieren
    -- a und b.
    -- hinweis : die real und imaginärteile werden durchnummeriert a,b,c,d sie sind nicht identisch mit den signalen a,b,c,d der entity!
    signal a_real, b_imag, c_real, d_imag : std_logic_vector(1 downto 0);
    -- c
    signal real_part, imag_part : std_logic_vector(3 downto 0);

    begin
        a_real <= a(3 downto 2);
        b_imag <= a(1 downto 0);
        
        c_real <= b(3 downto 2);
        d_imag <= b(1 downto 0);
   
        -- multiplikation der komplexen zahlen (a*c-b*d) + (a*d+b*c)i
        real_part <= std_logic_vector(signed(a_real) * signed(c_real) - signed(b_imag) * signed(d_imag));
        imag_part <= std_logic_vector(signed(a_real) * signed(d_imag) + signed(b_imag) * signed(c_real));
        c <= real_part & imag_part;
        

end architecture rtl;
