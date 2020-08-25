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
	
	entity Datapath is port
    (
	 CLOck_50  : in  std_logic;   
	 SW        : in  std_logic_vector(9 downto 0);
	 KEY0      : in  std_logic;
	 KEY1      : in  std_logic;
	 LEDR      : out std_logic_vector(9 downto 0);
    DISPLAYS  : out std_logic_vector(7 downto 0);
    ENABLE    : out std_logic_vector(3 downto 0) ;
	 
	 
	 
	 --Sinais 
	 Tb_Pc : out std_logic_vector(31 downto 0);
	 
	
	 Tb_opcode:out  std_logic_vector(6 downto 0);
	 Tb_rs1   :out  std_logic_vector(4 downto 0);
	 Tb_rs2   :out  std_logic_vector(4 downto 0);
	 Tb_rd    :out  std_logic_vector(4 downto 0);
	 
	 Tb_write_data:out std_logic_vector(31 downto 0);
	 Tb_Read_1: out std_logic_vector(31 downto 0);
	 Tb_Read_2: out std_logic_vector(31 downto 0);
	 
	 Tb_ImmGen: out std_logic_vector(31 downto 0);
	 Tb_Alu_result:out std_logic_vector(31 downto 0);
	  --sinais alu control
	 Tb_AluContol: out std_logic_vector(3 downto 0)
	

	 
    
	);
	end entity;
	

	
  architecture hardware_datapath of Datapath is


  
  
  component Unit_control 
	
	port(
	opcode_control   : in  std_logic_vector(6 downto 0);
	I_clk            : in  std_logic;
	ALUOp            : out std_logic_vector(1 downto 0);
	Mux_Alu_in       : out bit;
   jump_ctl         : out bit;
	Mem_Write        : out std_logic;
	MUX_MEM_OUT      : out std_logic_vector(1 downto 0);
	Branch           : out std_logic;
	WReg             : out std_logic;
	Debug_info       : out std_logic_vector(31 downto 0)
	    );
		 
	end component Unit_control;
------------------------------------------------------------

	component ProcessorCounter
	
	port(
	I_clk             :  in  std_logic;
	I_ImmediateGen    :  in  std_logic_vector(31 downto 0);
	branch_ctl        :  in  bit;
	jump              :  in  bit;
   Pc_out            :  out std_logic_vector(31 downto 0);
	Out_to_reg        :  out std_logic_vector(31 downto 0);
	reset        :  in std_logic
	--debug             :  in  std_logic_vector(31 downto 0)
	    );
	end component ProcessorCounter;
-------------------------------------------------------------



   component ROM 
	
	port(
	
	I_clk       :  in  std_logic;
	addressPC   :  in  std_logic_vector(31  downto 0); -- 8 bits de endereçamento ->PC = ADDRSS
	instructO1  :  out std_logic_vector(31 downto 0);
	instructO2  :  out std_logic_vector (31 downto 0 );
	opcode      :  out std_logic_vector(6  downto 0); 
	rs1         :  out std_logic_vector(4  downto 0 ); -- Saída para o registro 1
	rs2         :  out std_logic_vector(4  downto 0 ); -- Saída para o registro 2
	rd          :  out std_logic_vector(4  downto 0 ) -- Saída para o registro de destino 
       ); 
	end component ROM;
----------------------------------------------------------------
  component Register_file 
 
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
	 
	 end component Register_file;
------------------------------------------------------------------
   component RAM
	port(
	  I_clk          : in  std_logic;
     I_MemWrite     : in  STD_LOGIC;
	  switch	      : in  std_logic_vector (9  downto 0);
	  address        : in  std_logic_vector(7  downto 0);
	  Write_data_rs2 : in  std_logic_vector(31 downto 0);
	  read_data      : out std_logic_vector(31 downto 0);
	  leds           : out  std_logic_vector(9 downto 0);
	  flush          : in  std_logic;
	  bypas_data     : out  std_logic;
	  I_lbyte        : in bit;
	   display_0      : out std_logic_vector(3 downto 0);
			  display_1      : out std_logic_vector(3 downto 0);
			  display_2      : out std_logic_vector(3 downto 0);
			  display_3      : out std_logic_vector(3 downto 0);
			  display_4      : out std_logic_vector(3 downto 0);
			  display_5      : out std_logic_vector(3 downto 0);
			  display_6      : out std_logic_vector(3 downto 0)
	  
		 );
    end component RAM;
