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
	
	entity Mux_ALU_OUT is port
	(
	 
	 Alu1        : in  std_logic_vector(31 downto 0);
	 Alu2        : in  std_logic_vector(31 downto 0);
	 Sel         : in  bit;
	 Out_mux_ALu : out std_logic_vector(31 downto 0)
	 );
	 
	 end Mux_ALU_OUT;
	 
	architecture hardware_mux_alu of Mux_ALU_OUT is 
   
	
	begin
	 
	with Sel select 
	Out_mux_ALu <=Alu1 when'1',
	              Alu2 when'0';
	          
	end hardware_mux_alu;