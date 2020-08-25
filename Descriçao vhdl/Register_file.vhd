--
-- SÍNTESE DO BANCO DE REGISTRADOR
--

--
--
-- Author: Eng. Guilherme Frick
-- DATA: 06/05/2019


	library ieee;
	use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
	use ieee.std_logic_unsigned.all;

entity Register_file is
  port(
    R_data1       : out std_logic_vector(31 downto 0);
    R_data2       : out std_logic_vector(31 downto 0);
    R_register1   : in  std_logic_vector(4  downto 0);
	 R_register2   : in  std_logic_vector(4  downto 0);
	 W_register    : in  std_logic_vector(4  downto 0);
    W_data        : in  std_logic_vector(31 downto 0);
	 W_enable      : in  std_logic;
    I_clk         : in  std_logic
	
    );
end Register_file;


  architecture hardware of Register_file is
  type registerFile is array(0 to 31) of std_logic_vector(31 downto 0);
  signal registers : registerFile :=(others => (others => '0'));
  begin
  

  regFile : process (I_clk,W_register, W_enable,W_data,registers,R_Register1,R_Register2) is
 
  begin
  

  if I_clk 'event and I_clk ='1'then
    
	 
	   if W_register /= "00000" and W_enable = '1' then
			
		 registers(conv_integer(W_register)) <= W_data;  -- Write data 
	   else 
	   registers(conv_integer(W_register))<="00000000000000000000000000000000"; 
    end if;
	 end if;

   end process regFile;

	 R_data1<=registers(conv_integer(R_Register1));
	 R_data2<=registers(conv_integer(R_Register2));
	
 
-- R_data1<= "00000000000000000000000000000000" when R_Register1 = "00000" else registers(conv_integer(R_Register1));
 --R_data2<= "00000000000000000000000000000000" when R_Register2 = "00000" else registers(conv_integer(R_Register2));
	 
-- R_data1<=registers(conv_integer(R_Register1))  when R_Register1 /= "00000" else (others => '0');
-- R_data2<=registers(conv_integer(R_Register2))  when R_Register2 /= "00000" else (others => '0');
end hardware;