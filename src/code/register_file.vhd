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
    
  
    signal regFile : regArrayT := (
      	  0 => x"0001", 
		  1 => x"c505",
		  2 => x"3c07",
		  3 => x"4d05",
		  4 => x"1186",
		  5 => x"f407",
		  6 => x"1086",
		  7 => x"4706",
		  8 => x"6808",
		  9 => x"baa0",
		  10 => x"c902",
		  11 => x"100b",
		  12 => x"c000",
		  13 => x"c902",
		  14 => x"100b",
		  15 => x"B000",
		  others => (others => '0') 
    );
    

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