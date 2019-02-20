

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity led_matrix is
    Port ( pwm_clock    : in std_logic;
           row_clock    : in std_logic;
           row          : out std_logic_vector (7 downto 0);
           red          : out std_logic_vector (7 downto 0);
           green        : out std_logic_vector (7 downto 0);
           blue         : out std_logic_vector (7 downto 0)
           );
end led_matrix;

architecture Behavioral of led_matrix is
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
    
    
    -- Define interface with simple_memory
    component simple_memory is
    Port(
            row_addr       : in STD_LOGIC_VECTOR (2 downto 0);
            data_red       : out STD_LOGIC_VECTOR (63 downto 0);
            data_green     : out STD_LOGIC_VECTOR (63 downto 0);
            data_blue      : out STD_LOGIC_VECTOR (63 downto 0)
    );
    end component;
    
    -- Prescaled clock counter
    signal counter              : unsigned(7 downto 0)  := "00000000";
    
    -- Row counter
    signal row_counter          : unsigned(2 downto 0) := "000";
    
    
    -- Define states
    constant STATE_SHIFT_ROW    : std_logic := '0';
    constant STATE_READY        : std_logic := '1'; 
    
    -- State
    signal state                : std_logic := STATE_SHIFT_ROW;

    -- Color threshold signals
    signal red_sig              : std_logic_vector(63 downto 0) := x"0000000000000000";
    signal green_sig            : std_logic_vector(63 downto 0) := x"0000000000000000";
    signal blue_sig             : std_logic_vector(63 downto 0) := x"0000000000000000";
    
    -- Color pwm signals
    signal red_pwm_sig          : std_logic_vector(7 downto 0) := "00000000";
    signal green_pwm_sig        : std_logic_vector(7 downto 0) := "00000000";
    signal blue_pwm_sig         : std_logic_vector(7 downto 0) := "00000000";
begin

-- Increment counter
counter_process: process (pwm_clock)
begin
   if rising_edge(pwm_clock) then
        counter <= counter + 1;
   end if;
end process;

-- State machine
row_counter_process: process (row_clock)
begin
   if rising_edge(row_clock) then
       -- State shift row
       if state = STATE_SHIFT_ROW then
            red     <= red_pwm_sig;
            green   <= green_pwm_sig;
            blue    <= blue_pwm_sig;
            
           case row_counter is
              when "000"  => row <= "01111111";
              when "001"  => row <= "10111111";
              when "010"  => row <= "11011111";
              when "011"  => row <= "11101111";
              when "100"  => row <= "11110111";
              when "101"  => row <= "11111011";
              when "110"  => row <= "11111101";
              when "111"  => row <= "11111110";
              when others => row <= "11111111";
           end case;
 
            state <= STATE_READY;
            
       -- State ready
       elsif state = STATE_READY then
            row_counter <= row_counter + 1;
            state       <= STATE_SHIFT_ROW;
       
       else
            state <= STATE_SHIFT_ROW;
       end if;
   end if;
end process;

-- Create instance of row component
row0:m_row
port map(
    counter     => counter,
    red         => red_sig,
    green       => green_sig,
    blue        => blue_sig,
    red_pwm     => red_pwm_sig,
    green_pwm   => green_pwm_sig,                                                                                                                                                                                  
    blue_pwm    => blue_pwm_sig
);

-- Create instance of simple_memory component
simple_memory0: simple_memory
port map(
    row_addr       => std_logic_vector(row_counter),
    data_red       => red_sig,
    data_green     => green_sig,
    data_blue      => blue_sig
);

end Behavioral;
