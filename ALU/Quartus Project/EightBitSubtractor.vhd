library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ALU_Components.all;
entity EightBitSubtractor is
   port(a, b: in std_logic_vector(7 downto 0);
        c: out std_logic_vector(7 downto 0));
end entity;
architecture Struct of EightBitSubtractor is
	signal k: std_logic_vector(7 downto 0);
   signal t: std_logic_vector(7 downto 0);
begin
   k <= not b;
   add1: EightBitAdder port map (a => k, b => "00000001", c => t);
   add2: EightBitAdder port map( a => a, b => t, c => c);
end Struct;