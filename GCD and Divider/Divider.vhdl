library std;
library ieee;
use ieee.std_logic_1164.all;


package DividerComponents is
  component Divider is
    port(dividend,divisor: in std_logic_vector(15 downto 0);
       quotient: out std_logic_vector(15 downto 0);
       remainder: out std_logic_vector(15 downto 0);
       inputs_ready: in std_logic;
       divider_ready: out std_logic;
       output_accept: in std_logic;
       output_ready: out std_logic;
       clk, reset: in std_logic);
  end component  Divider;

  component ControlPath is
	port (
		T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11: out std_logic;
		S: in std_logic;
		start: in std_logic;
		done: out std_logic;
    output_accept: in std_logic;
    divider_ready: out std_logic;
		clk, reset: in std_logic
	);
  end component;

  component DataPath is
	port (
		T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11: in std_logic;
		S: out std_logic;
		dividend, divisor: in std_logic_vector(15 downto 0);
    quotient: out std_logic_vector(15 downto 0);
    remainder: out std_logic_vector(15 downto 0);
		clk, reset: in std_logic
	);
  end component;

  component DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
  end component DataRegister;

  component Subtract16 is
        port (A, B: in std_logic_vector(15 downto 0); RESULT: out std_logic_vector(15 downto 0));
  end component Subtract16;

  component Comparator16 is
        port (A, B: in std_logic_vector(15 downto 0); RESULT: out std_logic);
  end component Comparator16;

  component Decrement5 is
        port (A: in std_logic_vector(4 downto 0); B: out std_logic_vector(4 downto 0));
  end component Decrement5;

end package;

library ieee;
use ieee.std_logic_1164.all;
entity DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
end entity;
architecture Behave of DataRegister is
begin
    process(clk)
    begin
       if(clk'event and (clk  = '1')) then
           if(enable = '1') then
               Dout <= Din;
           end if;
       end if;
    end process;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity Subtract16 is
   port (A, B: in std_logic_vector(15 downto 0); RESULT: out std_logic_vector(15 downto 0));
end entity;
architecture Serial of Subtract16 is
begin
   process(A,B)
     variable borrow: std_logic;
   begin
     borrow := '0';
     for I in 0 to 15 loop
        RESULT(I) <= (A(I) xor B(I)) xor borrow;
        borrow := (B(I) and (borrow or (not A(I)))) or ((not A(I)) and borrow);
     end loop;
   end process;
end Serial;

library ieee;
use ieee.std_logic_1164.all;
entity Comparator16 is
   port (A, B: in std_logic_vector(15 downto 0); RESULT: out std_logic);
end entity Comparator16;
architecture Serial of Comparator16 is
begin
   process(A,B)
    variable less, greater, equal: std_logic;
   begin
     less := '0';
     greater := '0';
     equal := '1';
     for I in 0 to 15 loop
        greater := greater or (equal and A(15-I) and (not B(15-I)));
        less := less or (equal and B(15-I) and (not A(15-I)));
        equal := equal and (not (A(15-I) xor B(15-I)));
     end loop;
     RESULT <= equal or greater;
   end process;
end Serial;

library ieee;
use ieee.std_logic_1164.all;
entity Decrement5 is
   port (A: in std_logic_vector(4 downto 0); B: out std_logic_vector(4 downto 0));
end entity Decrement5;
architecture Serial of Decrement5 is
begin
  process(A)
    variable borrow: std_logic;
  begin
    borrow := '1';
    for I in 0 to 4 loop
       B(I) <= A(I) xor borrow;
       borrow := borrow and (not A(I));
    end loop;
  end process;
end Serial;


library ieee;
use ieee.std_logic_1164.all;

library work;
use work.DividerComponents.all;
entity Divider is
    port(dividend,divisor: in std_logic_vector(15 downto 0);
       quotient: out std_logic_vector(15 downto 0);
       remainder: out std_logic_vector(15 downto 0);
       inputs_ready: in std_logic;
       divider_ready: out std_logic;
       output_accept: in std_logic;
       output_ready: out std_logic;
       clk, reset: in std_logic);
end entity Divider;


architecture Struct of Divider is
   signal T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,S: std_logic;
begin

    CP: ControlPath
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
			S => S,
			start => inputs_ready,
      divider_ready => divider_ready,
      output_accept => output_accept,
			done => output_ready,
			reset => reset,
			clk => clk);

    DP: DataPath
	     port map (dividend => dividend, divisor => divisor,
			quotient => quotient, remainder => remainder,
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
			S => S,
			reset => reset,
			clk => clk);
