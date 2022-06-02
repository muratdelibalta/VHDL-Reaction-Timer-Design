library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity clock_divider is
    generic (clk_freq    : integer := 100_000_000;
             clk_new     : integer := 100); 
    Port    (clk   : in    std_logic;
             c9    : out   std_logic);
             
end clock_divider;

architecture Behavioral of clock_divider is

constant timerlim  : integer := clk_freq/clk_new;

signal counter: integer range 0 to timerlim := 0;
signal tempclk: std_logic:='0';

begin

process(clk) begin
          
    if(clk'event and clk='1') then                       
        if(counter = (timerlim/2)-1) then
            tempclk <= not(tempclk);    
            counter <= 0; 
        else
            counter <= counter + 1;        
        end if;   
    end if;
       
end process;

c9 <= tempclk; 

end Behavioral;
