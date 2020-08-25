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
   use ieee.std_logic_unsigned.all;
	
	entity Mux_ALU_in is port
	(
	 Mux_ALU_in      :in  bit;
	 R_data2         :in  std_logic_vector(31 downto 0); 
    ImmOut          :in  std_logic_vector(31 downto 0);    
	 Out_alu_src     :out std_logic_vector(31 downto 0)
	 );
	 
	 end Mux_ALU_in;
	 
	architecture hardware_alu_source of Mux_ALU_in is 
	
	 begin
		
		
		with Mux_ALU_in select 
	   Out_alu_src <= R_data2   when'0',
	                  ImmOut    when'1';
			
 end hardware_alu_source;
		 
		