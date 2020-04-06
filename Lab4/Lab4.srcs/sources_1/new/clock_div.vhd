----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2020 08:43:51 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock_div;

architecture Behavioral of clock_div is
    signal counter : std_logic_vector(26 downto 0) := (others => '0');
begin
   process(clk_in)
   begin
   
        if rising_edge(clk_in) then
               if (unsigned (counter) = 4) then --25MHZ signal (125MHZ/25MHZ - 1)
                   clk_out <= '1';
                   counter <= (others => '0');
               else
               clk_out <= '0';
               counter <= std_logic_vector(unsigned(counter) + 1);
                   
               end if;
        end if;
   end process;
   
end Behavioral;
