 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity D_FF_VHDL is
	generic(
		BIT_WIDTH : natural := 8
	);
   port
   (
      clk : in std_logic;
 
      rst : in std_logic;
      ce  : in std_logic := '1';
 
      d : in std_logic_vector(BIT_WIDTH-1 downto 0);
      q : out std_logic_vector(BIT_WIDTH-1 downto 0)
   );
end entity D_FF_VHDL;
 
architecture Behavioral of D_FF_VHDL is
begin
   process (clk) is
   begin
      if rising_edge(clk) then  
         if (rst='1') then   
            q <= (others => '0');
         elsif (ce='1') then
            q <= d;
         end if;
      end if;
   end process;
end architecture Behavioral;