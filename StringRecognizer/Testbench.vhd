library work;
use work.MyFsmPack.all;
library std;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;

entity Testbench is

end entity;


architecture Behave of Testbench is

  signal X: std_logic_vector(5 downto 0);
  signal Y: std_logic_vector(0 downto 0);
  signal clk: std_logic := '1';
  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin
      ret_val := lx;
      return(ret_val);
  end to_string;

  function to_std_logic (x: bit) return std_logic is
  begin
	if(x = '1') then return ('1');
	else return('0'); end if;
  end to_std_logic;

begin
  dut: StringRecognizer port map(inp =>X , clock => clk, op => Y);


  -- rudimentary test..
  -- apply reset,a,a,b,b,a,b
  process
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "TRACEFILE.txt";
    FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";
    variable inpbit1: bit_vector(5 downto 0);
    variable opbit1: bit_vector(0 downto 0);

    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
	
    variable clk_bit: bit;
  begin 
    while not endfile(INFILE) loop 
          -- clock = '0', inputs should be changed here.
          LINE_COUNT := LINE_COUNT + 1;
	  readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, clk_bit);
          read (INPUT_LINE, inpbit1);
          read (INPUT_LINE, opbit1);

    clk <= to_std_logic(clk_bit);
	  X <= to_stdlogicvector(inpbit1);

	  wait for 5 ns;
	  -- check Mealy machine output and 
          -- compare with expected.
          if (Y /= to_stdlogicvector(opbit1)) then
             write(OUTPUT_LINE,to_string("ERROR: line "));
             write(OUTPUT_LINE, LINE_COUNT);
             writeline(OUTFILE, OUTPUT_LINE);
             err_flag := true;
          end if; 

	  if(endfile(INFILE)) then
		exit;
	  end if;

	  -- clk = '1', inputs should not change here.
          LINE_COUNT := LINE_COUNT + 1;
	  readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, clk_bit);
          read (INPUT_LINE, inpbit1);
          read (INPUT_LINE, opbit1);
          clk <= to_std_logic(clk_bit);
	  X <= to_stdlogicvector(inpbit1);
          

	  wait for 5 ns;
	  
        end loop;
    
	assert (err_flag) report "SUCCESS, all tests passed." severity note;
    	assert (not err_flag) report "FAILURE, some tests failed." severity error;
	
	wait;
  end process;
  
end Behave;