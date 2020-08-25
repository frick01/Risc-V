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

		 
       library IEEE;
		 use IEEE.std_logic_1164.all;
		 use IEEE.NUMERIC_STD.ALL;
		 use IEEE.std_logic_unsigned.all;
		
		entity ImmGenerator is port
		(
		
	   Instr             :   in  std_logic_vector(31 downto 0);
		IGenerator_out    :   out std_logic_vector(31 downto 0)
		
		);
		
		end ImmGenerator;
		
		architecture hardware of ImmGenerator is		
		signal Instruction        : signed (31 downto 0); 
		
	  
		--signal OPcode          : std_logic_vector (6  downto 0);
		
      begin
		
		Instruction <= signed(Instr);
	   GeneratorImed: process(Instruction)
		begin
		
	   
		case Instruction(6 downto 0) is 
		when "0010011" => -- I-tye 
		Igenerator_out <= std_logic_vector(resize(Instruction(31 downto 20),Igenerator_out'length));
		when "0000011" => -- I-tye 
		Igenerator_out <= std_logic_vector(resize(Instruction(31 downto 20),Igenerator_out'length));
		
		when "0100011"=> -- S-type  
		Igenerator_out <= std_logic_vector(resize((Instruction(31 downto 25)&Instruction(11 downto 7)),Igenerator_out'length));
		when "1100011"=> -- SB-type
		Igenerator_out <= std_logic_vector(resize(Instruction(31)&Instruction(7)&Instruction(30 downto 25)&
		Instruction(11 downto 8), Igenerator_out'length)); 
		
   	when "1101111"=> --Jal-type
	   Igenerator_out <= std_logic_vector(resize(Instruction(31)&Instruction(19 downto 12)&Instruction(20)&
	   Instruction(30 downto 25)& Instruction(24 downto 21)&'0', Igenerator_out'length)); 
	
		when "1100111" => -- JalR
		Igenerator_out <= std_logic_vector(resize(Instruction(31 downto 20),Igenerator_out'length));
		when others => Igenerator_out <=(others=>'0');
		end case;
		
		end process GeneratorImed; 
		
		end hardware;
		
		
		

		-- when "1101111"=> --Jal-type
	--  Igenerator_out <= std_logic_vector(resize(Instruction(31)&Instruction(30 downto 21)&Instruction(20)&
	--  Instruction(19 downto 12), Igenerator_out'length)); 
		
		
		
		
		
		