library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shifter is 
	port(
		input   : in  std_logic_vector(15 downto 0);
		input_CTRL : in  std_logic_vector(3 downto 0);
		output  : out std_logic_vector(15 downto 0) 
	);										    
end entity;

architecture behavioral of Shifter is
begin
	
	process(input , input_CTRL)
	begin
		case input_CTRL is
			
			when "1000" =>                       -- Rotate_Right_8
				output <= std_logic_vector(
					rotate_right(unsigned(input), 8)
				);

			when "1001" =>                       -- Rotate_Right_4
				output <= std_logic_vector(
					rotate_right(unsigned(input), 4)
				);

			when "1010" =>                       -- Shift_left_8
				output <= std_logic_vector(
					shift_left(unsigned(input), 8)
				);

			when others =>
				output <= (others => '0');
				
		end case;
	end process;

end architecture;