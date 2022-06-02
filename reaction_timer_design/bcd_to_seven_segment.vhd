library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd2seven_segment is
    generic(clk_freq        : integer := 100_000_000);
    Port   (clk             : in std_logic;
            Reset           : in std_logic;
            w               : in std_logic;
            Pushn           : in std_logic;    
            LEDn            : out std_logic;
            anode_o         : out std_logic_vector(7 downto 0);
            seven_segment   : out std_logic_vector(7 downto 0));
            
end bcd2seven_segment;

architecture Behavioral of bcd2seven_segment is

component bcd_counter is
     Port (clk  : in std_logic;
           Reset: in std_logic;
           w    : in std_logic;
           Pushn: in std_logic;    
           c9   : out std_logic;
           LEDn : out std_logic;
           BCD1 : out std_logic_vector(3 downto 0);
           BCD0 : out std_logic_vector(3 downto 0));
           
end component;

constant timer1mslim    : integer := clk_freq/1000 ; -- 1 ms anodes geçiş süresi
signal 	 timer1ms   	: integer range 0 to timer1mslim 	:= 0;
signal   c9             : std_logic;
signal   anodes	        : std_logic_vector (7 downto 0) := "11111110";

signal 	ss_onlar    : std_logic_vector (7 downto 0):= (others => '1');
signal 	ss_birler   : std_logic_vector (7 downto 0):= (others => '1');    
signal 	onlar_int   : std_logic_vector (3 downto 0):= (others => '0');    
signal	birler_int  : std_logic_vector (3 downto 0):= (others => '0');    
signal  LEDm        : std_logic;
begin
bcd2ss : bcd_counter Port map (clk   => clk ,
                               Reset => Reset,
                               w     => w,
                               Pushn => Pushn,
                               c9    => c9,
                               LEDn  => LEDm,
                               BCD1  => onlar_int,
                               BCD0  => birler_int);

process(onlar_int, birler_int)
begin

case onlar_int is
when "0000" =>
ss_onlar <= "00000011";  --0
when "0001" =>     
ss_onlar <= "10011111";  --1
when "0010" =>         
ss_onlar <= "00100101";  --2
when "0011" =>         
ss_onlar <= "00001101";  --3
when "0100" =>        
ss_onlar <= "10011001";  --4
when "0101" =>       
ss_onlar <= "01001001";  --5
when "0110" =>       
ss_onlar <= "01000001";  --6
when "0111" =>         
ss_onlar <= "00011111";  --7
when "1000" =>         
ss_onlar <= "00000001";  --8
when "1001" =>         
ss_onlar <= "00001001";  --9
when others =>         
ss_onlar <= "11111111";  --kalanlar
end case;

case birler_int is
when "0000" =>
ss_birler <= "00000011";  --0
when "0001" =>         
ss_birler <=  "10011111"; --1
when "0010" =>         
ss_birler <=  "00100101"; --2
when "0011" =>         
ss_birler <= "00001101";  --3
when "0100" =>         
ss_birler <= "10011001";  --4
when "0101" =>         
ss_birler <= "01001001";  --5
when "0110" =>         
ss_birler <= "01000001";  --6
when "0111" =>         
ss_birler <= "00011111";  --7
when "1000" =>         
ss_birler <= "00000001";  --8
when "1001" =>         
ss_birler <= "00001001";  --9
when others =>         
ss_birler <= "11111111";   --kalanlar

end case;              

end process;

Anode : process (clk)

begin

    if(clk'event and clk = '1') then
       anodes(7 downto 2)	<= "111111";
       if (timer1ms = timer1mslim -1) then
           timer1ms     <= 0;
           anodes(1)    <= anodes(0);
           anodes(0)    <= anodes(1);    
       else
           timer1ms <= timer1ms + 1;     
       end if;        
    end if;

end process;

cathode : process(clk) 

begin

    if(clk'event and clk = '1') then
        if(anodes(0) = '0') then
            seven_segment <= ss_birler;
        elsif(anodes(1) = '0') then
            seven_segment <= ss_onlar;
        else
            seven_segment <= (others => '1');        
        end if;
    end if;
end process;

anode_o <= anodes;

LEDn <= not(LEDm); 
end Behavioral;
