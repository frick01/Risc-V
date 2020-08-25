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
	use IEEE.STD_LOGIC_ARITH.ALL;
    
	entity Mult16x16 is port 
	(
	 multiplying: in  std_logic_vector(15 downto 0);
    multiplier : in  std_logic_vector(15 downto 0);
	 product    : out std_logic_vector(31 downto 0)
	 );
	 end entity;
	 
	 architecture hardware_mult of Mult16x16 is
	 begin
	Multipication : process (multiplying, multiplier) is
	variable sum   : std_logic_vector(31 downto 0);
	variable shift : std_logic_vector(31 downto 0);
	
	begin
		sum := (others => '0');
		for j in 0 to 15 loop
		if multiplying(j) = '1' then
		shift(j downto 0) :=(others => '0');
		shift(j+15 downto j) := multiplier;
		shift(31 downto j+16):= (others => '0');
		sum := sum + shift;
		end if;
		product <=sum;
	   end loop;
		end process Multipication;
	end hardware_mult;
	 
	 
	
	 
	 