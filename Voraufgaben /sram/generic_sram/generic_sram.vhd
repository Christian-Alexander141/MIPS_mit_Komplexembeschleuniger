library work, ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;



entity sram is
generic (data_bits : integer := 8;
	 addr_bits : integer := 8;
	 tau : time := 10 ns);
port    (data_in    : in  signed(data_bits - 1 downto 0);
         read       : in  std_ulogic;
         write      : in  std_ulogic;
         clk        : in  std_ulogic;
         address    : in  unsigned(addr_bits - 1 downto 0);
         data_out   : out signed(data_bits - 1 downto 0));
end;



architecture a1 of sram is
begin
	process(clk)
		type ram_type is array((2**addr_bits)-1 downto 0) of signed(data_bits - 1 downto 0);
		variable ram : ram_type;
	begin
		if (clk'event and clk = '1') then
			if (read = '1') then
				data_out <= ram(conv_integer(address)) after tau;
			else	
				data_out <= (others => 'Z') after tau;
			end if;

			if (write = '1') then
				ram(conv_integer(address)) := data_in;
			end if;
		end if;
	end process;
end;