LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY testbench_final  IS 
END ; 
 
ARCHITECTURE testbench_final_arch OF testbench_final IS
  SIGNAL CLOck_50   :  STD_LOGIC  ; 
  SIGNAL DISPLAYS   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL KEY0   :  STD_LOGIC  ; 
  SIGNAL KEY1   :  STD_LOGIC  ; 
  SIGNAL SW   :  std_logic_vector (9 downto 0)  ; 
  SIGNAL ENABLE   :  std_logic_vector (3 downto 0)  ; 
  SIGNAL LEDR   :  std_logic_vector (9 downto 0)  ; 
  SIGNAL Tb_Pc     :  std_logic_vector(31 downto 0);
  SIGNAL Tb_OPcode : std_logic_vector(6 downto 0);
  SIGNAL  Tb_rs1   : std_logic_vector(4 downto 0);
  SIGNAL   Tb_rs2   :  std_logic_vector(4 downto 0); 
  SIGNAL   Tb_rd    : std_logic_vector(4 downto 0);
  SIGNAL  Tb_write_data: std_logic_vector(31 downto 0);
  SIGNAL  Tb_Read_1: std_logic_vector(31 downto 0);
    SIGNAL  Tb_Read_2: std_logic_vector(31 downto 0);
  SIGNAL  Tb_ImmGen:  std_logic_vector(31 downto 0);
  SIGNAL  Tb_Alu_result:std_logic_vector(31 downto 0);
  SIGNAL   Tb_AluContol:  std_logic_vector(3 downto 0);
  
  COMPONENT Datapath  
    PORT ( 
      CLOck_50  : in STD_LOGIC ; 
      DISPLAYS  : out std_logic_vector (7 downto 0) ; 
      KEY0  : in STD_LOGIC ; 
      KEY1  : in STD_LOGIC ; 
      SW  : in std_logic_vector (9 downto 0) ; 
      ENABLE  : out std_logic_vector (3 downto 0) ; 
      LEDR  : out std_logic_vector (9 downto 0);
		
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
  END COMPONENT ; 
BEGIN
  DUT  : Datapath  
    PORT MAP ( 
      CLOck_50   => CLOck_50  ,
      DISPLAYS   => DISPLAYS  ,
      KEY0   => KEY0  ,
      KEY1   => KEY1  ,
      SW   => SW  ,
      ENABLE   => ENABLE  ,
      LEDR   => LEDR ,
     Tb_Pc => Tb_Pc,		
      Tb_opcode => Tb_opcode ,
		 Tb_rs1 =>  Tb_rs1,
		 Tb_rs2 => Tb_rs2 ,
		  Tb_rd=> Tb_rd,
		  Tb_write_data=>Tb_write_data,
		  Tb_Read_1=>Tb_Read_1,
		   Tb_Read_2=> Tb_Read_2,
			Tb_ImmGen=>Tb_ImmGen,
			Tb_Alu_result=>Tb_Alu_result,
			Tb_AluContol=>Tb_AluContol
) ; 

-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ps, End Time = 15 ms, Period = 50 us
  Process
	Begin
	 CLOck_50  <= '0'  ;
	wait for 50 ps ;
-- dumped values till 15 ps
    Clock_50 <= '1' ;
   wait for 50 ps ;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ps, End Time = 150 ns, Period = 0 ps
  Process
	Begin
	 SW  <= "0000011111"  ;
	wait for 50 ps ;
-- dumped values till 15 ps
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 16 ns, End Time = 1500 ns, Period = 0 ps
  Process
	Begin
	 KEY0  <= '0'  ;
	wait for 50 ps ;
-- dumped values till 15 ps
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 1500 ps, End Time = 115 ns, Period = 100 ps
  Process
	Begin
	 KEY1  <= '0'  ;
	wait for 50 ps ;
	wait;
 End Process;
END;
