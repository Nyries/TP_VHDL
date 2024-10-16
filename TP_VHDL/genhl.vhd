library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity GENHL is
    Port (
        RESET   : in  std_logic;
        CLK     : in  std_logic;
        ENREAD  : inout std_logic;
        ENWRITE : out std_logic
    );
end GENHL;

architecture Behavioral of GENHL is
    -- Param�tre g�n�rique pour le compteur � 8 bits
    component counter_dec
        generic( M : natural := 8 );
        port(
            ud      : in std_logic;
            reset   : in std_logic;
            clk     : in std_logic;
            enable  : in std_logic;
            count   : out std_logic_vector(M-1 downto 0)
        );
    end component;

    signal counter_out : std_logic_vector(7 downto 0);
    signal s_reset, fin_cycle : std_logic;
    
    --signal enable_counter : std_logic := '1';  -- Activer le compteur
--    signal direction : std_logic := '1';       -- Direction d'incr�mentation
--    signal cycle_done : std_logic := '0';      -- Indicateur de fin de cycle (compteur atteint 199)
--
begin

    -- Instanciation du compteur
    u_counter : counter_dec
        generic map ( M => 8 )
        port map (
            ud      => '1',   -- On incr�mente
            reset   => s_reset,       -- R�initialisation du compteur avec le signal RESET
            clk     => CLK,         -- Horloge du syst�me
            enable  => '1', -- Activer/d�sactiver le comptage
            count   => counter_out  -- Sortie du compteur
        );
fin_cycle <= '1' when counter_out = "11000111" else '0';
ENREAD <= fin_cycle;
ENWRITE <= not fin_cycle;
s_reset <= reset or fin_cycle;

    ---- Comparateur pour v�rifier si le compteur a atteint 199
--    process(counter_out)
--    begin
--        if counter_out = "11000111" then  -- 199 en binaire
--            cycle_done <= '1';
--        else
--            cycle_done <= '0';
--        end if;
--    end process;
--    
--    process
--    begin
--        s_reset <= ENREAD OR RESET;
--        wait;
--    end process;
--    
--    -- Logique pour g�n�rer ENREAD et ENWRITE
--    process(CLK, RESET)
--    begin
--        if RESET = '1' then
--            ENREAD <= '0';
--            ENWRITE <= '0';
--        elsif rising_edge(CLK) then
--            if cycle_done = '1' then
--                ENWRITE <= '0';
--                ENREAD <= '1';  -- Lecture d�sactiv�e quand l'�criture est activ�e
--            else
--                ENWRITE <= '1';
--                ENREAD <= '0';  -- Lecture activ�e sinon
--            end if;
--            COUNT <= counter_out;
--        end if;
--    end process;
--
end Behavioral;

