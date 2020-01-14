library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bkadder_tb is end bkadder_tb;

architecture rch of bkadder_tb is
	component bkadder is
		port(A, B: in std_logic_vector(31 downto 0);
			Cin: in std_logic;
			sum: out std_logic_vector(31 downto 0);
			Cout: out std_logic);
	end component;
	
	signal sig_A, sig_B: std_logic_vector(31 downto 0) := X"00000000";
	signal sig_sum: std_logic_vector(31 downto 0);
	signal sig_Cin: std_logic := '0';
	signal sig_Cout: std_logic;
	
begin

uut: bkadder port map (A => sig_A, B => sig_B, Cin => sig_Cin, sum => sig_sum, Cout =>sig_Cout);

process begin
	--wait for 25 ns;
	sig_A <= X"000002FF";
	sig_B <= X"000001AC";
	sig_Cin <= '1';
--	wait for 25 ns;
--	sig_A <= X"9924FEBA";
--	sig_B <= X"8379ADAB";
--	sig_Cin <= '1';
--	wait for 25 ns;
--	sig_A <= X"FFFFFFFF";
--	sig_B <= X"00000000";
--	sig_Cin <= '1';
--	wait for 25 ns;
--	sig_A <= X"FFFFFFFF";
--	sig_B <= X"FFFFFFFF";
--	sig_Cin <= '1';
--	wait for 25 ns;
--	sig_A <= X"00000000";
--	sig_B <= X"00000000";
--	sig_Cin <= '0';
	wait for 25 ns;
	wait;
end process;
end rch;
	
	