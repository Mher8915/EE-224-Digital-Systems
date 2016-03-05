library ieee;
use ieee.std_logic_1164.all;
library work;
use work.BCD_Components.all;
entity Multi_Input_MUX is
   port(inp1: in std_logic_vector(3 downto 0);
   	    cin1: in std_logic;
   	    inp0: in std_logic_vector(3 downto 0);
   	    cin0: in std_logic;
   	    choose: in std_logic;
        op: out std_logic_vector(3 downto 0);
        cout: out std_logic);
end entity;
architecture Struct of Multi_Input_MUX is
begin
   op(3) <= (choose and inp1(3)) or ((not choose) and inp0(3));
   op(2) <= (choose and inp1(2)) or ((not choose) and inp0(2));
   op(1) <= (choose and inp1(1)) or ((not choose) and inp0(1));
   op(0) <= (choose and inp1(0)) or ((not choose) and inp0(0));
   cout <= (choose and cin1) or ((not choose) and cin0);
end Struct;