library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_dff_led is
     Port (clk  : in std_logic;
           w    : in std_logic;
           Pushn: in std_logic;    
           c9   : out std_logic;
           LEDQ : out std_logic);
end mux_dff_led;

architecture Behavioral of mux_dff_led is


component clock_divider is
    generic (clk_freq    : integer := 100_000_000;
             clk_new     : integer := 100); 
    Port    (clk   : in    std_logic;
             c9    : out   std_logic);
             
end component;

signal 	clock_new   : 	std_logic := '0' ;
signal	D			: 	std_logic := '0' ;
signal	mux_out  	:   std_logic := '0' ;
signal 	Q 			:	std_logic := '0' ;
signal 	Q_not 		:	std_logic := '1' ;



begin

clk_divider : clock_divider port map(clk => clk,
                                     c9  => clock_new);

c9 <= clock_new;

mux_out <=
 Q   when    w= '0' else
'1'  when    w= '1';

LEDQ <= Q;
D <= mux_out and Pushn;

process (clock_new)

begin

    if (clock_new'event and clock_new = '1') then
        Q       <= D;
        Q_not   <= not(D);
    end if;
    
end process;    
                                    
end Behavioral;
