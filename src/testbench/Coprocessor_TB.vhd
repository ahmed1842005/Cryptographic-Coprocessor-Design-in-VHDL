library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Coprocessor_TB is

end entity;

architecture sim of Coprocessor_TB is

    signal CLK : std_logic := '0';
    signal RES : std_logic := '0';
    signal INSTRUCTION : std_logic_vector(15 downto 0) := (others => '0');
    signal RESULT_OUT  : std_logic_vector(15 downto 0);

    -- Constant definition for clock period (for easier modification later)
    constant clk_period : time := 10 ns;

begin

   
    DUT: entity work.Coprocessor
        port map(
            CLK         => CLK,
            RES         => RES,
            INSTRUCTION => INSTRUCTION,
            RESULT_OUT  => RESULT_OUT
        );

    -- Clock Generation
    CLK_process : process
    begin
        CLK <= '0';
        wait for clk_period / 2; -- 5 ns
        CLK <= '1';
        wait for clk_period / 2; -- 5 ns
    end process;

    
    stim_proc : process
begin

    RES <= '0';
   

    ----------------------------------------------------------------
    -- Part 1: ALU Tests (same operands 0001 & 0010)
    ----------------------------------------------------------------

    INSTRUCTION <= "0000" & "0000" & "0001" & "0010";  -- ADD
    wait for clk_period;

    INSTRUCTION <= "0001" & "0000" & "0001" & "0010";  -- SUB
    wait for clk_period;

    INSTRUCTION <= "0010" & "0000" & "0001" & "0010";  -- AND
    wait for clk_period;

    INSTRUCTION <= "0011" & "0000" & "0001" & "0010";  -- OR
    wait for clk_period;

    INSTRUCTION <= "0100" & "0000" & "0001" & "0010";  -- XOR
    wait for clk_period;

    INSTRUCTION <= "0101" & "0000" & "0001" & "0000";  -- NOT (operand A only)
    wait for clk_period;
	
	INSTRUCTION <= "0110" & "0000" & "0001" & "0000";  -- Mov
    wait for clk_period; 
	
	INSTRUCTION <= "0111" & "0000" & "0001" & "0000";  -- NOP
    wait for clk_period;

    ----------------------------------------------------------------
    -- Part 2: Shifter Tests (same base operand)
    ----------------------------------------------------------------

    INSTRUCTION <= "1000" & "0000" & "0001" & "0010";
    wait for clk_period;

    INSTRUCTION <= "1001" & "0000" & "0001" & "0010";
    wait for clk_period; 
	
	
    INSTRUCTION <= "1010" & "0000" & "0001" & "0010";
    wait for clk_period;

    ----------------------------------------------------------------
    -- Part 3: LUT Test (same operand)
    ----------------------------------------------------------------

    INSTRUCTION <= "1011" & "0000" & "0001" & "0010";
    wait for clk_period;

    ----------------------------------------------------------------
    wait for clk_period * 2;
    wait;

end process;
end architecture;