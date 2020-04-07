----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2020 07:19:25 PM
-- Design Name: 
-- Module Name: imageTop_tb - Behavioral
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

entity imageTop_tb is
--  Port ( );
end imageTop_tb;

architecture Behavioral of imageTop_tb is

component image_top is
    Port ( clk : in STD_LOGIC;
           vga_hs : out STD_LOGIC;
           vga_vs : out STD_LOGIC;
           vga_r : out STD_LOGIC_VECTOR (4 downto 0);
           vga_g : out STD_LOGIC_VECTOR (5 downto 0);
           vga_b : out STD_LOGIC_VECTOR (4 downto 0));
end component image_top;
signal clk, vga_hs, vga_vs : std_logic;
signal vga_r, vga_b : STD_LOGIC_VECTOR (4 downto 0);
signal vga_g : std_logic_vector(5 downto 0);
begin
dut: image_top
port map(
        clk => clk,
        vga_hs => vga_hs,
        vga_vs => vga_vs,
        vga_r => vga_r,
        vga_b => vga_b,
        vga_g => vga_g);
        
process begin
                    clk <= '0';
                    wait for 4 ns;
                    clk <= '1';
                    wait for 4 ns;
                end process;

end Behavioral;
