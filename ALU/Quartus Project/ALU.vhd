library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ALU_Components.all;
entity ALU is
   port(a, b: in std_logic_vector(7 downto 0);
        op: in std_logic_vector(1 downto 0);
        c: out std_logic_vector(7 downto 0));
end entity;
architecture Struct of ALU is
	signal add, subtract, left, right: std_logic_vector(7 downto 0);
begin
   adder1: EightBitAdder port map (a => a, b => b, c => add);
   subtract1: EightBitSubtractor port map (a => a, b => b, c => subtract);
   left1: EightBitLeftShift port map(a => a, b => b, c => left);
   right1: EightBitRightShift port map(a => a, b => b, c => right);
   c(0) <= (((not op(0)) and (not op(1))) and add(0))
         or (((op(0)) and (not op(1))) and subtract(0))
         or (((not op(0)) and (op(1))) and left(0))
          or ((op(0) and op(1)) and right(0));
   c(1) <= (((not op(0)) and (not op(1))) and add(1))
         or (((op(0)) and (not op(1))) and subtract(1))
         or (((not op(0)) and (op(1))) and left(1))
          or ((op(0) and op(1)) and right(1));
   c(2) <= (((not op(0)) and (not op(1))) and add(2))
         or (((op(0)) and (not op(1))) and subtract(2))
         or (((not op(0)) and (op(1))) and left(2))
          or ((op(0) and op(1)) and right(2));
   c(3) <= (((not op(0)) and (not op(1))) and add(3))
         or (((op(0)) and (not op(1))) and subtract(3))
         or (((not op(0)) and (op(1))) and left(3))
          or ((op(0) and op(1)) and right(3));
   c(4) <= (((not op(0)) and (not op(1))) and add(4))
         or (((op(0)) and (not op(1))) and subtract(4))
         or (((not op(0)) and (op(1))) and left(4))
          or ((op(0) and op(1)) and right(4));
   c(5) <= (((not op(0)) and (not op(1))) and add(5))
         or (((op(0)) and (not op(1))) and subtract(5))
         or (((not op(0)) and (op(1))) and left(5))
          or ((op(0) and op(1)) and right(5));
   c(6) <= (((not op(0)) and (not op(1))) and add(6))
         or (((op(0)) and (not op(1))) and subtract(6))
         or (((not op(0)) and (op(1))) and left(6))
          or ((op(0) and op(1)) and right(6));
   c(7) <= (((not op(0)) and (not op(1))) and add(7))
         or (((op(0)) and (not op(1))) and subtract(7))
         or (((not op(0)) and (op(1))) and left(7))
          or ((op(0) and op(1)) and right(7));
end Struct;