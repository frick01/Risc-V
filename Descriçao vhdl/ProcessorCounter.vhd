	 --
-- SÍNTESE DO PROGRAM_COUNTER
--
--
--
--
-- Author: Eng. Guilherme Frick
-- DATA: 06/05/2019

    library IEEE;
	 use IEEE.std_logic_1164.all;
	 use IEEE.std_logic_unsigned.all;
	 use IEEE.numeric_std.all;
	
	
	entity ProcessorCounter is port(
  
   I_clk             :  in  std_logic;
	I_ImmediateGen    :  in  std_logic_vector(31 downto 0);
	branch_ctl        :  in  bit;
	jump              :  in  bit;
   Pc_out            :  out std_logic_vector(31 downto 0);
	Out_to_reg        :  out std_logic_vector(31 downto 0);
	reset             :  in  std_logic
	

	);
	end ProcessorCounter;
	

   architecture hardware of ProcessorCounter is 
	
  --  signal Pc: type;
	 signal Pc_next:std_logic_vector(31 downto 0):=(others => '0');
	 signal Pc_current:std_logic_vector(31 downto 0):=(others => '0');
	 signal Pc_last:std_logic_vector(31 downto 0):=(others => '0');
	 signal Pc4:std_logic_vector(31 downto 0):=(others => '0');
	 signal PcB:std_logic_vector(31 downto 0):=(others => '0');
	 signal PcJ:std_logic_vector(31 downto 0):=(others => '0');
	 
begin
	 
	  
	  mux_pc: process (I_clk,reset)
	  begin
	   
		 if (reset = '1') then
		 Pc_current<="00000000000000000000000000000000";
		 elsif(rising_edge(I_clk))then
		 Pc_current<=Pc_next;
		 Pc_last<=Pc_current;
	 end if; 
	 end process mux_pc;
	 Pc_out<=Pc_current;
	 Pc4 <= Pc_current + "100";
	 Out_to_reg<=Pc4;
	 
	 PcB<=Pc_current+std_logic_vector(signed(I_ImmediateGen)sll 1);
	 PcJ<=Pc_current+ I_ImmediateGen;
	 with (branch_ctl&jump) select
	 Pc_next<= Pc4 when "00",
	           PcB when "10",
				  PcJ when "01",
				  "00000000000000000000000000000000"when others;
				  
end hardware;