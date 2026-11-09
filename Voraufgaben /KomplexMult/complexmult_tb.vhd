library ieee;
use ieee.std_logic_1164.all;

-- NOTIZ (Korrektur 04.11.2026):
--  Fehler 1: "end architecture rtl;" fehlte am Dateiende -> Syntaxfehler.
--  Fehler 2: Falsche Erwartungswerte. Real- und Imaginaerteil der Eingaenge
--            sind 2 Bit signed, Wertebereich -2..1 ("11" = -1, nicht 3).
--            Test 1: a = -2i, b = -i      -> c = -2 + 0i = "11100000"
--                    (erwartet war "10100000" = -6 + 0i)
--            Test 2: a = i,   b = -1 - i  -> c =  1 - 1i = "00011111"
--                    (erwartet war "11010011" = -3 + 3i, b ist nicht 3 + 3i)
--  Geaendert: Erwartungswerte und Kommentare der Tests korrigiert,
--            "end architecture rtl;" ergaenzt.

entity complexmult_tb is
end entity complexmult_tb;

architecture rtl of complexmult_tb is

    -- signale definieren 
    signal a : std_logic_vector(3 downto 0);
    signal b : std_logic_vector(3 downto 0);
    signal c : std_logic_vector(7 downto 0);

    begin

    -- Direct Entity Instantiation
    uut: entity work.complexmult
    port map(
        a => a,
        b => b,
        c => c
    );

    stim: process
    begin
        -- achtung alle werte sind sigend nicht unsigend :
        -- +6 binär hinschreiben: 0110
        --Alle Bits invertieren: 1001
        --1 addieren: 1010

        -- test 1
        -- a = -2i
        -- b = -i
        -- c = -2 + 0i
        a <= "0010";
        b <= "0011";
        wait for 10 ns;
        assert c = "11100000"
        report "Test failed for a=0010, b=0011"
        severity error;

        -- test 2
        -- a =  1i
        -- b = -1 - 1i
        -- c = 1 - 1i
        a <= "0001";
        b <= "1111";
        wait for 10 ns;

        assert c = "0001 1111"
        report "Test failed for a=0001, b=1111"
    
        severity error;
        
        report "Test 1 erfolgreich!" severity note;
    
        wait;
    end process stim;

end architecture rtl;