end Struct;

library ieee;
use ieee.std_logic_1164.all;
entity ControlPath is
  port (
    T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11: out std_logic;
    S: in std_logic;
    start: in std_logic;
    done: out std_logic;
    output_accept: in std_logic;
    divider_ready: out std_logic;
    clk, reset: in std_logic
  );
end entity;

architecture Behave of ControlPath is
   type FsmState is (rst, compare, quotient, update, donestate);
   signal fsm_state : FsmState;
begin

   process(fsm_state, start, S, clk, reset)
      variable next_state: FsmState;
      variable Tvar: std_logic_vector(0 to 11);
      variable done_var, divider_ready_var: std_logic;
   begin
       -- defaults
       Tvar := (others => '0');
       done_var := '0';
       next_state := fsm_state;

       case fsm_state is
          when rst =>
               if(start = '1') then
                  next_state := compare;
                  Tvar(0) := '1'; Tvar(2) := '1';
                  Tvar(3) := '1'; Tvar(4) := '1';
                  divider_ready_var := '0';
               end if;
          when compare =>
               next_state := quotient;
               Tvar(1) := '1'; Tvar(6) := '1';
               Tvar(11) := '1';
               divider_ready_var := '1';
          when quotient =>
               next_state := update;
               Tvar(7) := '1'; Tvar(8) := '1';
          when update =>
               Tvar(5) := '1';
               if(S = '1') then
                  Tvar(9) := '1';
                  Tvar(10) := '1';
                  next_state := donestate;
               else
                  next_state := compare;
               end if;
          when donestate =>
               done_var := '1';
               next_state := rst;
     end case;

     T0 <= Tvar(0); T1 <= Tvar(1); T2 <= Tvar(2); T3 <= Tvar(3); T4 <= Tvar(4);
     T5 <= Tvar(5); T6 <= Tvar(6); T7 <= Tvar(7); T8 <= Tvar(8); T9 <= Tvar(9);
     T10 <= Tvar(10); T11 <= Tvar(11);
     done <= done_var;
     divider_ready <= divider_ready_var;
     if(clk'event and (clk = '1')) then
	if(reset = '1') then
             fsm_state <= rst;
        else
             fsm_state <= next_state;
        end if;
     end if;
   end process;
end Behave;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.DividerComponents.all;

entity DataPath is
  port (
    T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11: in std_logic;
    S: out std_logic;
    dividend, divisor: in std_logic_vector(15 downto 0);
    quotient: out std_logic_vector(15 downto 0);
    remainder: out std_logic_vector(15 downto 0);
    clk, reset: in std_logic
  );
end entity;

architecture Mixed of DataPath is
    signal AREG: std_logic_vector(31 downto 0);
    signal BREG, QREG, RREG: std_logic_vector(15 downto 0);
    signal COUNT: std_logic_vector(4 downto 0);
    signal COMPARE: std_logic_vector(0 downto 0);
    signal DIVIDE: std_logic_vector(0 downto 0);

    signal AREG_in: std_logic_vector(31 downto 0);
    signal BREG_in, QREG_in, RREG_in, QRESULT_in, RRESULT_in: std_logic_vector(15 downto 0);
    signal COUNT_in: std_logic_vector(4 downto 0);
    signal COMPARE_in: std_logic_vector(0 downto 0);
    signal DIVIDE_in: std_logic_vector(0 downto 0);

    signal subA,subB: std_logic_vector(15 downto 0);
    signal subRESULT: std_logic_vector(15 downto 0);
    signal compRESULT: std_logic_vector(0 downto 0);

    signal decrOut: std_logic_vector(4 downto 0);
    constant C33 : std_logic_vector(4 downto 0) := "10001";
    constant C0 : std_logic_vector(0 downto 0) := "0";
    constant C5 : std_logic_vector(4 downto 0) := "00000";
    constant C16 : std_logic_vector(15 downto 0) := (others => '0');
    constant C32 : std_logic_vector(31 downto 0) := (others => '0');
    constant C64 : std_logic_vector(63 downto 0) := (others => '0');

    signal count_enable, compare_enable, rresult_enable, divide_enable,
             areg_enable, breg_enable, qreg_enable, rreg_enable, qresult_enable: std_logic;

begin
    -- predicate
    S <= '1' when (COUNT = C5) else '0';

    --------------------------------------------------------
    --  count-related logic
    --------------------------------------------------------
    -- decrementer
    decr: Decrement5  port map (A => COUNT, B => decrOut);

    -- count register.
    count_enable <=  (T0 or T1);
    COUNT_in <= decrOut when T1 = '1' else C33;
    count_reg: DataRegister
                   generic map (data_width => 5)
                   port map (Din => COUNT_in,
                             Dout => COUNT,
                             Enable => count_enable,
                             clk => clk);

    -------------------------------------------------
    -- BREG related logic..
    -------------------------------------------------
    BREG_in <= divisor;  -- not really needed, just being consistent.
    breg_enable <= T2;
    br: DataRegister generic map(data_width => 16)
      port map (Din => BREG_in, Dout => BREG, Enable => breg_enable, clk => clk);


    -------------------------------------------------
    -- AREG related logic.
    -------------------------------------------------
    subA <= AREG(31 downto 16);
    subB <= BREG when (COMPARE(0) = '1') else C16;
    ainst: Subtract16 port map (A => subA, B => subB, RESULT => subRESULT);

    areg_enable <= T3 or T5 or T8;
    AREG_in <= C16 & dividend when T3 = '1' else
               (AREG(30 downto 0) & C0) when T5 = '1' else
               subRESULT & AREG(15 downto 0);
    ar: DataRegister
             generic map (data_width => 32)
             port map (
			 Din => AREG_in, Dout => AREG,
				Enable => areg_enable, clk => clk);


    -------------------------------------------------
    -- COMPARE related logic
    -------------------------------------------------
    cmp: Comparator16 port map (A => AREG(31 downto 16), B => BREG, RESULT => compRESULT(0));
    COMPARE_in <= compRESULT;
    compare_enable <= T11;
    cr: DataRegister generic map(data_width => 1)
			port map(Din => COMPARE_in, Dout => COMPARE, Enable => compare_enable, clk => clk);

    -------------------------------------------------
    -- QUOTIENT related logic
    -------------------------------------------------
    QREG_in <= (QREG(14 downto 0) & C0) when T6 = '1' else
               (QREG(15 downto 1) & COMPARE(0)) when T7 = '1' else
               C16;
    qreg_enable <= T4 or T6 or T7;
    qr: DataRegister generic map(data_width => 16)
      port map(Din => QREG_in, Dout => QREG, Enable => qreg_enable, clk => clk);

    -------------------------------------------------
    -- QRESULT related logic
    -------------------------------------------------
    QRESULT_in <= QREG;
    qresult_enable <= T9;
    rr: DataRegister generic map(data_width => 16)
			port map(Din => QRESULT_in, Dout => quotient, Enable => qresult_enable, clk => clk);

    -------------------------------------------------
    -- RRESULT related logic
    -------------------------------------------------
    RRESULT_in <= AREG(31 downto 16);
    rresult_enable <= T10;
    remr: DataRegister generic map(data_width => 16)
      port map(Din => RRESULT_in, Dout => remainder, Enable => rresult_enable, clk => clk);


end Mixed;

