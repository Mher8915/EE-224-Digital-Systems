library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopLevel is
  port (
         TDI : in std_logic; -- Test Data In
         TDO : out std_logic; -- Test Data Out
         TMS : in std_logic; -- TAP controller signal
         TCLK : in std_logic; -- Test clock
         TRST : in std_logic -- Test reset
       );
end TopLevel;

architecture Struct of TopLevel is
  -- declare DUT component
  component ALU is
    port (
    a, b: in std_logic_vector(7 downto 0);
    op: in std_logic_vector(1 downto 0);
    c: out std_logic_vector(7 downto 0));
  end component;

  -- declare Scan-chain component.
  component Scan_Chain is
    generic (
    in_pins : integer; -- Number of input pins
    out_pins : integer -- Number of output pins
  );
  port (
         TDI : in std_logic; -- Test Data In
         TDO : out std_logic; -- Test Data Out
         TMS : in std_logic; -- TAP controller signal
         TCLK : in std_logic; -- Test clock
         TRST : in std_logic; -- Test reset
         dut_in : out std_logic_vector(in_pins-1 downto 0); -- Input for the DUT
         dut_out : in std_logic_vector(out_pins-1 downto 0) -- Output from the DUT
       );
  end component;

  -- declare I/O signals to DUT component
  signal op: std_logic_vector(1 downto 0);
  signal a, b, c: std_logic_vector(7 downto 0);

  -- declare signals to Scan-chain component.
  signal scan_chain_parallel_in : std_logic_vector(17 downto 0);
  signal scan_chain_parallel_out: std_logic_vector(7 downto 0);
begin
  scan_instance: Scan_Chain
  generic map(in_pins => 18, out_pins => 8)
  port map (TDI => TDI,
            TDO => TDO,
            TMS => TMS,
            TCLK => TCLK,
            TRST => TRST,
            dut_in => scan_chain_parallel_in,
            dut_out => scan_chain_parallel_out);
  dut_instance: ALU
  port map(a => a, b => b, op => op, c => c);

  -- connections between DUT and Scan_Chain
  op <= scan_chain_parallel_in(17 downto 16);
  a <= scan_chain_parallel_in(15 downto 8);
  b <= scan_chain_parallel_in(7 downto 0);
  scan_chain_parallel_out <= c;
end Struct;
