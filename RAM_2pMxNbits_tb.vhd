LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.STD_LOGIC_UNSIGNED.ALL;
ENTITY RAM_2pMxNbits_tb IS
    GENERIC (
        M : NATURAL := 4;
        N : NATURAL := 8);
END;

ARCHITECTURE RAM_2pMxNbits_tb_arch OF RAM_2pMxNbits_tb IS
    SIGNAL Dout : STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
    SIGNAL OE : STD_LOGIC;
    SIGNAL RW_n : STD_LOGIC;
    SIGNAL Adr : STD_LOGIC_VECTOR (M - 1 DOWNTO 0);
    SIGNAL DIN : STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
    SIGNAL CS_n : STD_LOGIC;
    COMPONENT RAM_2pMxNbits
        GENERIC (
            M : NATURAL;
            N : NATURAL);
        PORT (
            Dout : OUT STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            OE : IN STD_LOGIC;
            RW_n : IN STD_LOGIC;
            Adr : IN STD_LOGIC_VECTOR (M - 1 DOWNTO 0);
            DIN : IN STD_LOGIC_VECTOR (N - 1 DOWNTO 0);
            CS_n : IN STD_LOGIC);
    END COMPONENT;
BEGIN
    PROCESS
    BEGIN
        -- ecriture donc OE='0' RW_n='0' CS='0'(memoire active) else on désactive--
        -- *e1*--
        OE <= '0';
        RW_n <= '0';
        Adr <= "0011";
        DIN <= "11111111";
        CS_n <= '0';
        WAIT FOR 20 ns;

        -- *e2*--
        OE <= '0';
        RW_n <= '0';
        Adr <= "0001";
        DIN <= "11110000";
        CS_n <= '1';
        WAIT FOR 20 ns;

        -- *e3*--
        OE <= '0';
        RW_n <= '0';
        Adr <= "1011";
        DIN <= "00011111";
        CS_n <= '0';
        WAIT FOR 20 ns;

        -- *e4*--
        OE <= '0';
        RW_n <= '0';
        Adr <= "1111";
        DIN <= "00010111";
        CS_n <= '1';
        WAIT FOR 20 ns;

        -- lectrue donc OE='1' RW_n='0' CS='0'(memoire active) else on désactive--
       
        -- *l1*--
        OE <= '1';
        RW_n <= '1';
        Adr <= "0011";
        DIN <= "11111111";
        CS_n <= '0';
        WAIT FOR 20 ns;

        -- *l2*--
        OE <= '0';
        RW_n <= '1';
        Adr <= "1011";
        DIN <= "11110000";
        CS_n <= '1';
        WAIT FOR 20 ns;

        -- *l3*--
        OE <= '1';
        RW_n <= '1';
        Adr <= "1011";
        DIN <= "00011111";
        CS_n <= '0';
        WAIT FOR 20 ns;

        -- *l4*--
        OE <= '0';
        RW_n <= '1';
        Adr <= "1111";
        DIN <= "00010111";
        CS_n <= '1';
        WAIT ;
    END PROCESS;
    DUT : RAM_2pMxNbits
    GENERIC MAP(
        M => M,
        N => N)
    PORT MAP(
        Dout => Dout,
        OE => OE,
        RW_n => RW_n,
        Adr => Adr,
        DIN => DIN,
        CS_n => CS_n);
END;
