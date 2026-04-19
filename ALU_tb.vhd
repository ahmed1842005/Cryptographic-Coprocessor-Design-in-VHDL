library ieee;	
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 


entity tb_ALU is


end tb_ALU;


architecture behavior of tb_ALU is 

 signal flag_A: std_logic_vector(15 downto 0):= (others => '0' );
signal flag_B: std_logic_vector(15 downto 0):= (others => '0' );	
signal flag_CTRL: std_logic_vector(2 downto 0):= (others => '0' );
signal flag_OUTPUT: std_logic_vector(15 downto 0):= (others => '0' );

begin 
	U:entity ALU	
		port map( 	input_A =>  flag_A ,
		            input_B => flag_B ,
		            input_CTRL =>  flag_CTRL ,
					OUTPUT=> flag_OUTPUT
					  		    
	
		);	 
		sim_proc: process
		
begin
			flag_A<= x"0014";
			flag_B<= x"000A" ;
			wait for 20 ns;	
			
			flag_CTRL<= "001" ;	   -- add
			wait for 20 ns;	
			
			flag_CTRL<= "010" ;		 -- sub
			wait for 20 ns;
			
			flag_CTRL<= "011" ;		  -- and
			wait for 20 ns;	
			
			flag_CTRL<= "100" ;		  --or 
			wait for 20 ns;
			
			flag_CTRL<= "101" ;				 -- xor
			wait for 20 ns;
			
			flag_CTRL<= "110" ;				   -- not a  
			wait for 20 ns;	  
			
			wait ;
		end process ;
		 end behavior ;
