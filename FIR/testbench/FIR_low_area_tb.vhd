
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


ENTITY FIR_low_area_tb IS
END FIR_low_area_tb;


ARCHITECTURE FIR_low_area_tb_arch OF FIR_low_area_tb IS
 
-- TESTCASE SETTINGS
--.............................................................................
  CONSTANT freq_xn     : REAL        := 2.0e6;   -- input frequency
  --CONSTANT freq_xn     : REAL        := 900.0e3;   -- input frequency
  
  CONSTANT data_length : NATURAL     := 8;        -- input bit size
                                    
  CONSTANT fs_Hz       : REAL        := 8.0e6;     -- sampling frequency
  --CONSTANT fs_Hz       : REAL        := 44.1e3;     -- sampling frequency
  CONSTANT taps        : NATURAL     := 49;        -- order+1
  -- transition band: 800e3 to 1.6e6
  CONSTANT hn 			  : COEFF_ARRAY :=(                     -- normalized coefficients bi: (bo,b1, ..., bN). They must be symmetric (but sign)
													0.0001941042,
                                       0.0006868266,
                                       0.0015712643,
                                       0.0031632958,
                                       0.0057532538,
                                       0.0095608923,
                                       0.0146958011,
                                       0.0211287766,
                                       0.0286784589,
                                       0.0370157426,
                                       0.0456862828,
                                       0.0541491260,
                                       0.0618274047,
                                       0.0681654164,
                                       0.0726854808,
                                       0.0750378728,
                                       0.0750378728,
                                       0.0726854808,
                                       0.0681654164,
                                       0.0618274047,
                                       0.0541491260,
                                       0.0456862828,
                                       0.0370157426,
                                       0.0286784589,
                                       0.0211287766,
                                       0.0146958011,
                                       0.0095608923,
                                       0.0057532538,
                                       0.0031632958,
                                       0.0015712643,
                                       0.0006868266,
                                       0.0001941042,
													OTHERS=>0.0);         -- (always end with "others=>0.0")
													
  CONSTANT bits_resol  : NATURAL := 32;
--..............................................................................

  SIGNAL areset        : STD_LOGIC;
  SIGNAL clock_fs      : STD_LOGIC := '1';
  SIGNAL xn_signed     : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);
  SIGNAL xn_unsigned   : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);
  SIGNAL yn_signed     : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);
  SIGNAL yn_unsigned   : STD_LOGIC_VECTOR(data_length-1 DOWNTO 0);
                       
  SIGNAL radians       : REAL := 0.0;
  SIGNAL radian_step   : REAL := 1.0/(fs_Hz/freq_xn);
     
  CONSTANT PI          : REAL    := 3.1415926535897932;                
  CONSTANT num_cycles  : NATURAL := 16;
  CONSTANT fs_period   : TIME    := integer(1.0e12/fs_Hz)* 1 ps;
  CONSTANT num_samples : NATURAL := num_cycles*integer(round(fs_Hz/freq_xn));
  CONSTANT amplitude   : REAL    := 2.0**real(data_length-1)-1.0;
 
  file fptr: text;
  CONSTANT FILE_NAME :string := "output.dat";
 
BEGIN

  duv_fir_signed: ENTITY work.FIR_low_area 
  --.............................................
  generic map(        
    data_length  => data_length,
    data_signed  => true,
    improv_t     => false,
    bits_resol   => bits_resol,
    taps         => taps,  
    coefficients => hn)
  port map(
    areset   => areset,
    sreset   => '0',
    clock_fs => clock_fs,
    enable   => '1',
    xn       => xn_signed,
    yn       => yn_signed
    );

  duv_fir_unsigned: ENTITY work.FIR_low_area 
  --.............................................
  generic map(        
    data_length  => data_length,
    data_signed  => false,
    improv_t     => false,
    bits_resol   => bits_resol,
    taps         => taps,  
    coefficients => hn)
  port map(
    areset   => areset,
    sreset   => '0',
    clock_fs => clock_fs,
    enable   => '1',
    xn       => xn_unsigned,
    yn       => yn_unsigned
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
    variable fstatus  :file_open_status;
    variable file_line :line;
  begin 
    UNIFORM(seed1, seed2, rand);     -- uniform  0.0 to 1.0
    noise_n := 2.0*(rand-0.5) * (amplitude/20.0);     
    sinus_n := amplitude * sin(2.0*PI*radians) + noise_n;
    file_open(fstatus, fptr, FILE_NAME, write_mode);

    -- saturation control
    if sinus_n > amplitude then
      sinus_n := amplitude;
    elsif sinus_n < -amplitude then
      sinus_n := -amplitude;
    end if;
    
    xn_signed   <= std_logic_vector(conv_signed(integer(round(sinus_n)),data_length));
    xn_unsigned <= std_logic_vector(conv_unsigned(integer(round(amplitude + sinus_n)),data_length));
    write(file_line, sinus_n, left, 2);
    writeline(fptr, file_line);
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
    areset <= '1';
    wait for 10 ns;
    areset <= '0';
    wait;
  end process;  
 
  sim_time: process 
  --.............................................
  begin
    wait for num_samples*fs_period;
    assert false report "SIMULATION END" severity failure;
  end process;
 
 
END FIR_low_area_tb_arch;


