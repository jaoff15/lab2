 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    Port (  
            clk_8ns     : in  std_logic;
            red         : out std_logic_vector (7 downto 0) := "00000000";
            green       : out std_logic_vector (7 downto 0) := "00000000";
            blue        : out std_logic_vector (7 downto 0) := "00000000";
            row         : out std_logic_vector (7 downto 0) := "00000000"
           );
end top;

architecture Behavioral of top is
    component led_matrix is
    Port (  
           pwm_clock    : in STD_LOGIC;
           row_clock    : in STD_LOGIC;
           row          : out STD_LOGIC_VECTOR (7 downto 0);
           red          : out STD_LOGIC_VECTOR (7 downto 0);
           green        : out STD_LOGIC_VECTOR (7 downto 0);
           blue         : out STD_LOGIC_VECTOR (7 downto 0)
           );
    end component;
  -- Clock prescaler
  signal prescaler            : unsigned(31 downto 0) := x"00000000";

begin

prescaling_process: process (clk_8ns)
begin
   if rising_edge(clk_8ns) then
        prescaler <= prescaler + 1;
   end if;
end process;


led_matrix0:led_matrix
port map(
    pwm_clock    => prescaler(12),
    row_clock    => prescaler(11),
    row          => row,
    red          => red,
    green        => green,
    blue         => blue
);


end Behavioral;
