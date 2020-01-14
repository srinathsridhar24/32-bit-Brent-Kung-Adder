library ieee;
use ieee.std_logic_1164.all;

entity my_func is 
	port (a,b,c: in std_logic;
				x: out std_logic);
end my_func;

architecture arch of my_func is begin
	x <= not (A or (B and C)) after 200 ps; --delay of the function not(A+BC) is given as 200 ps
end arch;	
