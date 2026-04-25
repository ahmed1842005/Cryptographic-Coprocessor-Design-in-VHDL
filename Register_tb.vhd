library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_register_file is
end tb_register_file;

architecture behavior of tb_register_file is

    component register_file
        port(
            inputCLK   : in  std_logic;
            inputRES   : in  std_logic;
            inputWEN   : in  std_logic;
            inputRa    : in  std_logic_vector(3 downto 0);
            inputRb    : in  std_logic_vector(3 downto 0);
            inputRd    : in  std_logic_vector(3 downto 0);
            inputDIN   : in  std_logic_vector(15 downto 0);
            outputABUS : out std_logic_vector(15 downto 0);
            outputBBUS : out std_logic_vector(15 downto 0)
        );
    end component;

    signal flagCLK   : std_logic := '0';
    signal flagRES   : std_logic := '0';
    signal flagWEN   : std_logic := '0';
    signal flagRa    : std_logic_vector(3 downto 0)  := (others => '0');
    signal flagRb    : std_logic_vector(3 downto 0)  := (others => '0');
    signal flagRd    : std_logic_vector(3 downto 0)  := (others => '0');
    signal flagDIN   : std_logic_vector(15 downto 0) := (others => '0');
    signal flagABUS  : std_logic_vector(15 downto 0);
    signal flagBBUS  : std_logic_vector(15 downto 0);

begin

    U : register_file
        port map(
            inputCLK   => flagCLK,
            inputRES   => flagRES,
            inputWEN   => flagWEN,
            inputRa    => flagRa,
            inputRb    => flagRb,
            inputRd    => flagRd,
            inputDIN   => flagDIN,
            outputABUS => flagABUS,
            outputBBUS => flagBBUS
        );

    -- clock generator: 10 ns period
    flagCLK <= not flagCLK after 5 ns;

    simProc : process
    begin

        -- reset all registers
        flagRES <= '1';
        wait for 20 ns;
        flagRES <= '0';
        wait for 10 ns;

        -- write 0xAAAA into R1
        flagRd  <= "0001";
        flagDIN <= x"AAAA";
        flagWEN <= '1';
        wait for 10 ns;
        flagWEN <= '0';

        -- read R1 on outputABUS
        flagRa <= "0001";
        wait for 10 ns;

        -- write 0xBBBB into R2
        flagRd  <= "0010";
        flagDIN <= x"BBBB";
        flagWEN <= '1';
        wait for 10 ns;
        flagWEN <= '0';

        -- write 0xCCCC into R3
        flagRd  <= "0011";
        flagDIN <= x"CCCC";
        flagWEN <= '1';
        wait for 10 ns;
        flagWEN <= '0';

        -- dual read: R2 on outputABUS, R3 on outputBBUS at the same time
        flagRa <= "0010";
        flagRb <= "0011";
        wait for 10 ns;

        -- WEN = 0 blocks write (try to overwrite R1, should stay 0xAAAA)
        flagRd  <= "0001";
        flagDIN <= x"DEAD";
        flagWEN <= '0';
        wait for 10 ns;
        flagRa  <= "0001";
        wait for 10 ns;

        -- write to boundary register R0
        flagRd  <= "0000";
        flagDIN <= x"0001";
        flagWEN <= '1';
        wait for 10 ns;
        flagWEN <= '0';

        -- write to boundary register R15
        flagRd  <= "1111";
        flagDIN <= x"FFFF";
        flagWEN <= '1';
        wait for 10 ns;
        flagWEN <= '0';

        -- dual read: R0 on outputABUS, R15 on outputBBUS
        flagRa <= "0000";
        flagRb <= "1111";
        wait for 10 ns;

        -- reset again to clear all written values
        flagRES <= '1';
        wait for 20 ns;
        flagRES <= '0';

        -- confirm R1 is back to 0x0000 after reset
        flagRa <= "0001";
        wait for 10 ns;

        wait;
    end process;

end behavior;
