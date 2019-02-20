

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simple_memory is
    Port ( row_addr       : in std_logic_vector (2 downto 0);
           data_red       : out std_logic_vector (63 downto 0);
           data_green     : out std_logic_vector (63 downto 0);
           data_blue      : out std_logic_vector (63 downto 0));
end simple_memory;

architecture Behavioral of simple_memory is

begin

    with row_addr select
    data_red <=     x"0000000000000000" when "000",
                    x"00FF000000000000" when "001",
                    x"0000000000000000" when "010",
                    x"0000000000000000" when "011",
                    x"0000000000000000" when "100",
                    x"0000000000000000" when "101",
                    x"0000000000000000" when "110",
                    x"0000000000000000" when "111",
                    
                    x"0000000000000000" when others;

--    data_red <=     x"ffffffffffffffff" when "000",
--                    x"ff000000000000ff" when "001",
--                    x"ff000000000000ff" when "010",
--                    x"ff000000ff0000ff" when "011",
--                    x"ff0000ffff0000ff" when "100",
--                    x"ff000000000000ff" when "101",
--                    x"ff000000000000ff" when "110",
--                    x"ffffffffffffffff" when "111",
                    
--                    x"0000000000000000" when others;

                    
    with row_addr select
    data_green <=   x"0000000000000000" when "000",
                    x"0000000000000000" when "001",
                    x"0000000000000000" when "010",
                    x"0000000000000000" when "011",
                    x"00000000000000FF" when "100",
                    x"0000000000000000" when "101",
                    x"0000000000000000" when "110",
                    x"0000000000000000" when "111",
                    
                    x"0000000000000000" when others;   
--     data_green <=   x"0000000000000000" when "000",
--                    x"00ffffffffffff00" when "001",
--                    x"00ff00000000ff00" when "010",
--                    x"00ff00ff0000ff00" when "011",
--                    x"00ff00ffff00ff00" when "100",
--                    x"00ff00000000ff00" when "101",
--                    x"00ffffffffffff00" when "110",
--                    x"0000000000000000" when "111",
                    
--                    x"0000000000000000" when others;                    

    with row_addr select
    data_blue <=    x"00FF00000000FF00" when "000",
                    x"0000000000000000" when "001",
                    x"0000000000000000" when "010",
                    x"0000000000000000" when "011",
                    x"0000000000000000" when "100",
                    x"FF00000000000000" when "101",
                    x"0000000000000000" when "110",
                    x"00000000000000FF" when "111",
                    
                    x"0000000000000000" when others;    
--    data_blue <=    x"0000000000000000" when "000",
--                    x"0000000000000000" when "001",
--                    x"0000ffffffff0000" when "010",
--                    x"0000ff00ffff0000" when "011",
--                    x"0000ff00ffff0000" when "100",
--                    x"0000ffffffff0000" when "101",
--                    x"0000000000000000" when "110",
--                    x"0000000000000000" when "111",
                    
--                    x"0000000000000000" when others;   
                    
end Behavioral;
