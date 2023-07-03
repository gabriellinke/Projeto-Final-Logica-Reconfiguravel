LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg16 IS
PORT ( 	clock, resetn : IN STD_LOGIC;
			WE : IN STD_LOGIC;
			D 	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Q 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
END reg16;

ARCHITECTURE Behavior OF reg16 IS
BEGIN
PROCESS(resetn, clock)
BEGIN
	IF resetn = '0' THEN
		Q <= x"0000";
	elsif clock'EVENT AND clock = '1' then
		if WE = '1' then
			Q <= D;
		end if;	
	end if;
END PROCESS;
END Behavior;