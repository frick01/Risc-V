----------------------------------------------------------------------------------------------------------------------
-- Instituition:      Federal University of Santa Catarina, Graduate Program in Eletrical Engineering
-- Course      :      EEl 510389
-- Course name :      Digital Systems and Reconfigurable Devices
-- Professor   :      Phd. Edurdo Augusto Bezerra
-- Student     :      Guilherme Frick de Oliveira
-- Create data :      28/05/2019 
-- DesignName  :      32 bit ALU
-- Project Name:      ALU
-- Entity Name :      ALU
-- Target Device:     CicloneIV E: EP4CE622
-- Revision 0.01: -   File Create
--------------------------------------------------------------------------------------------------------------------------
----------ALUCONTROL INPUT----------------------------------CONTROLS------PORT LIST-------------------------------------------------
----S(3)   S(2)   S(1)   S(0) | RESULT | OPERATION | FLAG        |      |  OP1 =>  Entrada 1 da Alu Conectado ao Red data1 do Reg FILe
----  0      0      0      0  | A + B  |  Addition | Overflow    |      |  R_data2 Entrada 1 do multiplexador_ALUin    
----  0      0      0      1  | A - B  |  Subtract | if A<B,zero,|      |  Imm     Entrada 2 do multiplexador_ALUin   
----  0      0      1      0  | A & B  |  And      |                    |  OP2 => Saída do multiplexador_ALUin conectada na Entrada 2 da Alu    
----  0      0      1      1  | A | B  |  OR       |                    |  result => saída da ALU       
----  0      1      0      0  | AxorB  |  XOR      |                    |  less_than => flag  
----  0      1      0      1  | SLL A  |  Shift_R  |                    |  zero => flag
----  0      1      1      0  | SRL B  |  Shift_L  |                    |  Alu control => Entrada dos dados vindos da Alu control
----  0      1      1      1  | A mul B|  mult                                     |  Mux_ALU_in => select do multiplexador_ALUin
----  1      0      0      0  | A slt B|

--
		 library IEEE;
		 use IEEE.std_logic_1164.all;
		 use IEEE.NUMERIC_STD.ALL;
		 use IEEE.std_logic_unsigned.all;
		 
		 entity ALU is port
		 (
		 ----PortsAlu-------------------------------------
		 OP1             :in  std_logic_vector(31 downto 0);   
		 result          :out std_logic_vector(31 downto 0);
		 Alu_Control     :in  std_logic_vector(3 downto 0 );
		 less_than_zero  :out std_logic_vector(1 downto 0);
		 I_clk           :in std_logic;
		 Select_Mux_out_ALu: out bit;
		 OP2             :in  std_logic_vector(31 downto 0)  
		 
		 );
		 end ALU; 
		 
		 
	  architecture hardware of ALU is 
		 --signal declarations
	--	 signal OP2                  : std_logic_vector(31 downto 0); --Segundo operando da al
		 
	    begin 
		 

		 OP_decoder: process (OP1,OP2,Alu_Control)
		 begin
		 result <=(others => '0');
		 less_than_zero <=(others => '0');
		 
		-- if rising_edge(I_clk)then
		     Select_Mux_out_ALu<='0';
		     -- if rising_edge(I_clk)then
				case Alu_Control is
				when "0000"  => result <= OP1  +   OP2;
				when "0001"  => result <= OP1  -   OP2;
				when "0010"  => result <= OP1 AND  OP2;
				when "0011"  => result <= OP1 OR   OP2;
				when "0100"  =>result  <= OP1 XOR  OP2;
				when "0101"  =>result  <= std_logic_vector(unsigned(OP1)sll conv_integer(OP2));
			   when "0110"	 =>result  <= std_logic_vector(unsigned(OP1)srl conv_integer(OP2));-- a desloca e x vezes B		
				when "0111"  =>Select_Mux_out_ALu <= '1';
				when "1000"  => if (OP1<OP2)then result <= "00000000000000000000000000000001"; 
				                    else result <= (others => '0'); end if; -- slt
				when "1001"  => 
				if (OP1 = OP2)then less_than_zero <="01";--beq
				end if;
				when "1010"  => 
				if (OP1/=OP2)then less_than_zero <="11";--bnq
				end if;
				when"1011" => 
				if(OP1<OP2) then less_than_zero<="10";-- blt
				end if;
			   when"1100" => 
				if((OP1=OP2)or(OP1= OP2)) then less_than_zero<="11";-- blt
				end if;
				
				
				
				--if (OP1<OP2)then less_than_zero <="10";
				--	else if(OP1=OP2)then less_than_zero<="01";
				--		else less_than_zero<="00";
						--"1010" 
						--"1011" 
						--"1100"
				--	end if;
				
					
				--end if;
				when others  =>result  <= (others => '0');
			                             
			end case;
		
		
		--end if;
		end process op_decoder;
		
		
--		Comparations : process(OP1,OP2,Alu_Control)
	--		begin
		--	if rising_edge(I_clk)then
	--		if (Alu_Control = "0011")then
	--		sub_test <= std_logic_vector(unsigned(OP1) - unsigned(OP2));
	--		if (sub_test(31)='1')then
		--	less_than <= '1'; zero <='0';
		--	elsif  sub_test = "00000000000000000000000000000000" then
	--		less_than <= '0'; zero <='1';
		--	end if;
		--	end if;
		--	end if;
	  --  end process Comparations;

		 
	end hardware;