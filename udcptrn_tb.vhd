library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_udcptrn is
end tb_udcptrn;

architecture behavior of tb_udcptrn is

    -- Constants
    constant CLK_PERIOD : time := 10 ns;

    -- Signal declarations
    signal ud       : std_logic := '0';
    signal reset    : std_logic := '0';
    signal clk      : std_logic := '0';
    signal enable   : std_logic := '0';
    signal cptr     : std_logic_vector(11 downto 0);

    -- Instantiate the Unit Under Test (UUT)
    component counter_dec is
        generic( m : natural := 12);
        port(ud : in std_logic;
             reset : in std_logic;
             clk : in std_logic;
             enable : in std_logic;
             cptr : out std_logic_vector(m-1 downto 0));
    end component;

begin

    uut: counter_dec
        port map (
            ud => ud,
            reset => reset,
            clk => clk,
            enable => enable,
            cptr => cptr
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

        -- Enable counting
        enable <= '1';

        -- Test increment
        ud <= '1'; -- Set to increment
        for i in 0 to 5 loop
            wait for CLK_PERIOD;
        end loop;

        -- Test decrement
        ud <= '0'; -- Set to decrement
        for i in 0 to 5 loop
            wait for CLK_PERIOD;
        end loop;

        -- Disable counting
        enable <= '0';
        ud <= '1'; -- This should have no effect
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
