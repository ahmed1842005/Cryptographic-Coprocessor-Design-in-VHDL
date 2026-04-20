library ieee;
use ieee.std_logic_1164.all;

entity Control_Unit_TB is
end entity;

architecture sim of Control_Unit_TB is

    signal instruction : std_logic_vector(15 downto 0);

    signal MUX_EN   : std_logic;
    signal ALU_CTRL : std_logic_vector(2 downto 0);
    signal SH_CTRL  : std_logic_vector(1 downto 0);
    signal MUX_Sel  : std_logic_vector(1 downto 0);

begin

    Control_Logic: entity work.Control_Unit
        port map(
            instruction => instruction,
            MUX_EN => MUX_EN,
            ALU_CTRL => ALU_CTRL,
            SH_CTRL => SH_CTRL,
            MUX_Sel     => MUX_Sel
        );

    process
    begin

        instruction <= "1111111111111111";
        wait for 10 ns;	 
		

        instruction <= "0000000000000000"; -- ADD
        wait for 10 ns;

        instruction <= "0001000000000000"; -- SUB
        wait for 10 ns;

        instruction <= "0010000000000000"; -- AND
        wait for 10 ns;

        instruction <= "0011000000000000"; -- OR
        wait for 10 ns;


        instruction <= "1000000000000000"; -- SH = 01
        wait for 10 ns;

        instruction <= "1001000000000000"; -- SH = 10
        wait for 10 ns;

        instruction <= "1010000000000000"; -- SH = 11
        wait for 10 ns;


        instruction <= "1011000000000000";
        wait for 10 ns;   
		

        instruction <= "1100000000000000"; 
        wait for 10 ns;

        instruction <= "0100000000000000"; 

        wait;

    end process;

end architecture;