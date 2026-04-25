									 library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Coprocessor is
    port (
        -- Clock & Reset
        CLK         : in  std_logic;
        RES         : in  std_logic;

        -- Input
        INSTRUCTION : in  std_logic_vector(15 downto 0);

        -- Output
        RESULT_OUT  : out std_logic_vector(15 downto 0)
    );
end entity;

architecture Structural of Coprocessor is

    signal ABUS_sig   : std_logic_vector(15 downto 0);
    signal BBUS_sig   : std_logic_vector(15 downto 0);
    signal RESULT_sig : std_logic_vector(15 downto 0);

    signal Ra_sig : std_logic_vector(3 downto 0);
    signal Rb_sig : std_logic_vector(3 downto 0);
    signal Rd_sig : std_logic_vector(3 downto 0);

    signal WEN_sig : std_logic;

    signal ALU_CTRL_sig : std_logic_vector(2 downto 0);
    signal SH_CTRL_sig  : std_logic_vector(1 downto 0);
    signal MUX_Sel_sig  : std_logic_vector(1 downto 0);
    signal MUX_EN_sig   : std_logic;

begin

   
    Rd_sig <= INSTRUCTION(11 downto 8);
    Ra_sig <= INSTRUCTION(7 downto 4);
    Rb_sig <= INSTRUCTION(3 downto 0);

    WEN_sig <= MUX_EN_sig;

    
    -- ?? Control Unit
   
    CU: entity work.Control_Unit
        port map(
            instruction => INSTRUCTION,
            MUX_EN      => MUX_EN_sig,
            ALU_CTRL    => ALU_CTRL_sig,
            SH_CTRL     => SH_CTRL_sig,
            MUX_Sel     => MUX_Sel_sig
        );

    
    -- ?? Register File
    
    RF: entity work.register_file
        port map(
            inputCLK   => CLK,
            inputRES   => RES,
            inputWEN   => WEN_sig,
            inputRa    => Ra_sig,
            inputRb    => Rb_sig,
            inputRd    => Rd_sig,
            inputDIN   => RESULT_sig,
            outputABUS => ABUS_sig,
            outputBBUS => BBUS_sig
        );

    
    -- ?? Combinational Logic
    
    CL: entity work.Comb_Logic
        port map(
            ABUS     => ABUS_sig,
            BBUS     => BBUS_sig,
            ALU_CTRL => ALU_CTRL_sig,
            SH_CTRL  => SH_CTRL_sig,
            MUX_Sel  => MUX_Sel_sig,
            MUX_EN   => MUX_EN_sig,
            RESULT   => RESULT_sig
        );

    
    -- ?? Output
   
    RESULT_OUT <= RESULT_sig;

end architecture;