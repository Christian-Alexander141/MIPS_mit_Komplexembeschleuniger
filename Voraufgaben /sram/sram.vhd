library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram is
    generic (
        constant data_bits : integer := 32;  -- Breite eines Wortes (MIPS: 32 Bit)
        constant addr_bits : integer := 8    -- Anzahl Wortadressbits: 2**8 = 256 Worte = 1 KB
    );
    port (
        clk      : in  std_logic;
        write    : in  std_ulogic;                            -- Schreiben aktiv ('1')
        read     : in  std_ulogic;                            -- Lesen aktiv ('1')
        address  : in  unsigned(31 downto 0);                 -- Byte-Adresse von der CPU
        data_in  : in  std_logic_vector(data_bits-1 downto 0);
        data_out : out std_logic_vector(data_bits-1 downto 0)
    );
end entity sram;

architecture rtl of sram is
    constant words : integer := 2**addr_bits;
    type ram_tipe is array (0 to words-1) of std_logic_vector(data_bits-1 downto 0);
    -- das äußere others gilt für alle Worte, das innere setzt jedes Bit auf 0
    signal ram : ram_tipe := (others => (others => '0'));
begin

    process(clk)
        --vorsicht variable nicht auserhalb des declarationsbereichs verwenden, da sie sonst nicht initialisiert wird
        --Hinweis : im falle von idx wirt ein wertebreich definiert.
        --vorsicht reihenfolge ist egal aber to zählt aufwärts und downto abwärts!
        variable idx : integer range words-1 downto 0;
    begin
        if rising_edge(clk) then
            -- die untern 2 bits sind byte offste in MIPS werden daher nicht gebraucht,
            -- welches der 4 Worte in einem 32 Bit Wort adressiert wird, wird durch die oberen 2 Bits der Byteadresse bestimmt.
            idx := to_integer(address(addr_bits+1 downto 2));

            if write = '1' then
                ram(idx) <= data_in;
            end if;
            if read = '1' then
                data_out <= ram(idx);   -- Read-first: bei gleicher Adresse wird der alte Wert gelesen
            end if;
        end if;
    end process;

end architecture rtl;
