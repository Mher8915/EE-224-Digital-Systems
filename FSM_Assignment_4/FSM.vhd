library ieee;
use ieee.std_logic_1164.all;

package MyFsmPack is
  type fsm_state is (s_phi, s_a, s_ab, s_aba);
  type input_symbol is (reset, a, b);
  type output_symbol is (Y, N);

  component my_fsm is
     port (ip: in input_symbol;
           op: out output_symbol;
           cc: in std_logic);
  end component;

  component TopLevel is
   port(inp: in std_logic_vector(1 downto 0);
      clock: in std_logic;
        op: out std_logic_vector(0 downto 0));
  end component;

  function BV_To_Input_Symbol(X: std_logic_vector)  return input_symbol;
  function BV_To_Output_Symbol(X: std_logic_vector)  return output_symbol;
  function Output_Symbol_To_Bit(x: output_symbol) return std_logic_vector;
end MyFsmPack;

package body MyFsmPack is
  function BV_To_Input_Symbol(X: std_logic_vector)  return input_symbol  is
     variable ret_var: input_symbol;
  begin
     if (X = "00") then
        ret_var := a;
     elsif (X = "01") then
        ret_var := b;
     else
        ret_var := reset;
     end if;
     return(ret_var);
  end BV_To_Input_Symbol;

  function BV_To_Output_Symbol(X: std_logic_vector)  return output_symbol  is
     variable ret_var: output_symbol;
  begin
     if (X = "1") then
        ret_var := Y;
     else
        ret_var := N;
     end if;
     return(ret_var);
  end BV_To_Output_Symbol;

  function Output_Symbol_To_Bit(X: output_symbol)  return std_logic_vector is
     variable ret_var: std_logic_vector(0 downto 0);
  begin
     if (X = Y) then
        ret_var := "1";
     else
        ret_var := "0";
     end if;
     return(ret_var);
  end Output_Symbol_To_Bit;
end package body;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.MyFsmPack.all;
entity my_fsm is
  port (ip: in input_symbol;
        op: out output_symbol;
        cc: in std_logic);
end entity my_fsm;

architecture Behave of my_fsm is
  signal state_sig: fsm_state;
begin
process(cc)
   variable nstate: fsm_state;
   variable nop: output_symbol;
begin
  if (cc = '1') then
   -- default values.
   nstate := state_sig;
   nop := N;
   -- code the next-state and output
   -- functions using sequential code
   -- compute variables nstate, vY
   -- Note that reset condition is not
   -- checked here..
   case state_sig is
     when  s_phi =>
       if(ip = a) then
         nstate := s_a;
       else
         nstate := s_phi;
       end if;
     when s_a =>
       if(ip = a) then
         nstate := s_a;
       elsif (ip = b) then
         nstate := s_ab;
       else
         nstate := s_phi;
       end if;
     when s_ab =>
       if(ip = a) then
         nstate := s_aba;
       else
         nstate := s_phi;
       end if;
     when s_aba =>
         if (ip = b) then
           nstate := s_ab;
           nop := Y;
         elsif (ip = a) then
           nstate := s_a;
         else
           nstate := s_phi;
         end if;
   end case;
   -- now apply vY to output signal
   if(ip = reset) then
     op <= N;
   else
     op <= nop;
   end if;
   
   -- apply nstate to state after
   -- delay. Note that the
   -- reset condition is checked
   -- here.
   if(ip = reset) then
     state_sig <= s_phi;
   else
     state_sig <= nstate;
   end if;
 end if;
end process;
end Behave;



