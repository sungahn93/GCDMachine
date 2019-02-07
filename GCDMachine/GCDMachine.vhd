-------------------------------------------------------------
-- GCD Data Path
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Student ID	: ------
-- Date	  	: November 8, 2018
-- File Name	: GCDMachine.vhd
-- Architecture	: RTL
-- Description	: 
-- Acknowledgements:
-------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity GCD is
	port(
			switches: in std_logic_vector(3 downto 0);
			enter,clk,reset : in std_logic;
			done: out std_logic;
			RegVOut : out std_logic_vector(3 downto 0);
			RegUOut : out std_logic_vector(3 downto 0)
		  );
end GCD;

architecture structural of GCD is

component Controller 
	port(
			clk, reset, enter, zero, gltzero: in std_logic;
			sel, inv, loadA, loadB, Cin, done: out std_logic
	);
end component;

component Datapath
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
end component;

signal sel : std_logic;
signal inv : std_logic;
signal loadA : std_logic;
signal loadB : std_logic;
signal Cin : std_logic;
signal zero : std_logic;
signal gltzero : std_logic;

begin
		myDatapath: component Datapath port map(Switches => switches,
									Clk => clk,
									Rst => reset,
									Sel => sel,
									Inv => inv,
									LoadA => loadA,
									LoadB => loadB,
									CarryIn => Cin,
									Zero => zero,
									Gltzero => gltzero,
									RegVOut => RegVOut,
									RegUOut => RegUOut);
									
		myController: component Controller port map(clk => clk,
																	reset => reset,
				enter => enter,
			      zero => zero,
				gltzero => gltzero,
			      sel => sel,												inv => inv,
				loadA => loadA,
				loadB => loadB,
				Cin => Cin,
				done => done);
	
end structural;
