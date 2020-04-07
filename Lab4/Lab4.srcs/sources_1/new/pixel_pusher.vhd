----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2020 04:16:42 PM
-- Design Name: 
-- Module Name: pixel_pusher - Behavioral
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

entity pixel_pusher is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           VS : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           hcount : in STD_LOGIC_VECTOR (9 downto 0);
           vid : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (4 downto 0):= (others => '0');
           G : out STD_LOGIC_VECTOR (5 downto 0):= (others => '0');
           B : out STD_LOGIC_VECTOR (4 downto 0):= (others => '0');
           addr : inout STD_LOGIC_VECTOR (17 downto 0):= (others => '0'));
end pixel_pusher;

architecture Behavioral of pixel_pusher is

begin

--addr Control
process(clk, vid, enable, hcount, VS)
begin
    if (rising_edge(clk)) then
        if(VS = '0') then
            addr <= (others => '0');
        elsif (enable = '1' and vid = '1' and unsigned(hcount) <480) then 
            addr <= std_logic_vector(unsigned(addr)+1);
        end if;
    end if;
end process;

--RGB Control
process(clk, enable, vid, hcount)
begin 
    if(rising_edge(clk)) then
        if(enable = '1' and vid = '1' and unsigned(hcount) <480) then
            R <= pixel(7 downto 5) & "00";
            G <= pixel(4 downto 2) & "000";
            B <= pixel(1 downto 0) & "000";
        else 
            R <= (others => '0');
            G <= (others => '0');
            B <= (others => '0');
        end if;
    end if;
end process;
end Behavioral;
