library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity bcd2seven_segment_tb is
end;

architecture bench of bcd2seven_segment_tb is

  component bcd2seven_segment
      generic(clk_freq        : integer := 100_000_000);
      Port   (clk             : in std_logic;
              Reset           : in std_logic;
              w               : in std_logic;
              Pushn           : in std_logic;    
              c9              : out std_logic;
              LEDn            : out std_logic;
              anode_o         : out std_logic_vector(7 downto 0);
              seven_segment   : out std_logic_vector(7 downto 0));
  end component;

  signal clk: std_logic;
  signal Reset: std_logic;
  signal w: std_logic;
  signal Pushn: std_logic;
  signal c9: std_logic;
  signal LEDn: std_logic;
  signal anode_o: std_logic_vector(7 downto 0);
  signal seven_segment: std_logic_vector(7 downto 0);

  constant clock_period: time := 10 ns;

begin

  -- Insert values for generic parameters !!
  uut: bcd2seven_segment generic map ( clk_freq      => 100_000_000)
                            port map ( clk           => clk,
                                       Reset         => Reset,
                                       w             => w,
                                       Pushn         => Pushn,
                                       c9            => c9,
                                       LEDn          => LEDn,
                                       anode_o       => anode_o,
                                       seven_segment => seven_segment );


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
  