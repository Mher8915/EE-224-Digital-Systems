library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity BCD_Adder is
   port(d1, d0: in std_logic_vector(3 downto 0);
        s1, s0: out std_logic_vector(3 downto 0));
end entity;
architecture Struct of BCD_Adder is
	signal out1,out2,out3,out4,out5,out6,out7: std_logic_vector(3 downto 0);
	signal c1,c2,c3,c4,c5,c6,c7: std_logic;
	signal check1,check2: std_logic;
begin
   -- Adding 9 with D1 to get S1
   add1: FourBitAdder port map (a => d0, b => "1001", cin => '0', cout => c1, c => out1);

   -- Adding 4 with D2 to get S2
   add2: FourBitAdder port map (a => d1, b => "0100", cin => c1, cout => c2, c => out2);

   -- Adding 6 with S1
   add3: FourBitAdder port map (a => out1, b => "0110", cin => '0', cout => c3, c => out3);

   -- Checking validity of S1
   valid1: BCD_Valid_One_Bit port map(inp => out1, op => check1);

   -- Mux choosing whether to add 6 or to take original
   mux1: Multi_Input_MUX port map (inp1 => out1, cin1 => '0', inp0 => out3, cin0 => c3,
   								   choose => check1, op => out4, cout => c4);
   s0 <= out4;
   -- Adding carry to S2 to get S2'
   add4: FourBitAdder port map (a => out2, b => "0000", cin => c4, c => out5, cout => c5);

   -- Adding 6 with S2'
   add5: FourBitAdder port map (a => out5, b => "0110", cin => '0', cout => c6, c => out6);

   -- Checking validity of S2'
   valid2: BCD_Valid_One_Bit port map(inp => out5, op => check2);

   -- Mux choosing whether to add 6 or to take original
   mux2: Multi_Input_MUX port map (inp1 => out5, cin1 => '0', inp0 => out6, cin0 => c6,
   								   choose => check2, op => out7, cout => c7);
   s1 <= out7;
end Struct;