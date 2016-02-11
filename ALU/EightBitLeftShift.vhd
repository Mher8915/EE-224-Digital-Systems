library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ALU_Components.all;
entity EightBitLeftShift is
   port(a, b: in std_logic_vector(7 downto 0);
        c: out std_logic_vector(7 downto 0));
end entity;
architecture Struct of EightBitLeftShift is
signal t: std_logic_vector(7 downto 0);
signal k: std_logic_vector(7 downto 0);
begin
   m1: MUX1 port map (x0 => a(7), x1 => a(3), s => b(2), c => t(7));
   m2: MUX1 port map (x0 => a(6), x1 => a(2), s => b(2), c => t(6));
   m3: MUX1 port map (x0 => a(5), x1 => a(1), s => b(2), c => t(5));
   m4: MUX1 port map (x0 => a(4), x1 => a(0), s => b(2), c => t(4));
   m5: MUX1 port map (x0 => a(3), x1 => '0', s => b(2), c => t(3));
   m6: MUX1 port map (x0 => a(2), x1 => '0', s => b(2), c => t(2));
   m7: MUX1 port map (x0 => a(1), x1 => '0', s => b(2), c => t(1));
   m8: MUX1 port map (x0 => a(0), x1 => '0', s => b(2), c => t(0));

   m9: MUX1 port map (x0 => t(7), x1 => t(5), s => b(1), c => k(7));
   m10: MUX1 port map (x0 => t(6), x1 => t(4), s => b(1), c => k(6));
   m11: MUX1 port map (x0 => t(5), x1 => t(3), s => b(1), c => k(5));
   m12: MUX1 port map (x0 => t(4), x1 => t(2), s => b(1), c => k(4));
   m13: MUX1 port map (x0 => t(3), x1 => t(1), s => b(1), c => k(3));
   m14: MUX1 port map (x0 => t(2), x1 => t(0), s => b(1), c => k(2));
   m15: MUX1 port map (x0 => t(1), x1 => '0', s => b(1), c => k(1));
   m16: MUX1 port map (x0 => t(0), x1 => '0', s => b(1), c => k(0));

   m17: MUX1 port map (x0 => k(7), x1 => k(6), s => b(0), c => c(7));
   m18: MUX1 port map (x0 => k(6), x1 => k(5), s => b(0), c => c(6));
   m19: MUX1 port map (x0 => k(5), x1 => k(4), s => b(0), c => c(5));
   m20: MUX1 port map (x0 => k(4), x1 => k(3), s => b(0), c => c(4));
   m21: MUX1 port map (x0 => k(3), x1 => k(2), s => b(0), c => c(3));
   m22: MUX1 port map (x0 => k(2), x1 => k(1), s => b(0), c => c(2));
   m23: MUX1 port map (x0 => k(1), x1 => k(0), s => b(0), c => c(1));
   m24: MUX1 port map (x0 => k(0), x1 => '0', s => b(0), c => c(0));
end Struct;