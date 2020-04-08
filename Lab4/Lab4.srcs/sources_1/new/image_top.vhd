----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2020 04:37:54 PM
-- Design Name: 
-- Module Name: image_top - Behavioral
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

entity image_top is
    Port ( clk : in STD_LOGIC;
           vga_hs : out STD_LOGIC;
           vga_vs : out STD_LOGIC;
           vga_r : out STD_LOGIC_VECTOR (4 downto 0);
           vga_g : out STD_LOGIC_VECTOR (5 downto 0);
           vga_b : out STD_LOGIC_VECTOR (4 downto 0));
end image_top;

architecture Behavioral of image_top is
signal enable: std_logic;
signal pixelOut : std_logic_vector(7 downto 0);
signal addFromPusher: std_logic_vector(17 downto 0);
signal middleVS : std_logic;
signal middleHcount: std_logic_vector(9 downto 0);
signal middleVid: std_logic;
signal middleVcount: std_logic_vector(9 downto 0);
--ClkDiv
component clock_div is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component clock_div;

--the COE picture
component picture IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component picture;

--Pixel Pusher
component pixel_pusher is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           VS : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           hcount : in STD_LOGIC_VECTOR (9 downto 0);
           vid : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (4 downto 0);
           G : out STD_LOGIC_VECTOR (5 downto 0);
           B : out STD_LOGIC_VECTOR (4 downto 0);
           addr : inout STD_LOGIC_VECTOR (17 downto 0):= (others => '0'));
end component pixel_pusher;

--VGA controller
component vga_ctrl is
    Port ( clk : in STD_LOGIC;
           enable: in STD_LOGIC;
           hcount : inout STD_LOGIC_VECTOR (9 downto 0);
           vcount : inout STD_LOGIC_VECTOR (9 downto 0);
           vid : out STD_LOGIC;
           hs : out STD_LOGIC;
           vs : out STD_LOGIC);
end component vga_ctrl;


begin
myCLK : clock_div
port map (
            clk_in => clk,
            clk_out => enable);
            
myPicture: picture
port map (
            clka => clk,
            addra => addFromPusher,
            douta => pixelOut);
            
myPusher: pixel_pusher
port map(
        clk => clk,
        enable => enable,
        VS =>middleVS,
        pixel => pixelOut,
        hcount =>middleHcount,
        vid =>middleVid,
        R => vga_r,
        G => vga_g,
        B =>vga_b,
        addr => addFromPusher);  
        
myVGA: vga_ctrl
port map(
           clk => clk,
           enable => enable,
           hcount => middleHcount,
           vcount => middleVcount, 
           vid => middleVid,
           vs => middleVS,
           hs => vga_hs);
           
vga_vs <= middleVS;
          
end Behavioral; 
    
