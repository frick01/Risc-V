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

	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	
	entity Mux_Mem_to_reg is 
	port 
	(
	 input_alu     : in  std_logic_vector (31 downto 0);
	 input_Memory  : in  std_logic_vector (31 downto 0);
	 input_PC4     : in  std_logic_vector (31 downto 0);
	 out_to_reg    : out std_logic_vector (31 downto 0);
	 sel_M         : in  std_logic_vector (1  downto 0);
 --   switch	      : in  std_logic_vector (9  downto 0);
	 bypass_memory : in  std_logic
	);
	 
	 end entity;
	 
	 architecture hardware_mux of Mux_Mem_to_reg is
	 signal   mux: std_logic_vector(2 downto 0);
	 begin
		
	 
	
	
	with sel_M select

	 
	 out_to_reg <= input_alu      when "00",
					   input_Memory   when "01",
						input_PC4      when "10",
--("0000000000000000000000"&switch)when "011",
						"00000000000000000000000000000000" when others;
						

	end hardware_mux;
	 
	 
	 
	 
	 