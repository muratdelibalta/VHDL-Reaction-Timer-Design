library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_counter is
     Port (clk  : in std_logic;
           Reset: in std_logic;
           w    : in std_logic;
           Pushn: in std_logic;    
           c9   : out std_logic;
           LEDn : out std_logic;
           BCD1 : out std_logic_vector(3 downto 0);
           BCD0 : out std_logic_vector(3 downto 0));
           
end bcd_counter;

architecture Behavioral of bcd_counter is

component mux_dff_led is
     Port (clk  : in std_logic;
           w    : in std_logic;
           Pushn: in std_logic;
           c9   : out std_logic;
           LEDQ : out std_logic);
           
end component;

signal clock_new	:   std_logic := '0' ;
signal E   		:   std_logic := '0' ;
signal birler_int  	:   std_logic_vector(3 downto 0) := (others => '0');
signal onlar_int  	:   std_logic_vector(3 downto 0) := (others => '0');

begin

subcirc : mux_dff_led Port map (clk     => clk,
                                w       => w,
                                Pushn   => Pushn,
                                c9      => clock_new,
                                LEDQ    => E);
                                
c9 <= clock_new ; 
LEDn <= not E;   

process (clock_new,reset,E, birler_int) 

begin
    if ( reset = '1') then
        birler_int  <= "0000";
        onlar_int   <= "0000";
    elsif (clock_new'event and clock_new = '1') then
        if ( E = '1') then
            if (birler_int = "1001") then  
                birler_int <= "0000";
                onlar_int <= onlar_int + 1;
            else
                birler_int <= birler_int +1;    
            end if; 
            if (onlar_int = "1001" and birler_int = "1001") then
                onlar_int <= "0000";
            end if;           
        end if;
    end if;

end process;

BCD0  <= birler_int;
BCD1  <= onlar_int;
    

end Behavioral;
