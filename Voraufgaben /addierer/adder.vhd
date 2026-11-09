library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    port(
        a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        sum : out std_logic_vector(4 downto 0)
    );
end entity adder;

architecture rtl of adder is
    signal a_unsigned,b_unsigned : unsigned(3 downto 0);
    signal out_sum : unsigned(4 downto 0);
begin
    a_unsigned <= unsigned(a);
    b_unsigned <= unsigned(b);
    out_sum <= ('0' & a_unsigned) + ('0' & b_unsigned);
    sum <= std_logic_vector(out_sum);

end architecture rtl;
