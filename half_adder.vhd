library ieee;
use ieee.std_logic_1164.all;

entity half_adder is 
	port (a,b : in std_logic;
			sha: out std_logic;
			cha: out std_logic);
end half_adder;

architecture arch_halfadder of half_adder is begin
	sha <= a xor b after 200 ps;
	cha <= a and b after 250 ps;
end arch_halfadder;