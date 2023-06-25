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
			writedata     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			write_en      : IN  STD_LOGIC;
			readdata      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			add        	  : IN  STD_LOGIC;
			read_en       : IN  STD_LOGIC);
end entity;

--ARQUITETURA----------------------------------------------------------------------
Architecture arq_top_level of top_level is

--Sinais utilizados----------------------------------------------------------------
signal data_out: STD_LOGIC_VECTOR(30 downto 0);
signal data_in: STD_LOGIC_VECTOR(30 downto 0);
signal not_resetn: std_logic := '1';

--Componentes utilizados-----------------------------------------------------------

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
		
------------------------------------------------------------------------------------
		not_resetn <= not(resetn);
		readdata <= (data_out(30 downto 0) & '0');

--PROCESS----------------------------------------------------------------------	
		process(not_resetn, clock)
			begin			
				if rising_edge(clock) then		--Se borda de subida e enable, habilita		
					data_in <= writedata(31 downto 1);
					
				end if;
			end process;

End architecture;