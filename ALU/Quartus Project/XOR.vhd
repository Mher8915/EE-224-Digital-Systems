library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ALU_Components.all;
entity XOR1 is
   port(a, b: in std_logic;
        s: out std_logic);
end entity;
architecture Struct of XOR1 is
begin
   	s <= (a and (not b)) or ((not a) and b);
end Struct;