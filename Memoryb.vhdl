library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;



entity Memoryb  is
port (clk, mem_w: in std_logic; 
			mem_add: in std_logic_vector(15 downto 0); 
			mem_val: in std_logic_vector(15 downto 0); 
			mem_radd: in std_logic_vector(15 downto 0);
			mem_radd1: in std_logic_vector(15 downto 0);
			mem_out: out std_logic_vector(15 downto 0);
			mem_out1: out std_logic_vector(15 downto 0);
			mem_test: out std_logic_vector(15 downto 0)); -- testing remove
end entity;

architecture Struct of Memoryb is
	
	function to_std_logic_vector(x: bit_vector) return std_logic_vector is
     alias lx: bit_vector(1 to x'length) is x;
     variable ret_val: std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_std_logic_vector;
	
	
	-- initializes memory from text file
	constant ram_depth : natural := 128;
	constant ram_width : natural := 16;
	
  
	type mem_array is array (0 to ram_depth - 1)
		of std_logic_vector(ram_width - 1 downto 0);
	--signal ram: mem_array;
	
	impure function init_ram_bin return mem_array is
		file mem_file: text open read_mode is "C:\_apex\IITB\Sem3\EE224_DigitalSystems\ee224-fpga-final\memory_init.txt";
		variable input_vector_var: bit_vector (ram_width - 1 downto 0);
		variable input_line: line;
		variable ram_content: mem_array;
		begin
			for i in 0 to ram_depth - 1 loop
				readline (mem_file, input_line);
				read(input_line, input_vector_var);
				ram_content(i) := to_std_logic_vector(input_vector_var);
			end loop;
		return ram_content;
	end function;
	
	--signal outp : mem_array := init_ram_bin;
	signal outp: mem_array := (0 => "1001000000000001",
										1 => "1001100000000001",
										2 => "1001101000000001",
										3 => "1001110000000001",
										4 => "1001001000000111",
										5 => "1001010000000101",
										6 => "0000001010011000",
										7 => "0010001010011000",
										8 => "0011001010011000",
										9 => "0001001011000011",
										10 => "0100001010011000",
										11 => "0101001010011000",
										12 => "0110001010011000",
										13 => "1000011000000110",
										14 => "1011001010011010",
										15 => "1010010001011000",
										16 => "1100001010000011",
										22 => "1101001000000011",
										28 => "1001001000000111",
										29 => "1001010000000101",
										30 => "1111011001000000",
										others => "0000000000000000");
	
	signal en: std_logic_vector(ram_depth - 1 downto 0);

	begin 	
	
	mem_test <= outp(0);
	memproc:process(mem_add, mem_w, mem_radd, mem_radd1, clk, outp, mem_val)
	
	begin
		if (mem_w = '1' and falling_edge(clk)) then
			outp(to_integer(unsigned(mem_add))) <= mem_val;
		end if;
		mem_out <= outp(to_integer(unsigned(mem_radd)));
		mem_out1 <= outp(to_integer(unsigned(mem_radd1)));
	end process;
	
	
end Struct;