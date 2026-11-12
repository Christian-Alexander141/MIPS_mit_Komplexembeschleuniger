-- nur democode keine fertige implementierung  !
-- die soc top ist eigentlich die implementierung des bus
-- da bus in vhdl ein schlüsselwort ist darf es in der entity nicht verwendet werden
-- in der folge wird die datei als soc_top.vhd bezeichnet und die entity als soc_top


library ieee; 
use ieee.std_logic_1164.all;

entity soc_top is
    port (
        clk : in std_logic;
        rst : in std_logic;
        addr : in std_logic_vector(7 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        we : in std_logic
    );
end entity soc_top;

architecture rtl of soc_top is
    signal mem : std_logic_vector(255 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            mem <= (others => '0');
        elsif rising_edge(clk) then
            if we = '1' then
                mem(to_integer(unsigned(addr))) <= data_in;
            end if;
            data_out <= mem(to_integer(unsigned(addr)));
        end if;
    end process;
end architecture rtl;