library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity MUX1 is
   port(x0, x1, s: in std_logic;
        c: out std_logic);
end entity;
architecture Struct of MUX1 is
begin
   	c <= (s and x1) or ((not s) and x0);
end Struct;