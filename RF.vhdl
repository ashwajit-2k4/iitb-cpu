library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RF is
port (
		clk, w, rst: in std_logic; -- clock, write, reset signals
		
		wrega, rrega0, rrega1: in std_logic_vector(2 downto 0); -- write and read register address
		wregc: in std_logic_vector(15 downto 0); -- write register content
		rregc0, rregc1, reg7_ip, reg1, reg2, reg3, reg0, reg4, reg5, reg6: out std_logic_vector(15 downto 0)	-- read register contents
	);
end entity RF;

architecture behav of RF is

	type reg_arr is array(0 to 7) of std_logic_vector(15 downto 0);
	
	signal regf : reg_arr := (others => "0000000000000000");
	
	begin
	
	reg0 <= regf(0);
	reg1 <= regf(1);
	reg2 <= regf(2);
	reg3 <= regf(3);
	reg4 <= regf(4);
	reg5 <= regf(5);
	reg6 <= regf(6);
	reg7_ip <= regf(7);
	
	behv: process(clk, w, rst, wrega, rrega0, rrega1, wregc, regf)
		begin
		
		if (rst = '1') then
			regf <= (others => "0000000000000000");
			rregc0 <= (others => '0');
			rregc1 <= (others => '1');
		else
			if (w = '1' and falling_edge(clk)) then
				regf(to_integer(unsigned(wrega))) <= wregc;
			else
				regf <= regf;
			end if;
			rregc0 <= regf(to_integer(unsigned(rrega0)));
			rregc1 <= regf(to_integer(unsigned(rrega1)));
		end if;
	end process;
	

end architecture;