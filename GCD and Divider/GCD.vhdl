library std;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.DividerComponents.all;

package GCDComponents is
  component GCD is
    port(din: in std_logic_vector(15 downto 0);
       dout: out std_logic_vector(15 downto 0);
       start: in std_logic;
       done: out std_logic;
       erdy: in std_logic;
       srdy: out std_logic;
       clk, reset: in std_logic);
  end component  GCD;

  component ControlPathGCD is
	port (
		T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12: out std_logic;
		S0,S1,S2: in std_logic;
		start: in std_logic;
		done: out std_logic;
    erdy: in std_logic;
    srdy: out std_logic;
		clk, reset: in std_logic
	);
  end component;

  component DataPathGCD is
	port (
		T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12: in std_logic;
		S0,S1,S2: out std_logic;
		din: in std_logic_vector(15 downto 0);
		dout: out std_logic_vector(15 downto 0);
    clk, reset: in std_logic
	);
  end component;
end package;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.GCDComponents.all;
entity GCD is
    port(din: in std_logic_vector(15 downto 0);
       dout: out std_logic_vector(15 downto 0);
       start: in std_logic;
       done: out std_logic;
       erdy: in std_logic;
       srdy: out std_logic;
       clk, reset: in std_logic);
end entity GCD;


architecture Struct of GCD is
   signal T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,S0,S1,S2: std_logic;
begin

    CP: ControlPathGCD
	     port map(T0 => T0,
			T1 => T1,
			T2 => T2,
			T3 => T3,
			T4 => T4,
 			T5 => T5,
			T6 => T6,
			T7 => T7,
			T8 => T8,
      T9 => T9,
      T10 => T10,
      T11 => T11,
      T12 => T12,
			S0 => S0,
      S1 => S1,
      S2 => S2,
			start => start,
      done => done,
      srdy => srdy,
      erdy => erdy,
			reset => reset,
			clk => clk);

    DP: DataPathGCD
	     port map (
      din => din,
      dout => dout,
	    T0 => T0,
			T1 => T1,
			T2 => T2,
			T3 => T3,
			T4 => T4,
 			T5 => T5,
			T6 => T6,
			T7 => T7,
			T8 => T8,
      T9 => T9,
      T10 => T10,
      T11 => T11,
      T12 => T12,
			S0 => S0,
      S1 => S1,
      S2 => S2,
			reset => reset,
			clk => clk);
end Struct;

library ieee;
use ieee.std_logic_1164.all;
entity ControlPathGCD is
  port (
    T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12: out std_logic;
    S0,S1,S2: in std_logic;
    start: in std_logic;
    done: out std_logic;
    erdy: in std_logic;
    srdy: out std_logic;
    clk, reset: in std_logic
  );
end entity;

architecture Behave of ControlPathGCD is
   type FsmState is (rst, accept_input, initialize, divide, check, donestate);
   signal fsm_state : FsmState;
   signal srdy1: std_logic;
