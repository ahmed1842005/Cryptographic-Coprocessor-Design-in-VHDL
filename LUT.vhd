library ieee ;
use ieee.std_logic_1164.all ;

entity LUT is
	port( 	   
	
	-- define input and outputs	   
	
	input : in std_logic_vector (7 downto 0);
	output : out std_logic_vector (7 downto 0) 
	
	);
end entity ;

architecture Behavioral of LUT is  

	-- define signals s1 , s2 to be flag	

	Signal S_Box1 , S_Box2 : std_logic_vector (3 downto 0);
begin
	
	-- give value to s1	(high bits)
		with input(7 downto 4) select 
	    S_Box1 <=   "0001" when "0000",
	                "1011" when "0001",
	                "1001" when "0010",
	                "1100" when "0011",
	                "1101" when "0100",
	                "0110" when "0101",
	                "1111" when "0110",
	                "0011" when "0111",
	                "1110" when "1000",
	                "1000" when "1001",
	                "0111" when "1010",
	                "0100" when "1011",
	                "1010" when "1100",
	                "0010" when "1101",
	                "0101" when "1110",
	                "0000" when "1111",
					"0000" when others;	 
					
		-- give value to s2	(low bits)	
		with input(3 downto 0) select 
	    S_Box2 <=   "0001" when "0000",
	                "1011" when "0001",
	                "1001" when "0010",
	                "1100" when "0011",
	                "1101" when "0100",
	                "0110" when "0101",
	                "1111" when "0110",
	                "0011" when "0111",
	                "1110" when "1000",
	                "1000" when "1001",
	                "0111" when "1010",
	                "0100" when "1011",
	                "1010" when "1100",
	                "0010" when "1101",
	                "0101" when "1110",
	                "0000" when "1111" ,
					"0000" when others;   
		
		-- concate between s1 , s2 to find output
		output <= S_Box1 & S_Box2 ;

end architecture ;