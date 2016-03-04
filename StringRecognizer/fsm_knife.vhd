library ieee;
use ieee.std_logic_1164.all;
library work;
use work.MyFsmPack.all;
entity my_fsm_knife is
  port (ip: in input_symbol;
        op: out output_symbol;
        cc: in std_logic);
end entity my_fsm_knife;

architecture Behave of my_fsm_knife is
  signal state_sig: fsm_knife;
begin
process(cc,ip)
   variable nstate: fsm_knife;
   variable nop: output_symbol;
begin
  if (cc = '1') then
   -- default values.
   nstate := state_sig;
   nop := n;
   -- code the next-state and output
   -- functions using sequential code
   -- compute variables nstate, vY
   -- Note that reset condition is not
   -- checked here..
   case state_sig is
     when  s_phi =>
       if(ip = k) then
         nstate := s_k;
       end if;
     when s_k =>
       if(ip = n) then
         nstate := s_kn;
       end if;
     when s_kn =>
       if(ip = i) then
         nstate := s_kni;
       end if;
     when s_kni =>
       if (ip = f) then
         nstate := s_knif;
       end if;
     when s_knif =>
       if (ip = e) then
         nstate := s_phi;
         nop := y;
       end if;
   end case;
   -- now apply vY to output signal
   if(ip = reset) then
     op <= n;
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



