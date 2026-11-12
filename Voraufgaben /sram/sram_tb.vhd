library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity sram_tb is
end entity sram_tb;


architecture tb of sram_tb is
    
    constant data_bits : integer := 32;
    constant addr_bits : integer := 8;
    
    signal clk_s      : std_logic := '0';
    signal write_S    : std_ulogic := '0';
    signal read_s     : std_ulogic := '0';
    signal address_S  : unsigned(31 downto 0) := (others => '0');
    signal data_in_s  : std_logic_vector(data_bits-1 downto 0) := (others => '0');
    signal data_out_s : std_logic_vector(data_bits-1 downto 0);
    signal finished     : boolean := false;
begin
    uut: entity work.sram
        generic map (
            data_bits => data_bits,
            addr_bits => addr_bits
        )
        port map (
            clk      => clk_s,
            write    => write_S,
            read     => read_s,
            address  => address_S,
            data_in  => data_in_s,
            data_out => data_out_s
        );
    

    -- Takt: kippt alle 5 ns -> Periode 10 ns (100 MHz)
    clk_s <= not clk_s after 5 ns when not finished else unaffected;

    stim: process
    begin
        wait until rising_edge(clk_s);


        -- Test 1: write
        address_S <= x"00000000";
        data_in_s <= x"DEADBEEF";
        write_S <= '1';
        wait until rising_edge(clk_s);   -- hier schreibt der Speicher
        write_S <= '0';

        -- Test 2: read
        read_s <= '1';
        wait until rising_edge(clk_s);   -- hier liest der Speicher
        read_s <= '0';
        wait until rising_edge(clk_s);   -- data_out ist jetzt stabil
        assert data_out_s = x"DEADBEEF"
        report "Test failed for read at address 0x00000000"
        severity error;

        report "done";
        finished <= true;

        wait;

    end process stim;

end architecture tb;
