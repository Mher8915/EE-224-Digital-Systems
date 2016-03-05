library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package BCD_Components is
   component BCD_Valid is
   port (inp: in std_logic_vector(3 downto 0); op: out std_logic_vector(3 downto 0));
   end component;
   component BCD_Valid_One_Bit is
   port (inp: in std_logic_vector(3 downto 0); op: out std_logic);
   end component;
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
   component FourBitAdder is
	port (a, b: in std_logic_vector(3 downto 0);
        cin: in std_logic;
	 	    c: out std_logic_vector(3 downto 0);
        cout: out std_logic);
   end component;
   component Multi_Input_MUX is
   port(inp1: in std_logic_vector(3 downto 0);
        cin1: in std_logic;
        inp0: in std_logic_vector(3 downto 0);
        cin0: in std_logic;
        choose: in std_logic;
        op: out std_logic_vector(3 downto 0);
        cout: out std_logic);
   end component;
  component BCD_Adder is
   port(d1, d0: in std_logic_vector(3 downto 0);
        s1, s0: out std_logic_vector(3 downto 0));
   end component;
   component TopLevel is
   port(d1, d0: in std_logic_vector(3 downto 0);
        s1, s0: out std_logic_vector(3 downto 0));
   end component;
end BCD_Components;

