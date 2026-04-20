library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Comb_Logic is
    port(
        ABUS, BBUS : in  std_logic_vector(15 downto 0);

        ALU_CTRL   : in std_logic_vector(2 downto 0);
        SH_CTRL    : in std_logic_vector(1 downto 0);
        MUX_Sel    : in std_logic_vector(1 downto 0);
        MUX_EN     : in std_logic;

        RESULT     : out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of Comb_Logic is

    signal ALU_Out_inner  : std_logic_vector(15 downto 0);
    signal Sh_Out_inner   : std_logic_vector(15 downto 0);
    signal LUT_Out_inner  : std_logic_vector(15 downto 0);

    signal lut_out : std_logic_vector(7 downto 0);

begin

    Nonlinear_Lookup: entity work.LUT
        port map(
            input  => ABUS(7 downto 0),
            output => lut_out
        );

    LUT_Out_inner <= ABUS(15 downto 8) & lut_out;

    ALU: entity work.ALU
        port map(
            input_A  => ABUS,
            input_B  => BBUS,
            input_CTRL => ALU_CTRL,
            OUTPUT   => ALU_Out_inner
        );

    Shifter_Unit: entity work.Shifter
        port map(
            input      => BBUS,
            input_CTRL => SH_CTRL,
            output     => Sh_Out_inner
        );

    process(ALU_Out_inner, Sh_Out_inner, LUT_Out_inner, MUX_Sel, MUX_EN)
    begin

        if MUX_EN = '0' then
            RESULT <= (others => '0');

        else
            case MUX_Sel is

                when "00" =>
                    RESULT <= ALU_Out_inner;

                when "01" =>
                    RESULT <= Sh_Out_inner;

                when "10" =>
                    RESULT <= LUT_Out_inner;

                when others =>
                    RESULT <= (others => '0');

            end case;

        end if;

    end process;

end architecture;