-------------------------------------------------------------
-- Inverter
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Date	  	: November 8, 2018
-- File Name	: Inverter.vhd
-- Architecture	: RTL
-- Description	: Inverts a 4-bit input depending on a toggle switch
-- Acknowledgements: n/a
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Inverter is
	port(
			Input: in std_logic_vector(3 downto 0);
			Toggle: in std_logic;
			Output: out std_logic_vector(3 downto 0)
	);
end Inverter;

architecture rtl of Inverter is

begin
      -- Each bit is xor¡¯d with the toggle to produce the output
	output(3) <= Input(3) xor Toggle;
	output(2) <= Input(2) xor Toggle;
	output(1) <= Input(1) xor Toggle;
	output(0) <= Input(0) xor Toggle;
	
end rtl;
