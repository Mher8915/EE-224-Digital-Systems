library ieee;
use ieee.std_logic_1164.all;
library work;
use work.MyFsmPack.all;
entity TopLevel is
   port(inp: in std_logic_vector(1 downto 0);
   		clock: in std_logic;
        op: out std_logic_vector(0 downto 0));
end entity TopLevel;
architecture Struct of TopLevel is
	signal ip1, ip2: input_symbol;
   signal clock_changed: std_logic := '0';
	signal op1, op2: output_symbol;
	signal op3, op4: std_logic_vector(0 downto 0);

begin

   fsm1: my_fsm port map (ip => ip1, op => op1, cc => clock_changed);
   fsm2: my_fsm port map (ip => ip2, op => op2, cc => clock_changed);
   process(clock,op1,op2)
   variable k: std_logic_vector(1 downto 0);
	begin
      k(1) := inp(1);
      k(0) := not inp(0);
		ip1 <= BV_To_Input_Symbol(inp);
		ip2 <= BV_To_Input_Symbol(k);
		op3 <= Output_Symbol_To_Bit(op1);
		op4 <= Output_Symbol_To_Bit(op2);
      clock_changed <= '1';
      if (clock = '0') then
         clock_changed <= '0';
      end if;
   end process;
   op(0) <= op3(0) or op4(0);
end Struct;