-----------------------------------------------------------------

	component ImmGenerator
	
     port(	
	  Instr          :in  std_logic_vector(31 downto 0);
	  IGenerator_out :out std_logic_vector(31 downto 0)
	    );
 end component ImmGenerator;
--------------------------------------------------------------------
  component ALUControl
	
port(
    Instruction_Ac   : in  std_logic_vector(31 downto 0);
    ALU_OP           : in  std_logic_vector(1  downto 0);
	 Out_Control      : out std_logic_vector(3  downto 0);
	 lbyte             : out bit
	 	    );
end component ALUControl;
-----------------------------------------------------------------------

  component ALU 
	 
	   port(
	   OP1             :in  std_logic_vector(31 downto 0);
		OP2             :in  std_logic_vector(31 downto 0);
		result          :out std_logic_vector(31 downto 0);
		Alu_Control     :in  std_logic_vector(3 downto 0 );
		less_than_zero       :out std_logic_vector(1 downto 0);
		Select_Mux_out_ALu: out bit;
		--Mux_ALU_in      :in  bit;
	   I_clk           :in std_logic
			);
   end component ALU;

---------------------------------------------------------------------

  component Branch_control 
	
 port(
   -- less        :  in std_logic;
	 --zero        :  in std_logic;
	  less_zero     :in std_logic_vector(1 downto 0);
	 branch_ctl_i:  in std_logic;
	 out_B_ctl   :  out bit
    
	 );
		end component Branch_control;
---------------------------------------------------------------------

  component Mult16x16 
  
  port(
  
      multiplying: in  std_logic_vector(15 downto 0);
      multiplier : in  std_logic_vector(15 downto 0);
	   product    : out std_logic_vector(31 downto 0)
		 
		 );
	end component Mult16x16;
---------------------------------------------------------------------

  component Mux_ALU_OUT 
 
   port
	(
	 
	 Alu1        : in  std_logic_vector(31 downto 0);
	 Alu2        : in  std_logic_vector(31 downto 0);
	 Sel         : in  bit;
	 Out_mux_ALu : out std_logic_vector(31 downto 0)
	
	 );
 end component Mux_ALU_OUT;
 ---------------------------------------------------------------------
 
  component Mux_Mem_to_reg
  
	port 
	(
	 input_alu     : in  std_logic_vector (31 downto 0);
	 input_Memory  : in  std_logic_vector (31 downto 0);
	 input_PC4     : in  std_logic_vector (31 downto 0);
	 out_to_reg    : out std_logic_vector (31 downto 0);
	 sel_M         : in  std_logic_vector (1  downto 0);
	-- switch	      : in  std_logic_vector (9  downto 0);
	 bypass_memory : in  std_logic
	 );
 end component Mux_Mem_to_reg;
  ---------------------------------------------------------------------

 component Mux_ALU_in 
 
  port(
     Mux_ALU_in      :in  bit;
	  R_data2         :in  std_logic_vector(31 downto 0); 
     ImmOut          :in  std_logic_vector(31 downto 0);    
	  Out_alu_src            :out std_logic_vector(31 downto 0)
  
      );
		 end component Mux_ALU_in;
		
 component Displays_leds
 
 port (
    
      clk                     : IN std_logic;   
      rst                     : IN std_logic;   
      dataout                 : OUT std_logic_vector(7 DOWNTO 0);  
      en                      : OUT std_logic_vector(3 DOWNTO 0);    
      cntfirst                : IN  std_logic_vector(3 downto 0);
		cntsecond               : IN  std_logic_vector(3 downto 0);
	   cntthird                : IN  std_logic_vector(3 downto 0);
		cntlast                 : IN  std_logic_vector(3 downto 0) 
      );
		
 end component Displays_leds;
 
 
 component Debug_mode 
	 port (
	 
	   clk_button: in std_logic;
	   clk_50    : in std_logic;
      clk_out   : out std_logic;
	   res       : in std_logic
	 
	       );
	 end component Debug_mode;
 
