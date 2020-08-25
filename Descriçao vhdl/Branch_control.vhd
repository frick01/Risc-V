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
		 
		 
		 entity Branch_control is port
		 (
		-- less        :  in std_logic;
		-- zero        :  in std_logic;
		 less_zero     :in std_logic_vector(1 downto 0);
		 branch_ctl_i:  in std_logic;
		 out_B_ctl   :  out bit
		 );
		 
		 end Branch_control;
		 
		 architecture hardware of Branch_control is
		 
		 begin
		 Branch: process(less_zero,branch_ctl_i)
		 begin
       if ((branch_ctl_i and (less_zero(1)or less_zero(0)))='1') then
		 out_B_ctl <= '1';
		 else out_B_ctl<='0';
		 end if;
		 end process Branch;
		 end hardware;
		 
		 
		