library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
    port (
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
end entity register_file;

architecture behavioral of register_file is

    type regArrayT is array (0 to 15) of std_logic_vector(15 downto 0);
    signal regFile : regArrayT := (others => (others => '0'));

begin

   
    writeProc : process(inputCLK, inputRES)
    begin
        if inputRES = '1' then
            regFile <= (others => (others => '0'));

        elsif rising_edge(inputCLK) then
            if inputWEN = '1' then
                regFile(to_integer(unsigned(inputRd))) <= inputDIN;
            end if;
        end if;
    end process writeProc;


    outputABUS <= regFile(to_integer(unsigned(inputRa)));
    outputBBUS <= regFile(to_integer(unsigned(inputRb)));

end architecture behavioral;