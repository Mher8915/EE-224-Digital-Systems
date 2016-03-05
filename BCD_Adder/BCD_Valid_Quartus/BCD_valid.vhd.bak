library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity BCD_valid is
   port(inp: in std_logic_vector(3 downto 0);
        op: out std_logic_vector(3 downto 0));
end entity;
architecture Struct of BCD_valid is
begin
   op(3) <= inp(3);
   op(2) <= inp(2) or (inp(3) and inp(1));
   op(1) <= inp(1) or (inp(3) and inp(2));
   op(0) <= inp(0) or (inp(3) and (inp(2) or inp(1)));
end Struct;