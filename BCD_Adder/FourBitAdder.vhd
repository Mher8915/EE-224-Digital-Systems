library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity FourBitAdder is
   port(a, b: in std_logic_vector(3 downto 0);
        cin: in std_logic;
        c: out std_logic_vector(3 downto 0);
        cout: out std_logic);
end entity;
architecture Struct of FourBitAdder is
	signal t1, t2, t3, t4: std_logic;
begin
   add1: OneBitAdder port map (a => a(0), b => b(0), cin => cin, s => c(0), cout => t1);
   add2: OneBitAdder port map (a => a(1), b => b(1), cin => t1, s => c(1), cout => t2);
   add3: OneBitAdder port map (a => a(2), b => b(2), cin => t2, s => c(2), cout => t3);
   add4: OneBitAdder port map (a => a(3), b => b(3), cin => t3, s => c(3), cout => cout);
end Struct;