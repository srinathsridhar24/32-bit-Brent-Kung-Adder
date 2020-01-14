library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity prefix is 
	port (Gin1,Gin2, Pin1, Pin2: in std_logic;
			G_out,P_out: out std_logic);
end prefix;

architecture arch_prefix of prefix is 

	component my_nand is 
		port(in1, in2: in std_logic;
		  op: out std_logic);
	end component;
	
	component my_not is 
		port(ip: in std_logic;
			  op: out std_logic);
		end component;

	component my_func is 
		port(a,b,c: in std_logic;
				x: out std_logic);
		end component;
		
	signal tmp1, tmp2: std_logic;	

begin

func_inst: my_func port map( a => Gin2, b => Pin2, c=> Gin1, x => tmp1);
not_inst1: my_not port map ( ip => tmp1, op => G_out); -- finding G_out

nand_inst: my_nand port map (in1 => Pin2, in2 => Pin1, op => tmp2);
not_inst2: my_not port map (ip => tmp2, op => P_out); -- finding P_out
end arch_prefix;

	
	