   library IEEE;
	 use IEEE.std_logic_1164.all;
	 use IEEE.std_logic_unsigned.all;
	 use IEEE.numeric_std.all;
	
	
	entity Debug_mode is port(
  
   clk_button: in std_logic;
	clk_50    : in std_logic;
   clk_out   : out std_logic;
	res       : in std_logic
	);
	end Debug_mode;
	
	architecture Debug_hardware of Debug_mode is
   signal mode: bit ;
	signal count: std_logic_vector(3 downto 0):=(others => '0');
	signal clk_div: std_logic:='0';
	begin
	process(clk_button,res)
	begin
	if (clk_button = '1' and res = '0') then 
	mode<='1';
	elsif (res = '1') then
	mode <='0';
	end if ;

	end process;
	
	
	
	
	
	
	clk_out <=clk_button when mode = '1' else 
	          clk_50;
				 
--	clk_div<='1' when count = "0100" else 
        	  -- '0';
  -- process (clk_50)
--	begin
--	 if(clk_50 ='1' and clk_50'event) then
 --     count <= count + 1;
 --   end if;
 
    -- quando o contador chega em 5 ele é zerado
  --  if(count = "0101") then
  --    count <= "0000";
 --   end if;
  --end process;

	
				 
	
	end Debug_hardware;
	
	
	