library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
	port (A,B,C: in std_logic;
			sum, Cout: out std_logic);
end full_adder;

architecture arch_fulladder of full_adder is 
	signal tmp: std_logic;

begin

	sum <= (A xor B) xor C after 400 ps;
	Cout <= (A and B) or (C and (A or B)) after 400 ps;

end arch_fulladder;
