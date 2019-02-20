 

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

    -- Define interface with row
    component m_row is
    Port (  
            counter     : in  unsigned(7 downto 0)          := "00000000";
            red         : in  std_logic_vector(63 downto 0) := x"0000000000000000"; 
            green       : in  std_logic_vector(63 downto 0) := x"0000000000000000";
            blue        : in  std_logic_vector(63 downto 0) := x"0000000000000000";
            red_pwm     : out std_logic_vector(7  downto 0) := "00000000";
            green_pwm   : out std_logic_vector(7  downto 0) := "00000000";
            blue_pwm    : out std_logic_vector(7  downto 0) := "00000000"
           );
    end component;
    

    -- Clock prescaler
    signal prescaler       : unsigned(31 downto 0) := x"00000000";
    
    -- Prescaled clock counter
    signal counter         : unsigned(7 downto 0)  := "00000000";
    
   
--    -- Shift register to control which row to display
    signal row_shift_register : unsigned (7 downto 0) := "11111110";
    
--    -- Color intensities
    signal red_intensity    : std_logic_vector(63 downto 0) := x"0000000000000000"; 
    signal green_intensity  : std_logic_vector(63 downto 0) := x"0000000000000000";
    signal blue_intensity   : std_logic_vector(63 downto 0) := x"0000000000000000";
begin

prescaling_process: process (clk_8ns)
begin
   if rising_edge(clk_8ns) then
        prescaler <= prescaler + 1;
   end if;
end process;


counter_process: process (prescaler)
begin
-- 125MHz / 2*2^13 = 7629kHz
   if rising_edge(prescaler(12)) then
        counter <= counter + 1;
   end if;
end process;


row_process: process (prescaler)
begin
    if rising_edge(prescaler(11)) then
        -- Shift bits one bit to the left
        row_shift_register <= row_shift_register rol 1;
    end if;
end process;



color_picker_process: process(row_shift_register)
begin
--     FF = 100%
--     80 = 50%
--     00 = 0%    

--     Red
    case row_shift_register is
      when "11111110" => red_intensity <=    x"0000000000000000";
      when "11111101" => red_intensity <=    x"0000000000000000";
      when "11111011" => red_intensity <=    x"000000FF00000000";
      when "11110111" => red_intensity <=    x"0000000000000000";
      when "11101111" => red_intensity <=    x"0000000000000000";
      when "11011111" => red_intensity <=    x"0000000000000000";
      when "10111111" => red_intensity <=    x"0000000000000000";
      when "01111111" => red_intensity <=    x"0000000000000000";
      -- Others
      when others     => red_intensity <=    x"0000000000000000";
   end case;
   
   -- Green
   case row_shift_register is
      when "11111110" => green_intensity <=    x"0000000000000000";
      when "11111101" => green_intensity <=    x"0000000000000000";
      when "11111011" => green_intensity <=    x"00000000000000FF";
      when "11110111" => green_intensity <=    x"0000000000000000";
      when "11101111" => green_intensity <=    x"0000000000000000";
      when "11011111" => green_intensity <=    x"0000000000000000";
      when "10111111" => green_intensity <=    x"0000000000000000";
      when "01111111" => green_intensity <=    x"0000000000000000";
      -- Others
      when others     => green_intensity <=    x"0000000000000000";
   end case;
   
   -- Blue
   case row_shift_register is
      when "11111110" => blue_intensity <=    x"0000000000000000";
      when "11111101" => blue_intensity <=    x"0000000000000000";
      when "11111011" => blue_intensity <=    x"0000000000000000";
      when "11110111" => blue_intensity <=    x"0000000000000000";
      when "11101111" => blue_intensity <=    x"0000000000000000";
      when "11011111" => blue_intensity <=    x"FF00000000000000";
      when "10111111" => blue_intensity <=    x"0000000000000000";
      when "01111111" => blue_intensity <=    x"0000000000000000";
      -- Others
      when others     => blue_intensity <=    x"0000000000000000";
   end case;
   
   
   row <= std_logic_vector(row_shift_register);
end process;






row0:m_row
port map(
    counter     => counter,
    red         => red_intensity,
    green       => green_intensity,
    blue        => blue_intensity,
    red_pwm     => red,
    green_pwm   => green,                                                                                                                                                                                  
    blue_pwm    => blue
    );

end Behavioral;
