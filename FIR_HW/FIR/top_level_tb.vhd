
--  CREATION DATE .......:  08 April 2015
--  AUTHOR ..............:  DIEGO PARDO (arroxo2@yahoo.es)
--  REVISION ............:  1.0
--  LAST UPDATE .........:  08 April 2015
--  UPDATED BY ..........:  DIEGO PARDO 

--  TITLE "CONFIGURABLE FIR FILTER TESTBENCH";
--
--  http://t-filter.appspot.com/fir/index.html

--=============================================================================
--================================ TESTBENCH ==================================
--=============================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE ieee.math_real.all;     
use std.textio.all;

LIBRARY work;
USE work.fir_package.all;


ENTITY top_level_tb IS
END top_level_tb;


ARCHITECTURE top_level_tb_arch OF top_level_tb IS

	COMPONENT top_level IS
		port(	clock, resetn : IN  STD_LOGIC;
				chipselect    : IN  STD_LOGIC;
				writedata     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				write_en      : IN  STD_LOGIC;
				readdata      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				add        	  : IN  STD_LOGIC;
				read_en       : IN  STD_LOGIC);
	END COMPONENT;
 
 
 
-- TESTCASE SETTINGS
--.............................................................................
  CONSTANT freq_xn     : REAL        := 200.0;   -- input frequency
  CONSTANT data_length : NATURAL     := 31;        -- input bit size       
  CONSTANT fs_Hz       : REAL        := 44.1e3;     -- sampling frequency

--..............................................................................

  SIGNAL areset        : STD_LOGIC;
  SIGNAL clock_fs      : STD_LOGIC := '1';
  SIGNAL xn_signed     : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);
  SIGNAL yn_signed     : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);
  SIGNAL writedata_s   : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL readdata_s    : STD_LOGIC_VECTOR(31 DOWNTO 0);

                       
  SIGNAL radians       : REAL := 0.0;
  SIGNAL radian_step   : REAL := 1.0/(fs_Hz/freq_xn);
     
  CONSTANT PI          : REAL    := 3.1415926535897932;                
  CONSTANT num_cycles  : NATURAL := 16;
  CONSTANT fs_period   : TIME    := integer(1.0e12/fs_Hz)* 1 ps;
  CONSTANT num_samples : NATURAL := num_cycles*integer(round(fs_Hz/freq_xn));
  CONSTANT amplitude   : REAL    := 2.0**real(data_length-1)-1.0;
 
  file fptr_input: text;
  CONSTANT FILE_NAME_INPUT :string := "input.dat";
  file fptr_output: text;
  CONSTANT FILE_NAME_OUTPUT :string := "output.dat";
 
BEGIN 
  fir: top_level
	port map(
		clock      => clock_fs,
		resetn     => areset,
		chipselect => '1',
		writedata  => writedata_s,
		write_en   => '1',
		readdata   => readdata_s,
		add        => '1',
		read_en    => '1'
	);

  sampling_clock: process 
  --.............................................
  begin
    clock_fs <= '1';
    wait for fs_period/2;
    clock_fs <= '0';
    wait for fs_period/2;
  end process;      
  
  xn_sinus: process 
  --.............................................
    variable seed1,seed2 : positive;
    variable rand        : real;
    variable noise_n     : real;
    variable sinus_n     : real;
    variable fstatus_input  :file_open_status;
    variable file_line_input :line;
    variable fstatus_output  :file_open_status;
    variable file_line_output :line;
  begin 
    UNIFORM(seed1, seed2, rand);     -- uniform  0.0 to 1.0
    noise_n := 2.0*(rand-0.5) * (amplitude/20.0);     
    sinus_n := amplitude * sin(2.0*PI*radians) + noise_n;
    file_open(fstatus_input, fptr_input, FILE_NAME_INPUT, write_mode);
    file_open(fstatus_output, fptr_output, FILE_NAME_OUTPUT, write_mode);

    -- saturation control
    if sinus_n > amplitude then
      sinus_n := amplitude;
    elsif sinus_n < -amplitude then
      sinus_n := -amplitude;
    end if;
	 
	 yn_signed <= readdata_s(31 DOWNTO 1);
    
    xn_signed   <= std_logic_vector(conv_signed(integer(round(sinus_n)),data_length));
	 writedata_s <= xn_signed & '0';
	 
	 write(file_line_input, sinus_n, left, 8);
    writeline(fptr_input, file_line_input);
    write(file_line_output, conv_integer(yn_signed), left, 8);
    writeline(fptr_output, file_line_output);
    if radians >= 1.0 then
      radians <= 0.0;
    else
      radians <= radians + radian_step;
    end if;
    wait until rising_edge(clock_fs);
  end process;  
 
  reset: process 
  --.............................................
  begin
    areset <= '0';
    wait for 10 ns;
    areset <= '1';
    wait;
  end process;  
 
  sim_time: process 
  --.............................................
  begin
    wait for num_samples*fs_period;
    assert false report "SIMULATION END" severity failure;
  end process;
 
END top_level_tb_arch;


