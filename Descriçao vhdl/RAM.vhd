--
-- SÍNTESE DE MEMÓRIA RAM
--
-- A memória ROM possui 8 linhas de endereços (8bits);
-- e 32 linhas de dados (32bit cada instrução);
-- Capacidade de 1kByte
--
--
-- Author: Eng. Guilherme Frick
-- DATA: 06/05/2019


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
	
  entity RAM is

 
  
    Port ( 
	 
	        I_clk          : in  std_logic;
           switch	        : in  std_logic_vector (9  downto 0);
			  I_MemWrite     : in  STD_LOGIC;
			  address        : in  std_logic_vector(7  downto 0);
			  Write_data_rs2 : in  std_logic_vector(31 downto 0);
			  read_data      : out std_logic_vector(31 downto 0);
			  leds           : out  std_logic_vector(9 downto 0);
			  flush          : in std_logic;
			  bypas_data     : out std_logic;
			  I_lbyte        : in bit;
			  display_0      : out std_logic_vector(3 downto 0);
			  display_1      : out std_logic_vector(3 downto 0);
			  display_2      : out std_logic_vector(3 downto 0);
			  display_3      : out std_logic_vector(3 downto 0);
			  display_4      : out std_logic_vector(3 downto 0);
			  display_5      : out std_logic_vector(3 downto 0);
			  display_6      : out std_logic_vector(3 downto 0)
			 );
  end RAM;
  
  
  architecture hardware of RAM is
  type array_memory is array( 0 to 300 ) of std_logic_vector(7 downto 0);
  signal memory: array_memory:=(others => (others => '0'));
  signal read_addres: std_logic_vector(7 downto 0);
  begin
  read_addres<=address;
  
  Process_Write : process(I_clk)
  begin

  
if (I_clk 'event and I_clk ='1')then

   -- dec_display <=(others => '0');     

			 if (I_MemWrite = '1' and I_Lbyte = '0') then --store word
			
			if (address>"00000100")then
			 
			    memory(conv_integer(address))  <=Write_data_rs2(7  downto  0);
				 memory(conv_integer(address)+1)<=Write_data_rs2(15 downto  8);
				 memory(conv_integer(address)+2)<=Write_data_rs2(23 downto 16);
				 memory(conv_integer(address)+3)<=Write_data_rs2(31 downto 24);
		    elsif(address = "00000000")then
			   leds <= Write_data_rs2(9 downto 0); --chave manda valor para leds
			 elsif(address = "00000001")then
			   display_0<= write_data_rs2(3 downto 0);
				display_1<= write_data_rs2(7 downto 4);
				
			  elsif(address = "00000010")then
			   
				display_2<= write_data_rs2(3 downto 0);
				display_3<= write_data_rs2 (7 downto 4);
				
				elsif (address = "00000011")then
				
				display_4<= write_data_rs2(3 downto 0);
				display_5<= write_data_rs2(7 downto 4);
				
			 end if;
			 
			 elsif (I_MemWrite = '1' and I_Lbyte = '1')then
			 
			 if (address>"00000100")then
			 memory(conv_integer(address))  <=Write_data_rs2(7  downto  0);
			 elsif (address = "00000000")then
			 leds(7 downto 0) <= Write_data_rs2(7 downto 0); 
			  elsif(address = "00000001")then
			   display_0<= write_data_rs2(3 downto 0);
				display_1<= write_data_rs2(7 downto 4);
				
			  elsif(address = "00000010")then
			   
				display_2<= write_data_rs2(3 downto 0);
				display_3<= write_data_rs2 (7 downto 4);
				
				elsif (address = "00000011")then
				
				display_4<= write_data_rs2(3 downto 0);
				display_5<= write_data_rs2(7 downto 4);
			 
			end if;
				 
			end if;
			--read_addres<=address;
			end if;
	  
		  
  
		
		
		
	  end process	Process_Write;
	   
	--  if (I_Lbyte  '0')then
	
	
--	 bypas_data <= '1' when (read_addres) <8 and read_addres > 3 and I_MemWrite = '0' else
--		               '0' when (read_addres) /= ("00000100") else
--							'0';
		 
	read_data<=	("0000000000000000000000"&switch) when (read_addres) <8 and read_addres > 3 and I_MemWrite = '0'else

  
 
		    (memory(conv_integer(read_addres)+3)& memory(conv_integer(read_addres)+2)& 
			  memory(conv_integer(read_addres)+1)& memory(conv_integer(read_addres)));-- when(I_Lbyte) = '0' else
          
		---	("000000000000000000000000"&memory(conv_integer(read_addres)))when (I_Lbyte)='1';-- else
			 
			-- ""
		--	 x"00000000";
		--  elsif(I_Lbyte = '1') then
			-- read_data <= 
				
		--	 memory(conv_integer(read_addres));
			
		--	end if;
			
end hardware;
	
		
 







