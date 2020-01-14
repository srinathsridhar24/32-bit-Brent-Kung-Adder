library ieee;
use ieee.std_logic_1164.all;

entity my_nand is 
	port(in1, in2: in std_logic;
		  op: out std_logic);
end my_nand;

architecture arch of my_nand is begin
	op <= in1 nand in2 after 150 ps; -- gate delay of nand gate is given as 150 ps
end arch;

