library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity bcd_counter_tb is
end;

architecture bench of bcd_counter_tb is

  component bcd_counter
       Port (clk  : in std_logic;
             Reset: in std_logic;
             w    : in std_logic;
             Pushn: in std_logic;    
             c9   : out std_logic;
             LEDn : out std_logic;
             BCD1 : out std_logic_vector(3 downto 0);
             BCD0 : out std_logic_vector(3 downto 0));
  end component;

  signal clk: std_logic;
  signal Reset: std_logic;
  signal w: std_logic;
  signal Pushn: std_logic;
  signal c9: std_logic;
  signal LEDn: std_logic;
  signal BCD1: std_logic_vector(3 downto 0);
  signal BCD0: std_logic_vector(3 downto 0);

  constant clock_period: time := 10 ns;

begin

  uut: bcd_counter port map ( clk   => clk,
                              Reset => Reset,
                              w     => w,
                              Pushn => Pushn,
                              c9    => c9,
                              LEDn  => LEDn,
                              BCD1  => BCD1,
                              BCD0  => BCD0 );

  stimulus: process
  begin
  Reset  <= '1';
  w      <= '0';
  Pushn  <= '0';
  wait for 10 ms; 
  Reset <= '0';
  Pushn <= '1';
  wait for 15 ms;  
  w      <= '1';
  wait for 10 ms;  
  w      <= '0';
  wait for 165 ms;
  Pushn <= '0';
  wait;
  end process;
  
  clocking: process
  begin
    clk <= '0';
    wait for clock_period/2;
    clk <= '1';
    wait for clock_period/2;

  end process;

end;
  