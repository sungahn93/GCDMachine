-------------------------------------------------------------
-- GCD Controller
-- Author	: Jeff Westwood, Sung Kwan Ahn
-- Date	  	: November 8, 2018
-- File Name	: Controller.vhd
-- Architecture	: RTL
-- Description	: A finite state machine that controls the data patch of the
--                  GCD machine in order to find the greatest common
--                  denominator of two input numbers.
-- Acknowledgements: Controller inputs/outputs based on diagram in the Lab 4
--                   instructions provided by Dr. Ma.
-------------------------------------------------------------

entity Controller is
		port(
				clk, reset, enter, zero, gltzero: in std_logic;
				sel, inv, loadA, loadB, Cin, done: out std_logic
				);
end Controller;

architecture behavioral of controller is
	type state_types is (S0,S1,S2,S3,S4,S5,S6,S7);
	signal state: state_types;

begin
	process(clk,reset)
	
	begin
		if(reset='1')then
			loadA <= '0';
			loadB <= '0';
			done <= '0';
			state <= S0;
		elsif(clk'event and clk ='1')then
			case state is
				when S0 =>
					done <= '0';
					sel <= '0';
					inv <='0';
					loadA <= '0';
					loadB <= '0';
					if(enter='0')then -- initialization
						loadA <= '1';
						state <= S1;
					end if;
					
				when S1 =>
                        -- Buffer for LoadA. Clock twice with enter low.
					if(enter='0')then
						loadA <= '0';
						state <= S1;
					elsif(enter='1')then
						state <= S2;
					end if;
					
				when S2 =>
                        -- Buffer for LoadB. Clock twice with enter low.
					if(enter='0')then
						inv <='1';
						Cin <='1';
						loadB <='1';
						state <= S3;
					elsif(enter='1')then
						state <= S2;
					end if; -- end of initialization
				
				when S3 =>
					if(enter='0')then
						loadB <= '0';
						state <= S3;
					elsif(enter='1')then
						state <= S4;
					end if;
					
				when S4 =>
					inv <='0';
					sel <= '1';
					if(zero='1')then
						--Done processing. Go to Done state.
						state <= S5;
					elsif(gltzero='1')then
			-- if gltzero is high(Cout is high), v is greater than u.
			-- (v - u) > 0 , (v > u) , load it into register V
						loadA <= '1';
						state <= S6;
					elsif(gltzero='0')then
			-- if gltzero is low(Cout is low), u is greater than v.
			-- (v - u) < 0, u > v, load it into register U
						loadB <= '1';
						state <= S7;
					end if;

				when S6 => --gltzero high
                              -- Clear Load signals.
					loadA <= '0';
					loadB <= '0';
					if(zero='0')then
                                    -- Not finished. Recalculate.
						state <= S4;
					elsif(zero='1')then
                                    -- the zero_detector output is 0 so the
                                    -- input zero to the controller is high
						state <= S5;
					end if;
					
				when S7 => --gltzero low
                              -- 2s complement number loaded to -U. Clear Cin
					Cin <= '0';
                              -- Clear Load signals.
					loadA <= '0';
					loadB <= '0';
					if(zero='0')then
                                    -- Not finished. Recalculate.
						state <= S4;
					elsif(zero='1')then
                                    -- Done processing. Go to done state.
						state <= S5;
					end if;
					
				when S5 => -- done state, at this point done = 1;
					if(reset='0')then
						done <= '1';
						state <= S5;
					end if;
			end case;
		end if;
	end process;
end behavioral;
