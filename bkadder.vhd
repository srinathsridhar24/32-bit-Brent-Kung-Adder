library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bkadder is 
	port (A, B: in std_logic_vector(31 downto 0);
			Cin: in std_logic;
			sum: out std_logic_vector(31 downto 0);
			Cout: out std_logic);
end bkadder;

architecture arch_bkadder of bkadder is 
	component gen_prop is 
		port( in1, in2: in std_logic;
				G, P: out std_logic);
	end component;
		
	component prefix is 
		port (Gin1,Gin2, Pin1, Pin2: in std_logic;
				G_out,P_out: out std_logic);
	end component;
	
	component carry_gen is 
		port (Gin, Pin, cy_in: in std_logic;
			cy_out: out std_logic);
   end component;
	
	signal G0,P0: std_logic_vector(31 downto 0); --zeroth stage generates and propagates
	signal G1,P1: std_logic_vector(15 downto 0); --first stage generates and propagates
	signal G2,P2: std_logic_vector(7 downto 0); --second stage generates and propagates
	signal G3,P3: std_logic_vector(3 downto 0); --third stage generates and propagates
	signal G4,P4: std_logic_vector(1 downto 0); --fourth stage generates and propagates
	signal G5,P5: std_logic; -- fifth stage generate
	signal carry_out: std_logic_vector (32 downto 0); 
	
begin
	carry_out(0) <= Cin;
	
stage_00: for i in 0 to 31 generate
				gen_prop_inst: gen_prop port map (in1 => A(i), in2 => B(i), G => G0(i), P => P0(i));
			end generate stage_00;
	
--stage_00 takes 250 ps
	
stage_01: for 	i in 0 to 15 generate
				prefix_inst1: prefix port map (Gin1=>G0(2*i), Gin2=>G0((2*i)+1), Pin1=>P0(2*i), Pin2=>P0((2*i)+1), G_out=>G1(i), P_out =>P1(i));
			 end generate stage_01;

--stage_01 takes 300 ps ; cumlative delay= 250 +300 =550 ps			 

stage_02: for 	i in 0 to 7 generate
				prefix_inst2: prefix port map (Gin1=>G1(2*i), Gin2=>G1((2*i) +1), Pin1=>P1(2*i), Pin2=>P1((2*i)+1), G_out=>G2(i), P_out =>P2(i));
			 end generate stage_02;

--stage_02 takes 300 ps ; cumlative delay= 550 +300 =850 ps	
			 
stage_03: for 	i in 0 to 3 generate
				prefix_inst3: prefix port map (Gin1=>G2(2*i), Gin2=>G2((2*i) +1), Pin1=>P2(2*i), Pin2=>P2((2*i)+1), G_out=>G3(i), P_out =>P3(i));
			 end generate stage_03;

--stage_03 takes 300 ps ; cumlative delay= 850 +300 =1150 ps	
			 
stage_04: for 	i in 0 to 1 generate
				prefix_inst4: prefix port map (Gin1=>G3(2*i), Gin2=>G3((2*i) +1), Pin1=>P3(2*i), Pin2=>P3((2*i)+1), G_out=>G4(i), P_out =>P4(i));
			 end generate stage_04;

--stage_04 takes 300 ps ; cumlative delay= 1150 +300 =1450 ps
			 
--stage_05
 prefix_inst5: prefix port map (Gin1 => G4(0), Gin2 => G4(1), Pin1 => P4(0), Pin2 => P4(1), G_out => G5, P_out => P5);

 ----stage_05 takes 300 ps ; cumlative delay= 1450 +300 =1750 ps
 
 carry_out(32)<= G5    or (P5 and Cin) after 300 ps; 
 carry_out(16)<= G4(0) or (P4(0) and Cin) after 300 ps; 
 carry_out(8) <= G3(0) or (P3(0) and Cin) after 300 ps;
 carry_out(4) <= G2(0) or (P2(0) and Cin) after 300 ps; 
 carry_out(2) <= G1(0) or (P1(0) and Cin) after 300 ps;
 carry_out(1) <= G0(0) or (P0(0) and Cin) after 300 ps;
 
 --carry_out(32) takes 300 ps ; so C_out is available after 2050 ps
 --carry_out(16) takes 300 ps ; so carry_out(16) is available after 1750 ps (1450 +300 ps)
 -- all the other carries 8,4,2,1 are available before carry_out(16). So, it is not important in evaluatiing the delay of further stages.
 
--stage_06
 
 carry_out(24) <= G3(2) or (P3(2) and carry_out(16)) after 300 ps;
--stage_06 takes 300 ps ; cumlative delay= 1750 +300 =2050 ps 

 
stage_07: for i in 0 to 2 generate
			carry_inst1: carry_gen port map (Gin => G2((2*i)+2), Pin =>P2((2*i)+2), cy_in => carry_out((8*i)+8), cy_out => carry_out((8*i)+12));
			end generate stage_07;
--stage_07 takes 300 ps ; cumlative delay= 2050 +300 =2350 ps
			
			
stage_08: for i in 0 to 6 generate
			 carry_inst2: carry_gen port map (Gin => G1((2*i)+2), Pin =>P1((2*i)+2), cy_in => carry_out((4*i)+4), cy_out => carry_out((4*i)+6));
			 end generate stage_08;
--stage_08 takes 300 ps ; cumlative delay= 2350 +300 =2650 ps
			 
stage_09: for i in 0 to 14 generate
			 carry_inst3: carry_gen port map (Gin => G0((2*i)+2), Pin =>P0((2*i)+2), cy_in => carry_out((2*i)+2), cy_out => carry_out((2*i)+3));
			 end generate stage_09;
--stage_09 takes 300 ps ; cumlative delay= 2650 +300 =2950 ps

sum_stage: for i in 0 to 31 generate
			  sum(i) <= P0(i) xor carry_out(i) after 200 ps;
			  end generate sum_stage;
--Sum takes 200 ps. Cumulative delay = 2950 +200 = 3150 ps
Cout <= carry_out(32);
			  

end arch_bkadder;
			 


 
