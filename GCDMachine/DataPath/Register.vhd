-------------------------------------------------------------
-- Register
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Date	  	: November 8, 2018
-- File Name	: RegisterV.vhd
-- Architecture	: RTL
-- Description	: Stores a value in the form of an output signal, updated
--                  when the load signal is high on a rising edge clock pulse,
--                  resets the output to 0 when reset is high
-- Acknowledgements:
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity RegisterV is
	port(
			clk,reset,load: in std_logic;
			inValue: in std_logic_vector(3 downto 0);
			outValue: out std_logic_vector(3 downto 0)
		  );
end RegisterV;

architecture behavioral of RegisterV is
begin
        process(clk, reset, load)
        begin
                if (reset = '1') then
                     outValue <= "0000";
                elsif (clk'event and clk = '1' and load = '1') then
					outValue <= inValue;
				end if;
		end process;
end behavioral;
