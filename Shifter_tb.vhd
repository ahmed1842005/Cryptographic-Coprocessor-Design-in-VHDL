library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shifter_TB is
end entity;

architecture sim of Shifter_TB is

    component Shifter
        port(
            input      : in  std_logic_vector(15 downto 0);
            input_CTRL : in  std_logic_vector(1 downto 0);
            output     : out std_logic_vector(15 downto 0)
        );
    end component;

    signal flag_input  : std_logic_vector(15 downto 0);
    signal flag_CTRL   : std_logic_vector(1 downto 0);
    signal flag_output : std_logic_vector(15 downto 0);

begin

    DUT: Shifter
        port map(
            input      => flag_input,
            input_CTRL => flag_CTRL,
            output     => flag_output
        );

    process
    begin
        
        -- Test 1: Pass
        flag_input <= x"00FF";
        flag_CTRL  <= "00";
        wait for 20 ns;

        -- Test 2: Rotate Right 8
        flag_CTRL <= "01";
        wait for 20 ns;

        -- Test 3: Rotate Right 4
        flag_CTRL <= "10";
        wait for 20 ns;       

        -- Test 4: Shift Left 8
        flag_CTRL <= "11";
        wait for 20 ns;

        -- Test 5: New Input
        flag_input <= x"F0F0";

        flag_CTRL <= "00";
        wait for 20 ns;

        flag_CTRL <= "01";
        wait for 20 ns;

        flag_CTRL <= "10";
        wait for 20 ns;

        flag_CTRL <= "11";
        wait for 20 ns;

        wait;
    end process;

end architecture;
