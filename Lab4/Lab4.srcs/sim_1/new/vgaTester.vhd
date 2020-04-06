----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2020 01:11:14 PM
-- Design Name: 
-- Module Name: vgaTester - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vgaTester is
--  Port ( );
end vgaTester;

architecture Behavioral of vgaTester is
component vga_ctrl
Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           hcount : inout STD_LOGIC_VECTOR (9 downto 0);
           vcount : inout STD_LOGIC_VECTOR (9 downto 0);
           vid : out STD_LOGIC;
           hs : out STD_LOGIC;
           vs : out STD_LOGIC);
end component vga_ctrl;
signal enable, clk, vid, hs, vs : std_logic := '0';
signal hcount, vcount : std_logic_vector (9 downto 0);
begin
dut : vga_ctrl
port map(
    clk => clk,
    enable => enable,
    vid => vid,
    hs => hs,
    vs => vs,
    hcount => hcount,
    vcount => vcount);
    
process begin
            clk <= '0';
            wait for 4 ns;
            clk <= '1';
            wait for 4 ns;
        end process;
        
process begin
    wait for 20 ns;
    enable <= '1';
    wait for 100 ms ;
    enable <= '0';
    
    end process;
end Behavioral;
