library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
library work;
use work.GCDComponents.all;

entity Testbench_GCD is
end entity;
architecture Behave of Testbench_GCD is
  signal din, dout: std_logic_vector(15 downto 0);
  signal start, done, srdy, erdy: std_logic;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';

  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
    alias lx: bit_vector(1 to x'length) is x;
    variable ret_var : std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
           ret_var(I) :=  '1';
        else 
           ret_var(I) :=  '0';
	end if;
     end loop;
     return(ret_var);
  end to_std_logic_vector;



begin
  clk <= not clk after 5 ns; -- assume 10ns clock.

  -- reset process
  process
  begin
     wait until clk = '1';
     reset <= '0';
     wait;
  end process;

  process 
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "TRACEFILE_GCD.txt";
    FILE OUTFILE: text  open write_mode is "OUTPUTS_GCD.txt";

    ---------------------------------------------------
    -- edit the next few lines to customize
    variable active: bit_vector (15 downto 0);
    variable op: bit_vector (15 downto 0);
    ----------------------------------------------------
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
    
  begin

    wait until clk = '1';

    while not endfile(INFILE) loop
    	  wait until clk = '0';

        LINE_COUNT := LINE_COUNT + 1;
	      readLine (INFILE, INPUT_LINE);
        start <= '1';

        for I in 1 to 8 loop
          read(INPUT_LINE, active);
          din <= to_std_logic_vector(active);
          erdy <= '1';

        -- wait till srdy becomes 0
          while (true) loop
            wait until clk = '1';
            start <= '0';
            if (srdy = '0') then
              exit;
            end if;
          end loop;

          -- wait till srdy becomes 1
          while (true) loop
            wait until clk = '1';
            if (srdy = '1') then
              exit;
            end if;
          end loop;
        end loop;

        read(INPUT_LINE, op);
        -- spin waiting for done
        while (true) loop
           wait until clk = '1';
           if(done = '1') then
              exit;
           end if;
        end loop;


    	  if (dout /= to_std_logic_vector(op)) then
           write(OUTPUT_LINE,to_string("ERROR: in RESULT, line "));
           write(OUTPUT_LINE, LINE_COUNT);
           writeline(OUTFILE, OUTPUT_LINE);
           err_flag := true;
        end if;

    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;

  dut: GCD
    port map (
       din => din,
       dout => dout,
       start => start,
       done => done,
       erdy => erdy,
       srdy => srdy,
       clk => clk, reset => reset);

end Behave;

