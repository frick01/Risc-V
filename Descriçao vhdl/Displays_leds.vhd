library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Displays_leds IS
   PORT (
      clk                     : IN std_logic;   
      rst                     : IN std_logic;   
      dataout                 : OUT std_logic_vector(7 DOWNTO 0);   --������������
      en                      : OUT std_logic_vector(3 DOWNTO 0);  --COMʹ������    
      cntfirst                : IN  std_logic_vector(3 downto 0);
		cntsecond               : IN  std_logic_vector(3 downto 0);
	   cntthird                : IN  std_logic_vector(3 downto 0);
		cntlast                 : IN  std_logic_vector(3 downto 0)
		);
		
		
		
END Displays_leds;


ARCHITECTURE arch OF displays_leds IS
signal div_cnt : std_logic_vector(24 downto 0 );
signal data4 :    std_logic_vector(3 downto 0);
signal dataout_xhdl1 : std_logic_vector(7 downto 0);
signal en_xhdl : std_logic_vector(3 downto 0);

signal first_over: std_logic;
signal second_over: std_logic;
signal third_over : std_Logic; 
signal last_over  : std_logic;
begin



---****************��ʾ����***************--
  dataout<=dataout_xhdl1;
  en<=en_xhdl;
  
process(clk,rst)
 begin
   if(rst='1')then 
   div_cnt<="0000000000000000000000000";
   elsif(clk'event and clk='1')then
   div_cnt<=div_cnt+1;
   end if;
 end process;



 
 process(rst,clk,div_cnt(19 downto 18))
 begin
  if(rst='1')then
    en_xhdl<="1110";
  elsif(clk'event and clk='1')then
    case div_cnt(19 downto 18) is
     when"00"=> en_xhdl<="1110";
     when"01"=> en_xhdl<="1101";
     when"10"=> en_xhdl<="1011";
     when"11"=> en_xhdl<="0111"; 
	  when others => en_xhdl<="1110";
    end case;
  end if;
 
--end case;
 end process;
process(en_xhdl,cntfirst,cntsecond,cntthird,cntlast)
begin
 case en_xhdl is 
   when "1110"=> data4<=cntfirst;
   when "1101"=> data4<=cntsecond;
   when "1011"=> data4<=cntthird;
   when "0111"=> data4<=cntlast;   
   when others =>data4<="1010";
  end case;
end process;
  



process(data4)
begin
  case data4 is
   WHEN "0000" =>
                  dataout_xhdl1 <= "11000000";   --0
         WHEN "0001" =>
                  dataout_xhdl1 <= "11111001";   --1 
         WHEN "0010" =>
                  dataout_xhdl1 <= "10100100";  -- 2
         WHEN "0011" =>
                  dataout_xhdl1 <= "10110000";  -- 3
         WHEN "0100" =>
                  dataout_xhdl1 <= "10011001";   --4
         WHEN "0101" =>
                  dataout_xhdl1 <= "10010010";    
         WHEN "0110" =>
                  dataout_xhdl1 <= "10000010";    
         WHEN "0111" =>
                  dataout_xhdl1 <= "11111000";    
         WHEN "1000" =>
                  dataout_xhdl1 <= "10000000";    
         WHEN "1001" =>
                  dataout_xhdl1 <= "10010000";    
         WHEN "1010" =>
                  dataout_xhdl1 <= "10000000";    
         WHEN "1011" =>
                  dataout_xhdl1 <= "10010000";    
         WHEN "1100" =>
                  dataout_xhdl1 <= "01100011";    
         WHEN "1101" =>
                  dataout_xhdl1 <= "10000101";    
         WHEN "1110" =>
                  dataout_xhdl1 <= "01100001";    
         WHEN "1111" =>
                  dataout_xhdl1 <= "01110001";    
         WHEN OTHERS =>
               dataout_xhdl1 <= "00000011"; 
         
         
      END CASE;
   END PROCESS;
end arch;