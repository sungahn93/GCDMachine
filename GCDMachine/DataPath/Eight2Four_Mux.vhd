-------------------------------------------------------------
-- Eight to Four Mux
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Date	  	: November 8, 2018
-- File Name	: Eight2Four_Mux.vhd
-- Architecture	: RTL
-- Description	: Takes two sets of 4-bit inputs and outputs one set
--                  depending on the sel switch
-- Acknowledgements: Composed of 2-1 Mux components provided by Dr. Ma.
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Eight2Four_Mux is
	port(
			InputA: in std_logic_vector(3 downto 0);
			InputB: in std_logic_vector(3 downto 0);
			Sel: in std_logic;
			Output: out std_logic_vector(3 downto 0)
	);
end Eight2Four_Mux;

architecture structural of Eight2Four_Mux is

component Mux_2
	port(
			Input: in std_logic_vector(1 downto 0);
			Sel: in std_logic;
			Output: out std_logic
	);
end component;

begin
            -- Map each mux to 1 bit. Tie select lines together.
		myMux1: component Mux_2 port map(										Input(1) => InputA(3),									      Input(0) => InputB(3),										Output => Output(3),									     Sel => Sel										);
		
		myMux2: component Mux_2 port map(											Input(1) => InputA(2),										Input(0) => InputB(2),										Output => Output(2),										Sel => Sel								      );
		
		myMux3: component Mux_2 port map(										Input(1) => InputA(1),										Input(0) => InputB(1),								            Output => Output(1),										Sel => Sel									       );
		
		myMux4: component Mux_2 port map(										Input(1) => InputA(0),									      Input(0) => InputB(0),										Output => Output(0),										Sel => Sel										);
		
end structural;
