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
--------------------------------------------------------------------------------------------------------------------------

	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use IEEE.numeric_std.all;

	entity Unit_control is port
	(
	opcode_control   : in  std_logic_vector(6 downto 0);
	I_clk            : in  std_logic;
	ALUOp            : out std_logic_vector(1 downto 0);
	Mux_Alu_in       : out bit;
	jump_ctl         : out bit;
	Mux_write_data   : out std_logic;
	Mem_Write        : out std_logic;
	MUX_MEM_OUT      : out std_logic_vector(1 downto 0);
	Branch           : out std_logic;
	WReg             : out std_logic;
	Debug_info       : out std_logic_vector(31 downto 0)
	
	 );
	end Unit_control;
	 
	architecture hardware_control of Unit_control is
	begin
	
	

	
	Decoder_opcode  : process (opcode_control)
	
	begin
   
	 case opcode_control is 
		when "0110011" =>         --51
		                        -- R-Type 
		ALUOp        <= "10";   -- add,sub,or,and
		Mux_Alu_in    <='0';    -- sll,srl,slt,mult
		WReg          <='1';    -- xor
		Branch        <='0';
		MUX_MEM_OUT   <="00";
		Mem_Write     <='0';
		jump_ctl      <='0';
		
	   when"0010011" =>        --19
		ALUOp         <= "10";  --I-type
		Mux_Alu_in    <='1';    --addi, andi,ori,slli 
		WReg          <='1';
		Branch        <='0';
		MUX_MEM_OUT   <="00";
		Mem_Write     <='0';
		jump_ctl      <='0';
		
		when"0000011"=>       --3
	  	ALUOp         <= "00";  --I-type
		Mux_Alu_in    <='1';    --Lw,Lb
		WReg          <='1';
		Branch        <='0';
		MUX_MEM_OUT   <="01";
		Mem_Write     <='0';
		jump_ctl      <='0';
		
		when "0100011"=> --S-type --35
		
		ALUOp      <= "00";
		Mux_Alu_in    <='1';   --Sw,Sb
		WReg          <='0';
		Branch        <='0';
		MUX_MEM_OUT   <="00";
		Mem_Write     <='1';
		jump_ctl      <='0';
		
		when "1100011"=>
		ALUOp        <= "01";     --BEQ,BNE,BLT,BGE  99
		Mux_Alu_in    <='0';   
		WReg          <='0';
		Branch        <='1';
		MUX_MEM_OUT   <="00";
		Mem_Write     <='0';
		jump_ctl      <='0';
				
		when "1101111"=>         --111
		ALUOp        <= "00";     --JAL
		Mux_Alu_in    <='0';   
		WReg          <='1';
		Branch        <='0';
		MUX_MEM_OUT   <="10";
		Mem_Write     <='0';
		jump_ctl      <='1';
		
		
				when "1100111"=>
		ALUOp        <= "00";     --JALR
		Mux_Alu_in    <='0';   
		WReg          <='0';
		Branch        <='0';
		MUX_MEM_OUT   <="00";
		Mem_Write     <='0';
		jump_ctl      <='1';
		
		
		when others => 
		ALUOp      <= "00";
		Mux_Alu_in    <='0';   --alu source
		WReg          <='0';
		Branch        <='0';
		MUX_MEM_OUT   <="00";
		Mem_Write     <='0';
		jump_ctl      <='0';
		end case;
	  
		end process Decoder_opcode ;
		
	
		

		end hardware_control;
		
		
	 