library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity TopLevel is
   port(d1, d0: in std_logic_vector(3 downto 0);
        s1, s0: out std_logic_vector(3 downto 0));
end entity;
architecture Struct of TopLevel is
	signal validD0, validD1, add0, add1: std_logic_vector(3 downto 0);
  signal op: std_logic_vector(1 downto 0);
begin
   v0: BCD_valid port map (inp => d0, op => validD0);
   v1: BCD_valid port map (inp => d1, op => validD1);
   m1: BCD_Valid_One_Bit port map (inp => d0, op => op(0));
   m2: BCD_Valid_One_Bit port map (inp => d1, op => op(1));

   add: BCD_Adder port map(d0 => d0, d1 => d1, s0 => add0, s1 => add1);
   s0(0) <= (((not op(0)) and (not op(1))) and validD0(0))
         or (((op(0)) and (not op(1))) and validD0(0))
         or (((not op(0)) and (op(1))) and validD0(0))
          or ((op(0) and op(1)) and add0(0));
   s0(1) <= (((not op(0)) and (not op(1))) and validD0(1))
         or (((op(0)) and (not op(1))) and validD0(1))
         or (((not op(0)) and (op(1))) and validD0(1))
          or ((op(0) and op(1)) and add0(1));
   s0(2) <= (((not op(0)) and (not op(1))) and validD0(2))
         or (((op(0)) and (not op(1))) and validD0(2))
         or (((not op(0)) and (op(1))) and validD0(2))
          or ((op(0) and op(1)) and add0(2));
   s0(3) <= (((not op(0)) and (not op(1))) and validD0(3))
         or (((op(0)) and (not op(1))) and validD0(3))
         or (((not op(0)) and (op(1))) and validD0(3))
          or ((op(0) and op(1)) and add0(3));

   s1(0) <= (((not op(0)) and (not op(1))) and validD1(0))
         or (((op(0)) and (not op(1))) and validD1(0))
         or (((not op(0)) and (op(1))) and validD1(0))
          or ((op(0) and op(1)) and add1(0));
   s1(1) <= (((not op(0)) and (not op(1))) and validD1(1))
         or (((op(0)) and (not op(1))) and validD1(1))
         or (((not op(0)) and (op(1))) and validD1(1))
          or ((op(0) and op(1)) and add1(1));
   s1(2) <= (((not op(0)) and (not op(1))) and validD1(2))
         or (((op(0)) and (not op(1))) and validD1(2))
         or (((not op(0)) and (op(1))) and validD1(2))
          or ((op(0) and op(1)) and add1(2));
   s1(3) <= (((not op(0)) and (not op(1))) and validD1(3))
         or (((op(0)) and (not op(1))) and validD1(3))
         or (((not op(0)) and (op(1))) and validD1(3))
          or ((op(0) and op(1)) and add1(3));
end Struct;