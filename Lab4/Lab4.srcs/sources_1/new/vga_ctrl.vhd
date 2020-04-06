----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2020 10:16:18 AM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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

entity vga_ctrl is
    Port ( clk : in STD_LOGIC;
           enable: in STD_LOGIC;
           hcount : inout STD_LOGIC_VECTOR (9 downto 0):= (others => '0');
           vcount : inout STD_LOGIC_VECTOR (9 downto 0):= (others => '0');
           vid : out STD_LOGIC;
           hs : out STD_LOGIC;
           vs : out STD_LOGIC);
end vga_ctrl;

architecture Behavioral of vga_ctrl is

signal firstRun : std_logic := '1';

begin

--Horizontal controller
process(clk)
begin
    if(rising_edge(clk)) then
        if(enable = '1') then
            if(unsigned(hcount) <799) then
                hcount <= std_logic_vector(unsigned(hcount) + 1);
            else 
                hcount <= (others =>'0');
                firstRun <= '0';    --The point of this is so the code doesn't 
                                    --skip the first vertical index. 
                                    --If you dont have it, the index just goes to v1 
            end if;
        end if;
    end if;
end process;


--Vertical Controller
process(clk)
begin
    if(rising_edge(clk)) then
        if(enable = '1') then
            if(unsigned(hcount) = 0 and firstRun = '0') then
                if (unsigned(vcount) < 524) then 
                vcount <= std_logic_vector(unsigned(vcount) + 1);
                else
                vcount <= (others =>'0');
                end if;
            else 
                vcount <= (others => '0');
            end if;
        end if;
    end if;
end process;


--Vid, HS, VS Controller
process(hcount,vcount)
begin
    if ((unsigned(hcount) < 636) and (unsigned(vcount) < 479)) then
        vid <= '1';
    else 
        vid <= '0';
    end if;
    
    if ((unsigned(hcount) > 655) and (unsigned (hcount) <751)) then
        hs <= '0';
    else 
        hs <= '1';
    end if;
    
      if ((unsigned(vcount) > 489) and (unsigned (vcount) < 491)) then
          vs <= '0';
      else 
          vs <= '1';
      end if;
end process;
end Behavioral;