begin

   process(fsm_state, start, S0, S1, S2, clk, reset)
      variable next_state: FsmState;
      variable Tvar: std_logic_vector(0 to 12);
      variable done_var, srdy_var: std_logic;
   begin
       -- defaults
       Tvar := (others => '0');
       done_var := '0';
       srdy_var := srdy1;
       next_state := fsm_state;

       case fsm_state is
          when rst =>
               if(start = '1' and erdy = '1') then
                  next_state := accept_input;
                  Tvar(0) := '1'; Tvar(2) := '1';
                  srdy_var := '0';
               end if;
          when accept_input =>
               if (srdy_var = '0') then
                  srdy_var := '1';
                  next_state := accept_input;
               elsif (erdy = '1') then
                  Tvar(1) := '1'; Tvar(3) := '1'; Tvar(4) := '1';
                  srdy_var := '0';
                  next_state := initialize;
               end if;
          when initialize =>
               srdy_var := '1';
               Tvar(5) := '1'; Tvar(6) := '1';
               next_state := divide;
          when divide =>
               Tvar(11) := '1';
               next_state := check;
          when check =>
               Tvar(12) := '1';
               if(S2 = '1') then
                  if (S1 = '1') then
                    Tvar(7) := '1';
                    if (S0 = '1') then
                      Tvar(10) := '1';
                      next_state := donestate;
                    else
                      next_state := accept_input;
                    end if;
                  else
                    Tvar(8) := '1'; Tvar(9) := '1';
                    next_state := divide;
                  end if;
               end if;
          when donestate =>
               done_var := '1';
               next_state := rst;
     end case;

     T0 <= Tvar(0); T1 <= Tvar(1); T2 <= Tvar(2); T3 <= Tvar(3); T4 <= Tvar(4);
     T5 <= Tvar(5); T6 <= Tvar(6); T7 <= Tvar(7); T8 <= Tvar(8); T9 <= Tvar(9);
     T10 <= Tvar(10); T11 <= Tvar(11); T12 <= Tvar(12);
     done <= done_var;
     if(clk'event and (clk = '1')) then
	      if(reset = '1') then
             fsm_state <= rst;
        else
             srdy1 <= srdy_var;
             srdy <= srdy_var;
             fsm_state <= next_state;
        end if;
     end if;
   end process;
end Behave;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.DividerComponents.all;
entity DataPathGCD is
  port (
    T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12: in std_logic;
    S0,S1,S2: out std_logic;
    din: in std_logic_vector(15 downto 0);
    dout: out std_logic_vector(15 downto 0);
    clk, reset: in std_logic
  );
end entity;

architecture Mixed of DataPathGCD is
    signal AREG, NEXTNO: std_logic_vector(15 downto 0);
    signal BREG, GCD: std_logic_vector(15 downto 0);
    signal COUNT: std_logic_vector(4 downto 0);
    signal COMPARE: std_logic_vector(0 downto 0);
    signal DIVIDE: std_logic_vector(0 downto 0);

    signal AREG_in, NEXTNO_in: std_logic_vector(15 downto 0);
    signal BREG_in, GCD_in: std_logic_vector(15 downto 0);
    signal COUNT_in: std_logic_vector(4 downto 0);
    signal COMPARE_in: std_logic_vector(0 downto 0);
    signal DIVIDE_in: std_logic_vector(0 downto 0);
    signal DOUT_in: std_logic_vector(15 downto 0);

    signal var1,var2: std_logic_vector(15 downto 0);
    signal compRESULT: std_logic_vector(0 downto 0);

    signal decrOut: std_logic_vector(4 downto 0);
    signal quotient, remainder: std_logic_vector(15 downto 0);
    signal divide_done, abc, divide_start: std_logic;

    constant C8 : std_logic_vector(4 downto 0) := "01000";
    constant C0 : std_logic_vector(0 downto 0) := "0";
    constant C5 : std_logic_vector(4 downto 0) := "00000";
    constant C16 : std_logic_vector(15 downto 0) := (others => '0');
    constant C32 : std_logic_vector(31 downto 0) := (others => '0');
    constant C64 : std_logic_vector(63 downto 0) := (others => '0');

    signal count_enable, compare_enable, nextno_enable, dout_enable, divide_enable,
             areg_enable, breg_enable, gcd_enable: std_logic;

begin
    -- predicate
    S0 <= '1' when (COUNT = C5) else '0';
    S1 <= '1' when (remainder = C16) else '0';
    S2 <= '1' when (divide_done = '1') else '0';

    divide1: Divider port map (
       dividend => AREG,
       divisor => BREG,
       quotient => quotient,
       remainder => remainder,
       inputs_ready => DIVIDE(0),
       divider_ready => abc,
       output_accept => '1',
       output_ready => divide_done,
       clk => clk, reset => reset);

    -------------------------------------------------
    -- DIVIDE related logic..
    -------------------------------------------------
    DIVIDE_in <= "1" when T11 = '1' else "0";
    divide_enable <= T11 or T12;
    divr: DataRegister generic map(data_width => 1)
      port map (Din => DIVIDE_in, Dout => DIVIDE, Enable => divide_enable, clk => clk);

    --------------------------------------------------------
    --  count-related logic
    --------------------------------------------------------
    -- decrementer
    decr: Decrement5  port map (A => COUNT, B => decrOut);

    -- count register.
    count_enable <=  (T0 or T1);
    COUNT_in <= decrOut when T1 = '1' else C8;
    count_reg: DataRegister
                   generic map (data_width => 5)
                   port map (Din => COUNT_in,
                             Dout => COUNT,
                             Enable => count_enable,
                             clk => clk);

    -------------------------------------------------
    -- GCD related logic..
    -------------------------------------------------
    GCD_in <= din when T2 = '1' else BREG;
    gcd_enable <= T2 or T7;
    gcdr: DataRegister generic map(data_width => 16)
      port map (Din => GCD_in, Dout => GCD, Enable => gcd_enable, clk => clk);

    -------------------------------------------------
    -- NEXTNO related logic..
    -------------------------------------------------
    NEXTNO_in <= din;
    nextno_enable <= T4;
    nextr: DataRegister generic map(data_width => 16)
      port map (Din => NEXTNO_in, Dout => NEXTNO, Enable => nextno_enable, clk => clk);

    -------------------------------------------------
    -- BREG related logic..
    -------------------------------------------------
    var1 <= GCD when COMPARE(0) = '1' else din;
    BREG_in <= var1 when T6 = '1' else remainder;
    breg_enable <= T6 or T9;
    br: DataRegister generic map(data_width => 16)
      port map (Din => BREG_in, Dout => BREG, Enable => breg_enable, clk => clk);

    -------------------------------------------------
    -- AREG related logic.
    -------------------------------------------------
    var2 <= din when COMPARE(0) = '1' else GCD;
    areg_enable <= T5 or T8;
    AREG_in <= var2 when T5 = '1' else BREG;
    ar: DataRegister
             generic map (data_width => 16)
             port map (
			 Din => AREG_in, Dout => AREG,
				Enable => areg_enable, clk => clk);


    -------------------------------------------------
    -- COMPARE related logic
    -------------------------------------------------
    cmp: Comparator16 port map (A => Din, B => GCD, RESULT => compRESULT(0));
    COMPARE_in <= compRESULT;
    compare_enable <= T3;
    cr: DataRegister generic map(data_width => 1)
			port map(Din => COMPARE_in, Dout => COMPARE, Enable => compare_enable, clk => clk);

    -------------------------------------------------
    -- DOUT related logic
    -------------------------------------------------
    DOUT_in <= GCD;
    dout_enable <= T10;
    rr: DataRegister generic map(data_width => 16)
			port map(Din => DOUT_in, Dout => dout, Enable => dout_enable, clk => clk);

end Mixed;

