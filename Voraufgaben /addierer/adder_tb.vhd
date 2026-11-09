library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- uut = unid under test


-- definieren der entity adder
entity adder_tb is
end entity adder_tb;

architecture rtl of adder_tb is

    -- signale definieren 
    signal a : std_logic_vector(3 downto 0);
    signal b : std_logic_vector(3 downto 0);
    signal sum : std_logic_vector(4 downto 0);

begin

    -- Direct Entity Instantiation

    uut: entity work.adder
    port map(
        a   => a,
        b   => b,
        sum => sum
    );


    stim: process
    begin
        a <= "0010"; 
        b <= "0011"; 
        wait for 10 ns;
        assert sum = "00101" 
        report "Test failed for a=0010, b=0011" 
        severity error;

        -- test 2
        a <= "0001";
        b <= "1111";
        wait for 10 ns;
        assert sum = "10000"
        report "Test failed for a=0001, b=1111"
        severity error;
        
        report "Test 1 erfolgreich!" severity note;

        wait;

    end process stim;

end architecture rtl;