--Declare internal signals to use as wires to connect blocks---------

 SIGNAL wire_pc_rom: std_logic_vector(31 downto 0);
 SIGNAL wire_opcode_control: std_logic_vector(6 downto 0);
 SIGNAL wire_rs2Rom_rs2RF,wire_rs1Rom_rs1RF ,wire_rdRom_wrRegRF : std_logic_vector(4 downto 0);
 SIGNAL wire_Rdata1, wireRdata2, wire_Immg_out,wire_Rom_ImmgIn, wire_Instruct_Rom_Aluctl:std_logic_vector(31 downto 0);
 SIGNAL wire_ALUOp: std_logic_vector(1 downto 0);
 SIGNAL wire_WriteEnable,wire_branch_ctl,clk: std_logic;
 SIGNAL wire_lessthan_zero: std_logic_vector(1 downto 0);
 SIGNAL wire_sel,wire_Mux_ALUin: bit;
 SIGNAL wire_branch_ctl_out: bit;
 SIGNAL wire_ALU_control:std_logic_vector(3 downto 0);
 SIGNAL wire_RESULT,wire_out_calc:std_logic_vector(31 downto 0);
 SIGNAL wire_writeData: std_logic_vector(31 downto 0);
 SIGNAL wire_ALU1, wire_ALU2: std_logic_vector(31 downto 0);
 SIGNAL wire_flush_memory, wire_write_enable:std_logic;
 SIGNAL wire_out_memory : std_logic_vector(31 downto 0);
 SIGNAL wire_pc4 : std_logic_vector(31 downto 0);
 SIGNAL wire_SMMTR: std_logic_vector(1 downto 0); 
 SIGNAL wire_debug_mode: std_logic_vector(31 downto 0);
 SIGNAL WIRE:STD_logic_vector(31 DOWNTO 0);
 SIGNAL wire_alu_src_dat:std_logic_vector(31 downto 0);
 SIGNAL wire_jump,wire_lbyte:bit;
 signal wire_bypass_data: std_logic;
 SIGNAL wire_data_leds:std_logic_vector(9 DOWNTO 0);
 signal wire_dp0, wire_dp1, wire_dp2, wire_dp3: std_logic_vector(3 downto 0);
 begin 
   

   Tb_Pc<=wire_pc_rom;
	 Tb_opcode<=wire_opcode_control;
	 Tb_rs1<=wire_rs1Rom_rs1RF;
	 Tb_rs2<=wire_rs2Rom_rs2RF; 
	 Tb_rd <=wire_rdRom_wrRegRF;	 
	 Tb_write_data<=wire_writeData;
	 Tb_Read_1<=wire_Rdata1;
	 Tb_Read_2<=wireRdata2; 
	 Tb_ImmGen<=wire_immg_out;
	 Tb_Alu_result<=wire_out_calc;
	  --sinais alu control
	 Tb_AluContol<=wire_aLU_control;
	 
	

         



u1: ProcessorCounter    PORT MAP(I_clk =>clk,
                                I_ImmediateGen=>wire_Immg_out,
                                branch_ctl=> wire_branch_ctl_out,
										  Pc_out=>wire_pc_rom,
										  Out_to_reg=>wire_pc4,
										  reset=> key0,
										  jump=>wire_jump
										 -- key1=>key_debug,
										--  debug=>boot_pc
										  );
	

u2: ROM                PORT MAP(I_clk =>clk,
                                addressPC=>wire_pc_rom, 
										  opcode=>wire_opcode_control,
										  rs1=> wire_rs1Rom_rs1RF,
                                rs2=>wire_rs2Rom_rs2RF,
										  rd=>wire_rdRom_wrRegRF,
										  instructO1=>wire_Rom_ImmgIn,
										  instructO2=>wire_Instruct_Rom_Aluctl
										  
										  );

 
u3:Register_file       PORT MAP(I_clk=>clk,
										  R_register1=>wire_rs1Rom_rs1RF,
                                R_register2=>wire_rs2Rom_rs2RF,
										  W_register=>wire_rdRom_wrRegRF,
                                W_data=>wire_writeData, 
										  R_data1=>wire_Rdata1,
										  R_data2=>wireRdata2,
										  W_enable=>wire_WriteEnable
										  );
										  
