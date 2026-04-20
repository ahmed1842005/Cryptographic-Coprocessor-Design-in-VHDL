library ieee;
use ieee.std_logic_1164.all;

entity Comb_Logic_TB is
end entity;

architecture sim of Comb_Logic_TB is

    signal ABUS, BBUS : std_logic_vector(15 downto 0);

    signal ALU_CTRL : std_logic_vector(2 downto 0);
    signal SH_CTRL : std_logic_vector(1 downto 0);
    signal MUX_Sel : std_logic_vector(1 downto 0);
    signal MUX_EN : std_logic;

    signal RESULT : std_logic_vector(15 downto 0);

begin

    DUT: entity work.Comb_Logic
        port map(
            ABUS => ABUS,
            BBUS => BBUS,
            ALU_CTRL => ALU_CTRL,
            SH_CTRL => SH_CTRL,
            MUX_Sel => MUX_Sel,
            MUX_EN => MUX_EN,
            RESULT => RESULT
        );

    process
    begin

        --------------------------------------------------
        -- 1) DISABLED MODE
        --------------------------------------------------
        ABUS <= "1010101010101010";
        BBUS <= "0101010101010101";

        MUX_EN  <= '0';
        wait for 10 ns;

        --------------------------------------------------
        -- 2) ALU TEST
        --------------------------------------------------
        MUX_EN  <= '1';
        MUX_Sel <= "00";

        ABUS <= "0000000000001010";
        BBUS <= "0000000000000011";

        ALU_CTRL <= "001";
        wait for 10 ns;

        ALU_CTRL <= "010";
        wait for 10 ns;

        ALU_CTRL <= "011";
        wait for 10 ns;

        --------------------------------------------------
        -- 3) SHIFTER TEST
        --------------------------------------------------
        MUX_Sel <= "01";

        BBUS <= "0000000000000001";

        SH_CTRL <= "01";
        wait for 10 ns;

        SH_CTRL <= "10";
        wait for 10 ns;

        SH_CTRL <= "11";
        wait for 10 ns;

        --------------------------------------------------
        -- 4) LUT TEST
        --------------------------------------------------
        MUX_Sel <= "10";

        ABUS <= "0001001000110100";
        wait for 10 ns;

        ABUS <= "1111000011110000";
        wait for 10 ns;

        --------------------------------------------------
        -- 5) MIXED TEST
        --------------------------------------------------
        MUX_Sel <= "00";
        ALU_CTRL <= "100";

        ABUS <= "0000000000001111";
        BBUS <= "0000000000000010";

        wait for 10 ns;

        wait;
    end process;

end architecture;