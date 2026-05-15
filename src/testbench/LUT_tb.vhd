library ieee;

use ieee.std_logic_1164.all;

use ieee.numeric_std.all;



entity LUT_tb is

end entity;
		


architecture behavior of LUT_tb is

	-- get lut to test
	component LUT
       
	port(
 input  : in  std_logic_vector(7 downto 0);
	
      output : out std_logic_vector(7 downto 0)
  );
   
	end component;	  
	
	-- define signals to test
	signal inputTb  : std_logic_vector(7 downto 0) := (others => '0');
    
	signal outputTb : std_logic_vector(7 downto 0);  
	
	begin
		
		G: LUT
 
		port map(
 input  => inputTb,
  output => outputTb
 );
		
		-- process to semulation
		
		 process
   
		begin
        
       
			-- to test all values       
				for i in 0 to 255 loop
          
					inputTb <= std_logic_vector(to_unsigned(i, 8));
 
					wait for 10 ns;
  
				end loop;

        
			     
			wait;
    
			end process;
		
	end architecture ;