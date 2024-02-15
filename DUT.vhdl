-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  Full-adder.

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
   port(input_vector: in std_logic_vector(10 downto 0);
       	output_vector: out std_logic_vector(7 downto 0));
end entity DUT;

architecture DutWrap of DUT is
	component top_level is
	port
	(
		reset, clock, reg_div: in std_logic;
		add_c: in std_logic_vector(7 downto 0);
		outp: out std_logic_vector(7 downto 0)
		--reg1, reg2, reg3, reg7: out std_logic_vector (15 downto 0)
	);
end component;	

begin

   add_instance: top_level port map (
					clock => input_vector(0),
					reset => input_vector(1),
					reg_div => input_vector(2),
					add_c => input_vector(10 downto 3),
					outp  => output_vector);

end DutWrap;

