Library ieee;
Use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE WORK.PACKAGE_MIPS.ALL;

 

ENTITY REGISTER_FILES IS 
GENERIC (
		n:integer:=32;
		REG:integer:=4;
		REG_COUNT:integer:=4
		);
		

  PORT (
		Clock			:IN 	STD_LOGIC :='0';
		rs_Add 			:IN		STD_LOGIC_VECTOR(REG-1 DOWNTO 0):=(OTHERS=>'0');
		rt_Add			:IN		STD_LOGIC_VECTOR(REG-1 DOWNTO 0):=(OTHERS=>'0');
		rd_Add			:IN 	STD_LOGIC_VECTOR(REG-1 DOWNTO 0):=(OTHERS=>'0');	
		RegWrite		:IN 	STD_LOGIC:='0';
		Data_in			:IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0) :=(OTHERS=>'0');
		OutPut_Reg_rs	:OUT	STD_LOGIC_VECTOR(n-1 DOWNTO 0) :=(OTHERS=>'0');
		OutPut_Reg_rt	:OUT	STD_LOGIC_VECTOR(n-1 DOWNTO 0):=(OTHERS=>'0')
		);
END ENTITY;

ARCHITECTURE BEHAVIRAL of REGISTER_FILES IS 
SIGNAL  REGISTER_F:Word_VECTOR(REG_COUNT-1 DOWNTO 0):=(OTHERS=>"00000000000000000000000000000000"); 


BEGIN
process(Clock)
  BEGIN
	IF (Clock'event and Clock = '0') THEN
	     IF to_integer(UNsigned(rs_Add))=0 THEN 
	    	       	OutPut_Reg_rs<=(OTHERS=>'0');
		      END IF;
		   IF (to_integer(UNsigned(rt_Add)))=0 THEN 
		            OutPut_Reg_rt<=(OTHERS=>'0');
		      END IF;
		
	     IF (to_integer(UNsigned(rs_Add)))>0  then
	   	           OutPut_Reg_rs<=REGISTER_F(to_integer(UNsigned(rs_Add)));
      end if;
	       IF  (to_integer(UNsigned(rt_Add)))>0 then
	      OutPut_Reg_rt<=REGISTER_F(to_integer(UNsigned(rt_Add)));

      end if;
		
END IF;
	IF (Clock'event and Clock = '1')THEN
	IF (RegWrite='1') THEN
	  
        REGISTER_F(to_integer(UNsigned(rd_Add)))<=Data_in;
		END IF;
	END IF ;
		   
	   END PROCESS;
		   

END ARCHITECTURE;

			
    