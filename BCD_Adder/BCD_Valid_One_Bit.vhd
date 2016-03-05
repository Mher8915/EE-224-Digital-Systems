library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity BCD_Valid_One_Bit is
   port(inp: in std_logic_vector(3 downto 0);
        op: out std_logic);
end entity;
architecture Struct of BCD_Valid_One_Bit is
signal op1: std_logic_vector(3 downto 0);
begin
   valid: BCD_valid port map (inp => inp, op => op1);
   op <= not(op1(3) and op1(2) and op1(1) and op1(0));
end Struct;