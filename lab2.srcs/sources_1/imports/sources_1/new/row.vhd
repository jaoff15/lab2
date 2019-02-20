

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity m_row is
    Port ( 
            counter      : in  unsigned(7 downto 0)  := "00000000";
            red          : in  std_logic_vector (63 downto 0);
            green        : in  std_logic_vector (63 downto 0);
            blue         : in  std_logic_vector (63 downto 0);
            red_pwm      : out std_logic_vector (7 downto 0) := "00000000";
            green_pwm    : out std_logic_vector (7 downto 0) := "00000000";
            blue_pwm     : out std_logic_vector (7 downto 0) := "00000000"
            );
end m_row;

architecture Behavioral of m_row is
    component m_color_channel is
    Port (  
            counter     : in  unsigned(7 downto 0)          := "00000000";
            red         : in  std_logic_vector(7 downto 0)  := "00000000";
            green       : in  std_logic_vector(7 downto 0)  := "00000000";
            blue        : in  std_logic_vector(7 downto 0)  := "00000000";
            red_pwm     : out std_logic                     := '0';
            green_pwm   : out std_logic                     := '0';
            blue_pwm    : out std_logic                     := '0'
           );
    end component;
begin

color_channel0:m_color_channel
port map(
    counter     => counter,
    red         => red(7 downto 0),
    green       => green(7 downto 0),
    blue        => blue(7 downto 0),
    red_pwm     => red_pwm(0),
    green_pwm   => green_pwm(0),
    blue_pwm    => blue_pwm(0)
);

color_channel1:m_color_channel
port map(
    counter     => counter,
    red         => red(15 downto 8),
    green       => green(15 downto 8),
    blue        => blue(15 downto 8),
    red_pwm     => red_pwm(1),
    green_pwm   => green_pwm(1),
    blue_pwm    => blue_pwm(1)
);

color_channel2:m_color_channel
port map(
    counter     => counter,
    red         => red(23 downto 16),
    green       => green(23 downto 16),
    blue        => blue(23 downto 16),
    red_pwm     => red_pwm(2),
    green_pwm   => green_pwm(2),
    blue_pwm    => blue_pwm(2)
);

color_channel3:m_color_channel
port map(
    counter     => counter,
    red         => red(31 downto 24),
    green       => green(31 downto 24),
    blue        => blue(31 downto 24),
    red_pwm     => red_pwm(3),
    green_pwm   => green_pwm(3),
    blue_pwm    => blue_pwm(3)
);

color_channel4:m_color_channel
port map(
    counter     => counter,
    red         => red(39 downto 32),
    green       => green(39 downto 32),
    blue        => blue(39 downto 32),
    red_pwm     => red_pwm(4),
    green_pwm   => green_pwm(4),
    blue_pwm    => blue_pwm(4)
);

color_channel5:m_color_channel
port map(
    counter     => counter,
    red         => red(47 downto 40),
    green       => green(47 downto 40),
    blue        => blue(47 downto 40),
    red_pwm     => red_pwm(5),
    green_pwm   => green_pwm(5),
    blue_pwm    => blue_pwm(5)
);

color_channel6:m_color_channel
port map(
    counter     => counter,
    red         => red(55 downto 48),
    green       => green(55 downto 48),
    blue        => blue(55 downto 48),
    red_pwm     => red_pwm(6),
    green_pwm   => green_pwm(6),
    blue_pwm    => blue_pwm(6)
);

color_channel7:m_color_channel
port map(
    counter     => counter,
    red         => red(63 downto 56),
    green       => green(63 downto 56),
    blue        => blue(63 downto 56),
    red_pwm     => red_pwm(7),
    green_pwm   => green_pwm(7),
    blue_pwm    => blue_pwm(7)
);


end Behavioral;
