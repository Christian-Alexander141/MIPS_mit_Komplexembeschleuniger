
library work, ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.ram_pack.all; 


entity SRAM is 



port( clk 	  : 	in std_logic;
     data_in  : 	in signed (data_bits-1 downto 0);
     address  : 	in unsigned (addr_bits-1 downto 0);
	 read	  : 	in std_ulogic;
	 write    : 	in std_ulogic;
	 data_out : 	out signed (data_bits-1 downto 0));
end;


architecture behavior of SRAM is 

type memory_type is ARRAY (2**addr_bits-1 downto 0 ) of signed (integer range data_bits-1 downto 0); 
signal memory : memory_type;

begin 

	process
	begin 
	
	
	 wait until clk = '1'; 
		
		data_out <= (others => 'Z');
		
		if (read = '1') then 
			data_out <= memory(CONV_INTEGER (address));
		end if;
		
		if (write = '1' ) then 
			memory(CONV_INTEGER (address)) <= data_in ;
		
		end if;
	end process;	
	
end;