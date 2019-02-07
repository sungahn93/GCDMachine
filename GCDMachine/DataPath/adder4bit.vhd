-------------------------------------------------------------
-- 4-bit Adder
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Date	  	: November 8, 2018
-- File Name	: adder4bit.vhd
-- Architecture	: RTL
-- Description	: Adds together two 4-bit numbers, accounting for an input
--                  carry value and outputs the result including carry out
-- Acknowledgements: n/a
-------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

--

entity adder4bit is
	port(
			InputA: in std_logic_vector(3 downto 0);
			InputB: in std_logic_vector(3 downto 0);
			CarryIn: in std_logic;
			Output: out std_logic_vector(3 downto 0);
			CarryOut: out std_logic
	);
end adder4bit;

architecture structural of adder4bit is

component Full_adder
		port(
			Input: in std_logic_vector(1 downto 0);
			CarryIn: in std_logic;
			Sum: out std_logic;
			CarryOut: out std_logic
	);
end component;

-- Internal carry signals to transfer carries between the four full adders
signal internalCarry  : std_logic_vector(2 downto 0);

begin
	
	adder0: component Full_adder port map(CarryIn=>CarryIn,							Input(0)=>InputA(0),							                  Input(1)=>InputB(0),							                  CarryOut=>internalCarry(0),
				Sum=>Output(0));
										
	adder1: component Full_adder port map(CarryIn=>internalCarry(0),
				Input(0)=>InputA(1),
				Input(1)=>InputB(1),
                        CarryOut=>internalCarry(1),
				Sum => Output(1));
										
	adder2: component Full_adder port map(CarryIn=>internalCarry(1),
				Input(0)=>InputA(2),
			      Input(1)=>InputB(2),
				CarryOut=>internalCarry(2),
				Sum => Output(2));
										
	adder3: component Full_adder port map(CarryIn=>internalCarry(2),
				Input(0)=>InputA(3),
				Input(1)=>InputB(3),
				CarryOut=>CarryOut,
				Sum=>Output(3));
end structural;
