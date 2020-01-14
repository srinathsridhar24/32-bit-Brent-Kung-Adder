library ieee;
use ieee.std_logic_1164.all;

entity my_not is 
	port (ip: in std_logic;
			op: out std_logic);
end my_not;

architecture arch of my_not is begin
	op <= not ip after 100 ps; -- gate delay of inverter is given as 100 ps
end arch;
