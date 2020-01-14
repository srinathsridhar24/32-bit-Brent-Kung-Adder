library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity carry_gen is 
	port (Gin, Pin, cy_in: in std_logic;
			cy_out: out std_logic);
end carry_gen;

architecture arch of carry_gen is 

	component my_not is 
		port(ip: in std_logic;
			  op: out std_logic);
		end component;

	component my_func is 
		port(a,b,c: in std_logic;
				x: out std_logic);
		end component;
	
	signal tmp: std_logic;
		
begin
func_inst: my_func port map (a => Gin, b => Pin, c=> cy_in, x=> tmp);
not_inst: my_not port map (ip => tmp, op => cy_out); --finding cy_out
end arch;

