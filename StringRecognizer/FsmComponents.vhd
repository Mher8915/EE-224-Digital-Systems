library ieee;
use ieee.std_logic_1164.all;

package MyFsmPack is
  type fsm_bomb is (s_phi, s_b, s_bo, s_bom);
  type fsm_gun is (s_phi, s_g, s_gu);
  type fsm_knife is (s_phi, s_k, s_kn, s_kni, s_knif);
  type fsm_terror is (s_phi, s_t, s_te, s_ter, s_terr, s_terro);
  type input_symbol is (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, space, reset);
  type output_symbol is (y, n);

  component my_fsm_bomb is
     port (ip: in input_symbol;
           op: out output_symbol;
           cc: in std_logic);
  end component;

  component my_fsm_gun is
     port (ip: in input_symbol;
           op: out output_symbol;
           cc: in std_logic);
  end component;

  component my_fsm_knife is
     port (ip: in input_symbol;
           op: out output_symbol;
           cc: in std_logic);
  end component;

  component my_fsm_terror is
     port (ip: in input_symbol;
           op: out output_symbol;
           cc: in std_logic);
  end component;

  component StringRecognizer is
   port(inp: in std_logic_vector(5 downto 0);
      clock: in std_logic;
        op: out std_logic_vector(0 downto 0));
  end component;

  function BV_To_Input_Symbol(Y1: std_logic_vector)  return input_symbol;
  function BV_To_Output_Symbol(X: std_logic_vector)  return output_symbol;
  function Output_Symbol_To_Bit(x: output_symbol) return std_logic_vector;
end MyFsmPack;

package body MyFsmPack is
  function BV_To_Input_Symbol(Y1: std_logic_vector)  return input_symbol  is
     variable ret_var: input_symbol;
     variable X1: std_logic_vector(4 downto 0);
  begin
     X1 := Y1(4 downto 0);
     if (X1 = "00001") then
        ret_var := a;
     elsif (X1 = "00010") then
        ret_var := b;
     elsif (X1 = "00011") then
        ret_var := c;
     elsif (X1 = "00100") then
        ret_var := d;
     elsif (X1 = "00101") then
        ret_var := e;
     elsif (X1 = "00110") then
        ret_var := f;
     elsif (X1 = "00111") then
        ret_var := g;
     elsif (X1 = "01000") then
        ret_var := h;
     elsif (X1 = "01001") then
        ret_var := i;
     elsif (X1 = "01010") then
        ret_var := j;
     elsif (X1 = "01011") then
        ret_var := k;
     elsif (X1 = "01100") then
        ret_var := l;
     elsif (X1 = "01101") then
        ret_var := m;
     elsif (X1 = "01110") then
        ret_var := n;
     elsif (X1 = "01111") then
        ret_var := o;
     elsif (X1 = "10000") then
        ret_var := p;
     elsif (X1 = "10001") then
        ret_var := q;
     elsif (X1 = "10010") then
        ret_var := r;
     elsif (X1 = "10011") then
        ret_var := s;
     elsif (X1 = "10100") then
        ret_var := t;
     elsif (X1 = "10101") then
        ret_var := u;
     elsif (X1 = "10110") then
        ret_var := v;
     elsif (X1 = "10111") then
        ret_var := w;
     elsif (X1 = "11000") then
        ret_var := x;
     elsif (X1 = "11001") then
        ret_var := y;
     elsif (X1 = "11010") then
        ret_var := z;
     elsif (X1 = "11011") then
        ret_var := space;
     else
        ret_var := reset;
     end if;
     if (Y1(5) = '1') then
        ret_var := reset;
     end if;
     return(ret_var);
  end BV_To_Input_Symbol;

  function BV_To_Output_Symbol(X: std_logic_vector)  return output_symbol  is
     variable ret_var: output_symbol;
  begin
     if (X = "1") then
        ret_var := y;
     else
        ret_var := n;
     end if;
     return(ret_var);
  end BV_To_Output_Symbol;

  function Output_Symbol_To_Bit(X: output_symbol)  return std_logic_vector is
     variable ret_var: std_logic_vector(0 downto 0);
  begin
     if (X = y) then
        ret_var := "1";
     else
        ret_var := "0";
     end if;
     return(ret_var);
  end Output_Symbol_To_Bit;
end package body;