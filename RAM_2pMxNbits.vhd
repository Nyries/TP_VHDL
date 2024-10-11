LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY RAM_2pMxNbits IS
    GENERIC (
        N : NATURAL := 8;
        M : NATURAL := 4
    );
    PORT (
        CS_n, OE, RW_n : IN STD_LOGIC;
        DIN : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Adr : IN STD_LOGIC_VECTOR(M - 1 DOWNTO 0);
        Dout : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)

    );
END RAM_2pMxNbits;

ARCHITECTURE RAM_2pMxNbits OF RAM_2pMxNbits IS
    TYPE memo IS ARRAY (2**M - 1 DOWNTO 0) OF STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL donnee : memo;
BEGIN
    PROCESS (OE, Din, CS_n, RW_n, Adr)
    BEGIN
        IF CS_n = '0' THEN
            IF RW_n = '1' THEN
                IF OE = '1' THEN
                    Dout <= donnee(conv_integer(Adr));
                        ELSE
                        Dout <= (OTHERS => 'Z');
                END IF;
            ELSIF RW_n = '0' THEN
                donnee(conv_integer(Adr)) <= DIN;
                Dout <= (OTHERS => 'Z');
            END IF;
        ELSE
            Dout <= (OTHERS => 'Z');
        END IF;
    END PROCESS;
END RAM_2pMxNbits;