u4:ImmGenerator        PORT MAP(Instr=>wire_Rom_ImmgIn,
                                IGenerator_out=>wire_Immg_out(31 DOWNTO 0));


u5:ALUControl          PORT MAP(
										  Instruction_Ac=>wire_Instruct_Rom_Aluctl,
										  ALU_OP=>wire_ALUOp,
                                Out_Control=>wire_ALU_control,
                                lbyte=>wire_lbyte);
u6:ALU                 
								PORT MAP(
                                I_clk=>clk,
                                Alu_Control=>wire_ALU_control,
                                OP1=>wire_Rdata1,
										  OP2=>wire_alu_src_dat,
										  result=>wire_ALU2,
										  less_than_zero=>wire_lessthan_zero,
										  Select_Mux_out_ALu=>wire_sel 
										  );

u7:Branch_control      PORT MAP(--less=>wire_lessthan,
                                --zero=>wire_zero,
										  less_zero=>wire_lessthan_zero,
										  branch_ctl_i=>wire_branch_ctl,
                                out_B_ctl=>wire_branch_ctl_out);
								  
u8:Unit_control        PORT MAP (
											I_clk=>clk,
											opcode_control=>wire_opcode_control,
                                 WReg=>wire_WriteEnable, 
											ALUOp=>wire_ALUOp,
											Mux_Alu_in=> wire_Mux_ALUin,
											jump_ctl=>wire_jump,
                                 Mem_Write=>wire_write_enable,
											Branch=>wire_branch_ctl,
											MUX_MEM_OUT=>wire_SMMTR,
											Debug_info=>wire_debug_mode);

u9:Mult16x16           PORT MAP  (
                                  multiplying=>wire_Rdata1(15 downto 0),
											 multiplier =>wireRdata2(15 downto 0),
                                  product => wire_ALU1											 
											 );

u10:RAM                 PORT MAP  (
                                  I_clk=>clk,
											 I_MemWrite=>wire_write_enable,
											 address=> wire_out_calc(7 downto 0),    
											 Write_data_rs2=>wireRdata2, 
											 read_data=>wire_out_memory,  
											 flush=>wire_flush_memory,
											 bypas_data=>wire_bypass_data,
											 I_lbyte=>wire_lbyte,
											 switch=>sw,
											 leds=>LEDR,
											 display_0=>wire_dp0,
											 display_1=>wire_dp1,
											 display_2=>wire_dp2,
											 display_3=>wire_dp3
											 
                                  );

u11:Mux_ALU_OUT         PORT MAP
                                  (
											  Alu1=>wire_ALU1,
											  Alu2=>wire_ALU2,
											  Sel =>wire_sel,
											  Out_mux_ALu=>wire_out_calc
											 
											 );  
u12:Mux_Mem_to_reg      PORT MAP 

                                  (
											  input_alu=>wire_out_calc(31 downto 0),
											  input_Memory=>wire_out_memory,
											  input_PC4=>wire_pc_rom,
											  out_to_reg=> wire_writeData,
											  sel_M=>wire_SMMTR,
											 
											  bypass_memory=>wire_bypass_data
											 );
u13:Mux_ALU_in          PORT MAP  
 
											(
											
											 R_data2=>wireRdata2,
										    ImmOut=>wire_Immg_out,
                                  Mux_ALU_in=>wire_Mux_ALUin,
											 Out_alu_src=>wire_alu_src_dat
										
											);
u14:Displays_leds      PORT MAP 

											(
											 clk=>clk,
											 cntfirst=>wire_dp0,
											 cntsecond=>wire_dp1,
											 cntthird=>wire_dp2,
											 cntlast=>wire_dp3,
											 rst=> key0,
											 dataout=>DISPLAYS,
											 en=>ENABLE	
											);
											
u15:Debug_mode         PORT MAP 
											(
											 clk_button=> key1,
											 clk_50=>clock_50,
											 clk_out=>clk,
											 res=> key0
											);
						

		
end hardware_datapath;