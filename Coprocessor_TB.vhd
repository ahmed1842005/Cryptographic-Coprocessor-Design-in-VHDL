library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Coprocessor_TB is
end entity;

architecture sim of Coprocessor_TB is

    -- Signals
    signal CLK : std_logic := '0';
    signal RES : std_logic := '0';

    signal INSTRUCTION : std_logic_vector(15 downto 0);

    signal RESULT_OUT : std_logic_vector(15 downto 0);

begin

    DUT: entity work.Coprocessor
        port map(
            CLK         => CLK,
            RES         => RES,
            INSTRUCTION => INSTRUCTION,
            RESULT_OUT  => RESULT_OUT
        );

    --  Clock Generation (10 ns)
   
    CLK_process : process
    begin
        while true loop
            CLK <= '0';
            wait for 5 ns;
            CLK <= '1';
            wait for 5 ns;
        end loop;
    end process;

	-- sim
    stim_proc : process
    begin

        
       

        ----------------------------------------------------------------
        -- ?? Test 1: ADD  (R1 = R2 + R3)
        -- Opcode = 0000
        ----------------------------------------------------------------
        INSTRUCTION <= "0000" & "1111" & "0001" & "0010";
       

       

     
        wait;

    end process;

end architecture;