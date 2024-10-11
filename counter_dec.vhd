library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_dec is
    generic( M : natural := 8 ); -- Nombre de bits
    port(
        ud      : in std_logic;             -- Signal de direction : '1' pour incrémenter, '0' pour décrémenter
        reset   : in std_logic;             -- Signal de réinitialisation
        clk     : in std_logic;             -- Horloge
        enable  : in std_logic;             -- Activer le compteur
        count   : out std_logic_vector(M-1 downto 0)  -- Sortie du compteur
    );
end counter_dec;

architecture behavioral of counter_dec is
    signal tmp : std_logic_vector(M-1 downto 0) := (others => '0'); -- Signal interne pour le compteur
begin

    count <= tmp; -- Assignation de la sortie

    process(clk)
    begin
     if rising_edge(clk) then
        if reset = '1' then
            tmp <= (others => '0'); -- Réinitialisation
        else
            if enable = '1' then
                if ud = '1' then
                    tmp <= tmp + 1; -- Incrémentation
                elsif ud = '0' then
                    tmp <= tmp - 1; -- Décrémentation
                end if;
            end if;
        end if;
      end if;
    end process;

end behavioral;
