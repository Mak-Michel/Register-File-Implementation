library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity register_file is
  port (
    clk : in  std_logic;
    regWrite : in  std_logic;
    dataIn : in  std_logic_vector(31 downto 0);
    readRegA : in  unsigned(4 downto 0);
    readRegB : in  unsigned(4 downto 0);
    writeReg : in  unsigned(4 downto 0);
    dataA : out std_logic_vector(31 downto 0);
    dataB : out std_logic_vector(31 downto 0)
  );
end register_file;

architecture Behavioral of register_file is
  type registerFile is array (0 to 31) of std_logic_vector(31 downto 0);
  signal registers : registerFile;
begin

  process(clk)
  begin
    if rising_edge(clk) then
      -- Write data in the first half cycle
      if regWrite = '1' then
        registers(to_integer(writeReg)) <= dataIn;
      end if;
    elsif falling_edge(clk) then
      -- Read data in the second half cycle
      dataA <= registers(to_integer(readRegA));
      dataB <= registers(to_integer(readRegB));
    end if;
  end process;
end Behavioral;
