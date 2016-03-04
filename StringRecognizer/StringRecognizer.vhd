library ieee;
use ieee.std_logic_1164.all;
library work;
use work.MyFsmPack.all;
entity StringRecognizer is
   port(inp: in std_logic_vector(5 downto 0);
   		clock: in std_logic;
        op: out std_logic_vector(0 downto 0));
end entity StringRecognizer;
architecture Struct of StringRecognizer is
	signal ip1: input_symbol;
   signal clock_changed: std_logic := '0';
	signal op1, op2, op3, op4: output_symbol;
	signal op5, op6, op7, op8: std_logic_vector(0 downto 0);

begin

   fsm1: my_fsm_bomb port map (ip => ip1, op => op1, cc => clock_changed);
   fsm2: my_fsm_gun port map (ip => ip1, op => op2, cc => clock_changed);
   fsm3: my_fsm_knife port map (ip => ip1, op => op3, cc => clock_changed);
   fsm4: my_fsm_terror port map (ip => ip1, op => op4, cc => clock_changed);
   process(clock, op1, op2, op3, op4)
	begin
		ip1 <= BV_To_Input_Symbol(inp);
		op5 <= Output_Symbol_To_Bit(op1);
		op6 <= Output_Symbol_To_Bit(op2);
      op7 <= Output_Symbol_To_Bit(op3);
      op8 <= Output_Symbol_To_Bit(op4);
      clock_changed <= '1';
      if (clock = '1') then
         clock_changed <= '0';
      end if;
   end process;
   op(0) <= op5(0) or op6(0) or op7(0) or op8(0);
end Struct;