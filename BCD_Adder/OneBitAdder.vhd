library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity OneBitAdder is
   port(a, b, cin: in std_logic;
        s, cout: out std_logic);
end entity;
architecture Struct of OneBitAdder is
signal s1: std_logic;
begin
   X1: XOR1 port map (a => a, b => b, s => s1);
   X2: XOR1 port map (a => s1, b => cin, s=> s);
   --s <= a xor b xor cin;
   cout <= (cin and s1) or (a and b);
end Struct;