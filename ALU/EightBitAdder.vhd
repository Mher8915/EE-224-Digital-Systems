library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ALU_Components.all;
entity EightBitAdder is
   port(a, b: in std_logic_vector(7 downto 0);
        c: out std_logic_vector(7 downto 0));
end entity;
architecture Struct of EightBitAdder is
	signal t1, t2, t3, t4, t5, t6, t7, t8: std_logic;
begin
   add1: OneBitAdder port map (a => a(0), b => b(0), cin => '0', s => c(0), cout => t1);
   add2: OneBitAdder port map (a => a(1), b => b(1), cin => t1, s => c(1), cout => t2);
   add3: OneBitAdder port map (a => a(2), b => b(2), cin => t2, s => c(2), cout => t3);
   add4: OneBitAdder port map (a => a(3), b => b(3), cin => t3, s => c(3), cout => t4);
   add5: OneBitAdder port map (a => a(4), b => b(4), cin => t4, s => c(4), cout => t5);
   add6: OneBitAdder port map (a => a(5), b => b(5), cin => t5, s => c(5), cout => t6);
   add7: OneBitAdder port map (a => a(6), b => b(6), cin => t6, s => c(6), cout => t7);
   add8: OneBitAdder port map (a => a(7), b => b(7), cin => t7, s => c(7), cout => t8);
end Struct;