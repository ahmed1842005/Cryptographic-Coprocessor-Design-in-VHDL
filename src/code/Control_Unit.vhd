library ieee;
use ieee.std_logic_1164.all;

entity Control_Unit is
    port(
		instruction:in std_logic_vector(15 downto 0);
	
        MUX_EN: out std_logic;

        ALU_CTRL : out std_logic_vector(2 downto 0);
        SH_CTRL : out std_logic_vector(1 downto 0);

        MUX_Sel: out std_logic_vector(1 downto 0)
    );
end entity;

architecture Behavioral of Control_Unit is 
begin	 
	
        process(instruction)
        begin   
            
            MUX_EN   <= '0';
            ALU_CTRL <= "000";
            SH_CTRL  <= "00";
            MUX_Sel  <= "00"; 
            
            
            if instruction(15)='0' then 
                MUX_EN <= '1';
                MUX_Sel <= "00"; 
                
                case instruction(15 downto 12) is
                when "0000" => ALU_CTRL <= "001"; -- ADD
                when "0001" => ALU_CTRL <= "010"; -- SUB
                when "0010" => ALU_CTRL <= "011"; -- AND
                when "0011" => ALU_CTRL <= "100"; -- OR
                when "0100" => ALU_CTRL <= "101"; -- XOR
                when "0101" => ALU_CTRL <= "110"; -- NOT
                when "0110" => ALU_CTRL <= "111"; -- MOV
                when others => ALU_CTRL <= "000"; -- NOP
            end case;
                            
           
           elsif instruction(15 downto 12)="1000" then 
               ALU_CTRL<="000";
               MUX_EN<='1';
               MUX_Sel <= "01"; 
               SH_CTRL<="01"; 
               
           elsif instruction(15 downto 12)="1001" then 
               ALU_CTRL<="000";
               MUX_EN<='1';
               MUX_Sel <= "01"; 
               SH_CTRL<="10";  
               
           elsif instruction(15 downto 12)="1010" then 
               ALU_CTRL<="000";
               MUX_EN<='1';
               MUX_Sel <= "01"; 
               SH_CTRL<="11";  
           
           
           elsif instruction(15 downto 12)="1011" then 
               ALU_CTRL<="000";
               MUX_EN<='1';
               MUX_Sel <= "10"; 
               SH_CTRL<="00";  
               
           else 
               MUX_EN<='0';    
           
           end if;             

    end process;

end architecture;