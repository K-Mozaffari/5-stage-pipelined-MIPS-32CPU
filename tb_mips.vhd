Library ieee;
Use ieee.std_logic_1164.all;
USE work.PACKAGE_MIPS.all;
USE ieee.numeric_std.all;

entity tb_mips is
end tb_mips;

architecture behaviour of tb_mips is
signal clock:std_logic:='0';
signal rst:std_logic:='0';
signal GND:std_logic:='0';
constant clk_period : time := 10 ns;
signal READ_DATA_SIG,WRITE_DATA_SIG :std_logic:='0';
signal GEN_ADDRESS_INSTRUCTION,INPUT_INSTRUCTION:std_logic_vector(n-1 downto 0):=(others=>'0');
signal  ADDRESS_MEMORY_READ,COMING_DATA_MEMORY,ADDRESS_MEMORY_WRITE,GOING_DATA_MEMORY:std_logic_vector(n-1 downto 0):=(others=>'0');
signal Mii,Mdd:std_logic_vector(n-1 downto 0):=(OTHERS=>'0');
signal Mi,Md:word_vector(11 downto 0):=(OTHERS=>"00000000000000000000000000000000");
SIGNAL ADDERSS_IN :STD_LOGIC_VECTOR(n-1 DOWNTO 0 ):=(OTHERS=>'0');

--signal Md
 

    begin
       mips5: STAGE_MIPS port map(
									CLOCK,
									RST,
									-----------------
									GEN_ADDRESS_INSTRUCTION,
									INPUT_INSTRUCTION,
									-------------------
									READ_DATA_SIG,
									ADDRESS_MEMORY_READ,
									COMING_DATA_MEMORY,
									------------------
									WRITE_DATA_SIG,
									ADDRESS_MEMORY_WRITE,
									GOING_DATA_MEMORY
									
									);
									
Mi(0)<="10110000000100000000000000000000";
Mi(1)<="00000000000000000000000000000000";
Mi(2)<="00000000000000000000000000000000";
Mi(3)<="00000000000000000000000000000000";
Mi(4)<="00000000000000000000000000000000";
Mi(5)<="00000000000000000000000000000000";
Mi(6)<="00000000000000000000000000000000";
Mi(7)<="00000000000000000000000000000000";
Mi(8)<="00000000000000000000000000000000";
Mi(9)<="00000000000000000000000000000000";
Mi(10)<="00000000000000000000000000000000";
Mi(11)<="00000000000000000000000000000000";


Md(0)<="00000000000000000000000000000001";
Md(1)<="11111111111111111111111111111111";
Md(2)<="00000000000000000000000000000011";
Md(3)<="00000000000000000000000000000100";
Md(4)<="00000000000000000000000000000101";
Md(5)<="00000000000000000000000000000110";
Md(6)<="00000000000000000000000000000111";
Md(7)<="00000000000000000000000000001000";
Md(8)<="00000000000000000000000000001001";
Md(9)<="00000000000000000000000000001010";
Md(10)<="00000000000000000000000000001011";
Md(11)<="00000000000000000000000000001100";
ADDERSS_IN<=GND&GND&GEN_ADDRESS_INSTRUCTION(n-1 DOWNTO 2);

Mii<=Mi(TO_INTEGER(UNsigned(ADDERSS_IN)) );
Mdd<=Md(TO_INTEGER(UNsigned(ADDRESS_MEMORY_READ))); 									

        process -- controle de clock
        begin
            CLOCK <= not CLOCK;
            wait for 10 ns;
        end process;

       process 
	   begin
	     
    wait until CLOCK'event and CLOCK='1';
     INPUT_INSTRUCTION <= Mii;
IF   READ_DATA_SIG='1'THEN
		   COMING_DATA_MEMORY<=Mdd;
		   END IF;
       end process;
       
     ---  process (CLOCK)
	  --- begin
	             
---IF   READ_DATA_SIG='1'THEN
----		   COMING_DATA_MEMORY<=Mdd;


      --- end process;

end behaviour;
