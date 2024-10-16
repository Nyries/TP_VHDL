library ieee;
use ieee.std_logic_1164.all;

package composants is 
  
  COMPONENT RAM_2pMxNbits
        GENERIC (
            M : NATURAL := 4;
            N : NATURAL:=8);
        PORT (
            Dout : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            OE : IN STD_LOGIC;
            RW_n : IN STD_LOGIC;
            Adr : IN STD_LOGIC_VECTOR (M - 1 DOWNTO 0);
            DIN : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            CS_n : IN STD_LOGIC);
    END COMPONENT;
    
    component counter_dec 
        generic( M : natural := 8);
        port(
            ud : in std_logic;
            reset : in std_logic;
            clk : in std_logic;
            enable : in std_logic;
            count : out std_logic_vector(M-1 downto 0)
        );
    end component; 
    
    component GENHL
        Port (
            RESET   : in  std_logic;
            CLK     : in  std_logic;
            ENREAD  : inout std_logic;
            ENWRITE : out std_logic
        );
    end component;
        
    component mux 
    port(
        in1,in2,sel:in std_logic;
        sort :out std_logic
    );
    end component;
    
  
  
  
end composants;
