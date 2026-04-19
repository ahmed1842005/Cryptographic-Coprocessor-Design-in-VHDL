library ieee;	
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  

entity ALU is 
	port (
	
	input_A:in std_logic_vector(15 downto 0);
	input_B:in std_logic_vector(15 downto 0);
	input_CTRL:in std_logic_vector(2 downto 0);
	OUTPUT :OUT std_logic_vector(15 downto 0)
	
	); 
end ALU;
architecture Structural of ALU is
 
begin  
	with input_CTRL select 
	OUTPUT <=  input_A +input_B when "001",
			input_A - input_B   when "010",
			input_A AND input_B when "011",
			input_A OR input_B  when "100",
			input_A XOR input_B when "101",
			NOT (input_A)       when "110", 
			input_a             when "111", 
			(others => '0')     when "000", 
			(others => '0')     when others; 
			
			end Structural;