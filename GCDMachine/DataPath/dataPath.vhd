-------------------------------------------------------------
-- GCD Data Path
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Date	  	: November 8, 2018
-- File Name	: dataPath.vhd
-- Architecture	: RTL
-- Description	: Implements the GCD machine¡¯s data path by integrating the
--                  machines components. The data path is controlled by a
--                  combination of outside inputs and the GCD Controller.
-- Acknowledgements: Overall structure based off of the data path diagram
--                   in the Lab 4 instructions provided by Dr. Ma.
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity dataPath is
    port (	
		Switches : in std_logic_vector(3 downto 0);
		Clk	: in std_logic;
		Rst	: in std_logic;
		Sel	: in std_logic;
		Inv	: in std_logic;
		LoadA : in std_logic;
		LoadB : in std_logic;
		CarryIn	: in std_logic;
		Zero : out std_logic;
		Gltzero : out std_logic;
		RegVOut : out std_logic_vector(3 downto 0);
		RegUOut : out std_logic_vector(3 downto 0)
	);
end dataPath;


architecture structural of dataPath is

--------- COMPONENTS ---------

component Eight2Four_Mux is
	port(
			InputA: in std_logic_vector(3 downto 0);
			InputB: in std_logic_vector(3 downto 0);
			Sel: in std_logic;
			Output: out std_logic_vector(3 downto 0)
	);
end component;


component RegisterV is
	port(
			clk,reset,load: in std_logic;
			inValue: in std_logic_vector(3 downto 0);
			outValue: out std_logic_vector(3 downto 0)
		  );
end component;


component Inverter is
	port(
			Input: in std_logic_vector(3 downto 0);
			Toggle: in std_logic;
			Output: out std_logic_vector(3 downto 0)
	);
end component;


component ZeroDetector is
		port(
				SumResult: in std_logic_vector(3 downto 0);
				Output: out std_logic
			  );
			  
end component;


component adder4bit is
	port(
			InputA: in std_logic_vector(3 downto 0);
			InputB: in std_logic_vector(3 downto 0);
			CarryIn: in std_logic;
			Output: out std_logic_vector(3 downto 0);
			CarryOut: out std_logic
	);
end component;

--------- SIGNALS ---------
signal muxOut : std_logic_vector(3 downto 0);
signal xorOut : std_logic_vector(3 downto 0);
-- Register signals used for future expansion of code
signal intRegUOut : std_logic_vector(3 downto 0);
signal intRegVOut : std_logic_vector(3 downto 0);
signal adderOut : std_logic_vector(3 downto 0);

-------- LOGIC -----------

begin

	myMux: component Eight2Four_Mux port map(InputA => adderOut,
									InputB => Switches,
									Sel => Sel,
									Output => muxOut);
									
	myInv: component Inverter port map(Input => muxOut,
							Toggle => Inv,
							Output => xorOut);
										
	regV: component RegisterV port map(inValue => xorOut,
							clk => Clk,
							reset => Rst,
							load => LoadA,
						      outValue => intRegVOut);
										
	regU: component RegisterV port map(inValue => xorOut,
							clk => Clk,
							reset => Rst,
							load => LoadB,
						      outValue => intRegUOut);
										
	myAdder: component adder4bit port map(InputA => intRegUOut,
							InputB => intRegVOut,
							CarryIn => CarryIn,
							CarryOut => Gltzero,
							Output => adderOut);
											
	myZero: component ZeroDetector port map(SumResult => adderOut,
								Output => Zero);
						
	RegVOut <= intRegVOut;
	RegUOut <= intRegUOut;

end structural;
