library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity GENHL_tb is
end GENHL_tb;

architecture Behavioral of GENHL_tb is

    -- Signaux internes pour tester GENHL
    signal CLK      : std_logic := '0';
    signal RESET    : std_logic := '0';
    signal ENREAD   : std_logic := '0';
    signal ENWRITE  : std_logic;

    -- P�riode de l'horloge pour la simulation
    constant clk_period : time := 10 ns;

    -- Instanciation de l'unit� � tester (UUT : Unit Under Test)
    component GENHL
        Port (
            RESET   : in  std_logic;
            CLK     : in  std_logic;
            ENREAD  : inout std_logic;
            ENWRITE : out std_logic
        );
    end component;

begin

    -- Instanciation du module GENHL
    uut: GENHL
        port map (
            RESET   => RESET,
            CLK     => CLK,
            ENREAD  => ENREAD,
            ENWRITE => ENWRITE
        );

    -- G�n�ration de l'horloge
    process
    begin
        
            CLK <= '0';
            wait for clk_period / 2;
            CLK <= '1';
            wait for clk_period / 2;
        
    end process;

    -- Stimuli pour tester GENHL
    process
    begin
        -- Phase de r�initialisation
        RESET <= '1';
        wait for 40 ns;
        RESET <= '0';
wait;
        -- Attendre quelques cyles pour observer le comportement normal
        --wait for 2000 ns;

        -- R�initialiser � nouveau pour voir la r�initialisation en action
       -- RESET <= '1';
--        wait for 20 ns;
--        RESET <= '0';
    end process;

end Behavioral;
