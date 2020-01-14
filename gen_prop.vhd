library ieee;
use ieee.std_logic_1164.all;
use ieee. std_logic_unsigned.all;

entity gen_prop is 
	port( in1, in2: in std_logic;
				G, P: out std_logic);
end gen_prop;

architecture arch of gen_prop is
	component my_nand is 
		port(in1, in2: in std_logic;
		  op: out std_logic);
	end component;
	
	component my_not is 
		port(ip: in std_logic;
			  op: out std_logic);
		end component;
		
	component my_xor is
		port(a,b: in std_logic;
			x: out std_logic);
		end component;
	
	signal tmp: std_logic;
 
 begin
	
	nand_inst: my_nand port map (in1 => in1, in2 =>in2, op => tmp);
	not_inst: my_not port map (ip => tmp, op => G); --finding G
	xor_inst: my_xor port map(a => in1, b =>in2, x=>P); -- finding P
end arch;	

	
		
			