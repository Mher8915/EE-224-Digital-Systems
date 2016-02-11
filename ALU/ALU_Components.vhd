library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package ALU_Components is
   component XOR1 is
   port (a, b: in std_logic; s: out std_logic);
   end component;
   component mux1 is
   port (x0, x1, s: in std_logic;
        c: out std_logic);
   end component;
   component OneBitAdder is
	port (a, b, cin: in std_logic; s, cout: out std_logic);
   end component;
   component EightBitAdder is
	port (a, b: in std_logic_vector(7 downto 0);
	 	   c: out std_logic_vector(7 downto 0));
   end component;
      component EightBitSubtractor is
  port (a, b: in std_logic_vector(7 downto 0);
       c: out std_logic_vector(7 downto 0));
   end component;
   component EightBitRightShift is
   port (a: in std_logic_vector(7 downto 0);
         b: in std_logic_vector(7 downto 0);
        c: out std_logic_vector(7 downto 0));
   end component;
   component EightBitLeftShift is
   port (a: in std_logic_vector(7 downto 0);
         b: in std_logic_vector(7 downto 0);
        c: out std_logic_vector(7 downto 0));
   end component;
end ALU_Components;

