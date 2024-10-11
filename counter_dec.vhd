library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_dec is
    generic( M : natural := 8 ); -- Nombre de bits
    port(
        ud      : in std_logic;             -- Signal de direction : '1' pour incr�menter, '0' pour d�cr�menter
        reset   : in std_logic;             -- Signal de r�initialisation
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
            tmp <= (others => '0'); -- R�initialisation
        else
            if enable = '1' then
                if ud = '1' then
                    tmp <= tmp + 1; -- Incr�mentation
                elsif ud = '0' then
                    tmp <= tmp - 1; -- D�cr�mentation
                end if;
            end if;
        end if;
      end if;
    end process;

end behavioral;
