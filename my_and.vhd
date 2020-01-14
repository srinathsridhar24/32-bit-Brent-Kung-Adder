library ieee;
use ieee.std_logic_1164.all;

entity my_and is 
	port (ip1: in std_logic;
			ip2: in std_logic;
			opt: out std_logic);
end my_and;

architecture arch of my_and is 
	component my_not is 
		port (ip: in std_logic;
				op: out std_logic);
	end component;
	
	component my_nand is 
		port (in1, in2: in std_logic;
				op: out std_logic);
	end component;
	
	signal tmp: std_logic;
	
begin

my_nand_inst: my_nand port map (in1 => ip1, in2 => ip2, op => tmp);
my_not_inst: my_not port map(ip => tmp , op => opt);

end arch;