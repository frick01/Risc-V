--
-- SÍNTESE DE MEMÓRIA ROM
--
-- A memória ROM possui 8 linhas de endereços (8bits);
-- e 32 linhas de dados (32bit cada instrução);
-- Capacidade de 1kByte
--
--
-- Author: Eng. Guilherme Frick
-- DATA: 06/05/2019


	library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	use ieee.std_logic_unsigned.all;
   
	
	entity ROM is port
	(
	addressPC  :  in  std_logic_vector (31 downto 0 ); -- 32 bits de endereçamento ->PC = ADDRSS
	I_clk      :  in  std_logic;              -- clock para pegar uma insrução 
	--
	instructO1:  out std_logic_vector (31 downto 0 ); -- saída de dados de memória 
	instructO2:  out std_logic_vector (31 downto 0 ); -- saída de dados de memória 
	opcode    :  out std_logic_vector (6  downto 0 ); -- Saida do opcode
	rs1       :  out std_logic_vector (4  downto 0 ); -- Saída para o registro 1
	rs2       :  out std_logic_vector (4  downto 0 ); -- Saída para o registro 2
	rd        :  out std_logic_vector (4  downto 0 ) -- Saída para o registro de destino
	);
	end ROM;
	
	architecture hardware of ROM is 
	signal   out_inst: std_logic_vector(31 downto 0);
   type     array_memory is array (natural range <>) of std_logic_vector (7 downto 0);
	
	constant data : array_memory(0 to 256):=
   (
"00000000","01000000","00100101","00000011",
"00000000","01000000","00100101","10000011",
"00000000","01000000","00100110","00000011",
"00000010","10110101","10000110","10110011",
"00000000","11010000","00100101","10100011",
"00000000","01000000","00000111","00010011",
"00000010","10100111","00000111","10110011",
"00000010","11000111","10001000","00110011",
"00000000","10110000","00101000","10000011",
"01000001","00000110","10001001","00110011",
"00000000","00101001","00011001","10010011",
	
	
"00000001","00000001","00000001","00010011",
"00000001","00100001","00100010","00100011",
"00000000","10000001","00100100","00100011",
"00000000","00010001","00100110","00100011",
"00000000","00000000","00000100","10010011",
"00000010","10000101","00000100","01100011",
"00000000","00000101","00000100","00010011",
"00000000","00000100","00100101","00000011",
"00000000","00000100","00100101","00000011",
"00000001","10000000","00000101","01101111",
"00000000","10000100","00100111","10000011",
"00000000","01000100","00100100","00000011",
"00000000","10010101","00000100","10110011",
"00000000","11110100","10000100","10110011",
"11111110","00000100","00010010","11100011",
"11111110","00100101","01000100","11100011",
"00000000","00000100","10000101","00010011",
"00000000","01000001","00100100","10000011",
"00000000","10000001","00100100","00000011",
"00000000","11000001","00100000","10000011",
"00000001","00000001","00000001","00010011",
"11111011","00011111","11110000","01101111",


	 others =>(others => '0')
	 ); -- posições restantes
		
	begin 
	
	fetch: process (addressPC)
	begin
	--if rising_edge(I_clk) then 
	out_inst <= (data(conv_integer(addressPC))& data(conv_integer(addressPC+1))& data(conv_integer(addressPC+2))&
	             data(conv_integer(addressPC +3)));  
  -- end if;
	end process fetch;
	
	
	decoder_instruction: process(out_inst)
	begin
	--if rising_edge(I_clk)then
	instructO1<= out_inst(31 downto  0);
	instructO2<=out_inst(31 downto  0);
	opcode  <= out_inst(6  downto  0);
	rd      <= out_inst(11 downto  7);
	rs1     <= out_inst(19 downto 15);
	rs2     <= out_inst(24 downto 20);
--   end if;
	end process decoder_instruction;
	
	
   end hardware ;
	
	