LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE ieee.math_real.all;     
use std.textio.all;

LIBRARY work;
USE work.fir_package.all;

--ENTIDADE----------------------------------------------------------------------
Entity top_level is
   port(	clock, resetn : IN  STD_LOGIC;
			chipselect    : IN  STD_LOGIC;
			writedata     : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
			write_en      : IN  STD_LOGIC;
			readdata      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			add        	  : IN  STD_LOGIC;
			read_en       : IN  STD_LOGIC);
end entity;

--ARQUITETURA----------------------------------------------------------------------
Architecture arq_top_level of top_level is

--Sinais utilizados----------------------------------------------------------------
signal data_out: STD_LOGIC_VECTOR(15 downto 0);
signal data_in: STD_LOGIC_VECTOR(15 downto 0);
signal r32_out: STD_LOGIC_VECTOR(15 downto 0);
signal not_resetn: std_logic := '1';

--Componentes utilizados-----------------------------------------------------------
COMPONENT reg16
	PORT(
		clock  : IN STD_LOGIC;
		resetn : IN STD_LOGIC;
		WE 	 : IN STD_LOGIC;
		D 		 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Q 		 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

---------------------------------------------------------------------------------
Begin

--Mapeamento dos sinais-----------------------------------------------------------
		
  duv_fir_signed: ENTITY work.FIR_low_area 
	  port map(
		 areset   => not_resetn,
		 sreset   => '0',
		 clock_fs => clock,
		 enable   => '1',
		 xn       => data_in,
		 yn       => data_out
	  );
		
	r16 : reg16
		port map (
			clock 	=> clock,
			resetn 	=> resetn,
			WE       => write_en,
			D 		   => data_out,
			Q 		   => r32_out
		);
------------------------------------------------------------------------------------
		not_resetn <= not(resetn);
		readdata <= r32_out when read_en='1';

--PROCESS----------------------------------------------------------------------	
		process(not_resetn, clock)
			begin			
				if rising_edge(clock) and write_en='1' then		--Se borda de subida e enable, habilita		
					data_in <= writedata;
					
				end if;
			end process;

End architecture;