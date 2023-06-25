Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--ENTIDADE----------------------------------------------------------------------
Entity PWM_GENERATOR is

   port(clock, resetn  : IN STD_LOGIC;
			chipselect    : IN  STD_LOGIC;
			writedata     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			write_en      : IN  STD_LOGIC;
			readdata      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
   	   add        	  : IN STD_LOGIC;
			read_en       : IN STD_LOGIC );

end entity;

--ARQUITETURA----------------------------------------------------------------------
Architecture arq_PWM_GENERATOR of PWM_GENERATOR is

--Sinais utilizados----------------------------------------------------------------
signal data_out: STD_LOGIC_VECTOR(31 downto 0):= x"00000000";
signal pwm_out_s, not_resetn: std_logic;
signal data_in: STD_LOGIC_VECTOR(31 downto 0):= x"00000000";
signal data_in_timer, data_in_duty: STD_LOGIC_VECTOR(7 downto 0):= x"00";
signal en_generator: std_logic := '0';
signal presc_selector: STD_LOGIC_VECTOR(1 downto 0):= "00";

--Componentes utilizados-----------------------------------------------------------
	component PWM is 
   port ( CLK 	 	: in  std_logic; --1bit
			 RST 	 	: in  std_logic; --1bit
			 ENABLE  : in  std_logic; --1bit
			 SEL_PR	: in  std_logic_vector (1 downto 0); --2bits
			 TIMER 	: in  std_logic_vector (7 downto 0); --8bits
			 DUTY  	: in  std_logic_vector (7 downto 0); --8bits
			 PWM_OUT : out std_logic);
	end component;

---------------------------------------------------------------------------------
Begin

--Mapeamento dos sinais-----------------------------------------------------------

	gerador: PWM 
		port map(
			CLK => clock,
			RST => not_resetn,
			ENABLE => en_generator,
			SEL_PR => presc_selector(1 downto 0),
			TIMER => data_in_timer(7 downto 0),
			DUTY => data_in_duty(7 downto 0),
			PWM_OUT => pwm_out_s
		);
		
------------------------------------------------------------------------------------
		not_resetn <= not(resetn);
-------------------------------|EN|PR|  TIMER |  DUTY  |
--WRITEDATA-(0000.0000.0000.0		0 00 00000000 00000000)
--PROCESS----------------------------------------------------------------------	
		process(not_resetn, clock)
			begin			
				if not_resetn = '1' then
					en_generator <= '0';

				elsif rising_edge(clock) then		--Se borda de subida e enable, habilita		
					if (writedata /= data_in) and (write_en = '1') and (chipselect = '1') then
						presc_selector <= writedata(17 downto 16);
						data_in_timer <= writedata(15 downto 8);
						data_in_duty <= writedata(7 downto 0);
						en_generator <= writedata(18); --1
						data_in <= writedata;
						data_out <= writedata(31 downto 0);
						--rst_my_clk <= '1';
					elsif read_en = '1' then
					readdata <= std_logic_vector("00000000000000" & unsigned(presc_selector(1 downto 0)) & unsigned(data_in_timer(7 downto 0)) & unsigned(data_in_duty(7 downto 0)));
					end if;
				end if;
			end process;

End architecture;