library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.composants.all;

entity GENADR is
    generic (
      M: natural := 12);
    Port (
        RESET   : in  std_logic;
        CLK     : in  std_logic;
        INCREAD  : in std_logic;
        INCWRITE : in std_logic;
        SELREAD : in std_logic;
        ADRG : out std_logic_vector(M-1 downto 0)
    );
end GENADR;

architecture GENADR of GENADR is
  signal count_read, count_write : std_logic_vector(M-1 downto 0) := "000000000000";
begin
count_dec('1',RESET,CLK,INCREAD,count_read);
  count_dec('1',RESET,CLK,INCWRITE, count_write);
  ADRG <= mux(count_read, count_write, SELREAD);
end GENADR;