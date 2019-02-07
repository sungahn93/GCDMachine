-------------------------------------------------------------
-- Zero Detector
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Date	  	: November 8, 2018
-- File Name	: ZeroDetector.vhd
-- Architecture	: RTL
-- Description	: Takes a 4-bit number input and detects if it is zero
--                  or not. Outputs 1 on zero, and outputs 0 otherwise.
-- Acknowledgements: n/a
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity ZeroDetector is
		port(
				SumResult: in std_logic_vector(3 downto 0);
				Output: out std_logic
			  );
			  
end ZeroDetector;

architecture rtl of ZeroDetector is 

begin

Output <= not(SumResult(3) or SumResult(2) or SumResult(1) or SumResult(0));

end rtl;

