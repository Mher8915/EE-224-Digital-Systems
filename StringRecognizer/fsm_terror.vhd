library ieee;
use ieee.std_logic_1164.all;
library work;
use work.MyFsmPack.all;
entity my_fsm_terror is
  port (ip: in input_symbol;
        op: out output_symbol;
        cc: in std_logic);
end entity my_fsm_terror;

architecture Behave of my_fsm_terror is
  signal state_sig: fsm_terror;
begin
process(cc,ip)
   variable nstate: fsm_terror;
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
       if(ip = t) then
         nstate := s_t;
       end if;
     when s_t =>
       if(ip = e) then
         nstate := s_te;
       end if;
     when s_te =>
       if(ip = r) then
         nstate := s_ter;
       end if;
     when s_ter =>
       if (ip = r) then
         nstate := s_terr;
       end if;
     when s_terr =>
       if (ip = o) then
         nstate := s_terro;
       end if;
     when s_terro =>
       if (ip = r) then
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



