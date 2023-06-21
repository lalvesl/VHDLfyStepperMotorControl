LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY main IS
    PORT (
        refclk : IN STD_LOGIC;
        led : OUT STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR(0 TO 3)
    );
END main;

ARCHITECTURE RTL OF main IS
    CONSTANT max_count : NATURAL := 10000000;
    SIGNAL Rst : STD_LOGIC;
BEGIN

    Rst <= '0';

    -- 0 to max_count counter
    compteur : PROCESS (refclk, Rst)
        VARIABLE count : unsigned (31 DOWNTO 0);
        VARIABLE subCount : unsigned (1 DOWNTO 0);
        VARIABLE state : STD_LOGIC_VECTOR(1 DOWNTO 0);
        VARIABLE subState : STD_LOGIC_VECTOR(1 DOWNTO 0);
    BEGIN
        IF Rst = '1' THEN
            count := to_unsigned(0, 32);
            led <= '1';
        ELSIF rising_edge(refclk) THEN
            IF count < max_count/2 THEN
                count := count + 1;
                led <= '1';
            ELSIF count < max_count THEN
                led <= '0';
                count := count + 1;
                subCount := subCount + 1;
                state := subCount(1) & subCount(0);
                IF ("00" = state) THEN
                    s(0) <= '1';
                ELSE
                    s(0) <= '0';
                END IF;

                IF ("01" = state) THEN
                    s(1) <= '1';
                ELSE
                    s(1) <= '0';
                END IF;

                IF ("10" = state) THEN
                    s(2) <= '1';
                ELSE
                    s(2) <= '0';
                END IF;

                IF ("11" = state) THEN
                    s(3) <= '1';
                ELSE
                    s(3) <= '0';
                END IF;

            ELSE
                led <= '1';
                count := to_unsigned(0, 32);
            END IF;
        END IF;
    END PROCESS compteur;
END RTL;