library ieee;
use ieee.std_logic_1164.all;

entity my_xor is 
	port(a,b: in std_logic;
			x: out std_logic);
end my_xor;

architecture arch of my_xor is begin
	x <= a xor b after 200 ps; -- delay of tiny XOR is given as 200 ps
end arch;

