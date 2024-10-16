library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_dec_tb is
end counter_dec_tb;

architecture behavior of counter_dec_tb is

    constant CLK_PERIOD : time := 10 ns;
    
    signal ud       : std_logic := '0';
    signal reset    : std_logic := '0';
    signal clk      : std_logic := '0';
    signal enable   : std_logic := '0';
    signal count    : std_logic_vector(7 downto 0);

    -- Instantiate the Unit Under Test (UUT)
    component counter_dec is
        generic( M : natural := 8);
        port(
            ud : in std_logic;
            reset : in std_logic;
            clk : in std_logic;
            enable : in std_logic;
            count : out std_logic_vector(M-1 downto 0)
        );
    end component;

begin

    uut: counter_dec
        port map (
            ud => ud,
            reset => reset,
            clk => clk,
            enable => enable,
            count => count
        );

    -- Clock generation
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stim_process : process
    begin
        -- Initialize inputs
        reset <= '1'; enable <= '0'; ud <= '0';
        wait for 20 ns;

        -- Release reset
        reset <= '0';
        wait for 20 ns;

        -- Enable counting and test increment
        enable <= '1';
        ud <= '1'; -- Incrémenter
        for i in 0 to 5 loop
            wait for CLK_PERIOD;
        end loop;

        -- Test decrement
        ud <= '0'; -- Décrémenter
        for i in 0 to 5 loop
            wait for CLK_PERIOD;
        end loop;
        
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;
        
        for i in 0 to 5 loop
            wait for CLK_PERIOD;
        end loop;

        -- Disable counting
        enable <= '0';
        wait for CLK_PERIOD;

        -- Re-enable counting
        enable <= '1';
        wait for CLK_PERIOD;

        -- Reset again
        reset <= '1'; 
        wait for 20 ns;
        reset <= '0';
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end behavior;
