----------------------------------------------------------------------------------------------------------------------
-- Instituition:      Federal University of Santa Catarina, Graduate Program in Eletrical Engineering
-- Course      :      EEl 510389
-- Course name :      Digital Systems and Reconfigurable Devices
-- Professor   :      Phd. Edurdo Augusto Bezerra
-- Student     :      Guilherme Frick de Oliveira
-- Create data :      28/05/2019 
-- DesignName  :      ALUControl RV32I
-- Project Name:      ALUControl
-- Entity Name :      ALUControl
-- Target Device:     CicloneIV E: EP4CE622
-- Revision 0.01: -   File Create
--------------------------------------------------------------------------------------------------------------------------
----------ALUCONTROL INPUT----------------------------------CONTROLS------PORT LIST-------------------------------------------------
----S(30)   S(14)   S(13) S(12| OPERAT | OPERATION | FLAG        |      |  
----  0      0      0      0  | ADD    |  Addition | Overflow    |      |    
----  1      0      0      1  | SUB    |  Subtract | if A<B,zero,|      |     
----  0      1      1      1  | A & B  |  And      |                    |  
----  0      1      1      0  | A | B  |  OR       |                    |       
----  0      1      0      0  | AxorB  |  XOR      |                    |   
----  0      0      0      1  | SLL A  |  Shift_R  |                    |  
----  0      1      0      1  | SRL B  |  Shift_L  |                    |  
 


		 
		 
		 library IEEE;
		 use IEEE.std_logic_1164.all;
		 use IEEE.NUMERIC_STD.ALL;
		 use IEEE.std_logic_unsigned.all;
		 
		 entity ALUControl is port
		 (
		 Instruction_Ac: in  std_logic_vector(31 downto 0);
		 ALU_OP        : in  std_logic_vector(1  downto 0);
		 Out_Control   : out std_logic_vector(3  downto 0);
		 lbyte         : out bit
		 );
		 end ALUControl;
	    
		 architecture hardware of ALUControl is 
		 
		 -- singals declararions

		 signal decoder1:std_logic_vector(4 downto 0);

		 begin
		 
		
		
		--if I_clk 'event and I_clk ='1'then
		
		
	  Dec1: process(Instruction_Ac) 
	  begin
		 
		 
	 decoder1 <= ((Instruction_Ac(25)&Instruction_Ac(30)&Instruction_Ac(14)&Instruction_Ac(13)&Instruction_Ac(12)));
		 
	 end process Dec1;
		 
		
   	Dec2:process (ALU_OP,decoder1)
		 begin
		 lbyte <= '0';
	
		-- decoder1 <= ((Instruction_Ac(26)&Instruction_Ac(30)&Instruction_Ac(14)&Instruction_Ac(13)&Instruction_Ac(12)));
		  Out_Control <=(others => '0');
		 case ALU_OP is
		
		 when "10" => --R-Type
		 
		 case decoder1 is
		 when "00000" => Out_Control <= "0000"; -- add
		 when "01000" => Out_Control <= "0001"; -- sub
		 when "00111" => Out_Control <= "0010"; -- and
		 when "00110" => Out_Control <= "0011"; -- or
		 when "00100" => Out_Control <= "0100"; -- xor
		 when "00001" => Out_Control <= "0101"; -- sll
		 when "00101" => Out_Control <= "0110"; -- slr
		 when "10000" => Out_COntrol <= "0111"; -- mult
		 when "10111" => Out_Control <= "0010"; -- andi
		 when "10110" => Out_Control <= "0011";-- ori
		 when "10100" => Out_Control <= "0100";--xori
		 when "00010" => Out_COntrol <= "1000"; -- slt     
		 
		 when others => Out_COntrol <= "ZZZZ"; 
		 end case;
		  
		 
		 when "00" => --for Ld and Sd
		 if (decoder1(2 downto 0) = "010")then 
		 Out_Control <= "0000";--add 
		 elsif(decoder1(2 downto 0) = "000")then
		 Out_Control <= "0000";--add
		 lbyte <= '1';else lbyte <= '0'; 
		 end if;
		 when"01" => -- for branch
       if (decoder1(2 downto 0)= ("000"))then
		 Out_Control <= "1001"; -- beq -> manda fazer sub e compara zero
		 elsif 
		     decoder1(2 downto 0)= ("001")then
		 Out_Control <= "1010"; -- bne -> manda fazer sub e compara zero
		 elsif 
		     decoder1(2 downto 0)= ("100")then
		 Out_Control <= "1011"; -- blt -> manda fazer sub e compara zero
		 elsif 
		     decoder1(2 downto 0)= ("101")then
		 Out_Control <= "1100"; -- bge -> manda fazer sub e compara zero
		
		end if;
		 
	   when others => Out_Control <="ZZZZ";
	   end case;
	   end process Dec2;
		end hardware; 
		 
		 
		 
	