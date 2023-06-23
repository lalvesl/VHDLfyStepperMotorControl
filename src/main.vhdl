LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.edge_funcs.ALL;

ENTITY main IS
    PORT (
        clk_pin : IN BIT;
        s : OUT STD_LOGIC_VECTOR(0 TO 3)
    );
END main;

ARCHITECTURE amain OF main IS

    COMPONENT frequencer IS
        PORT (
            clk_in : IN BIT;
            frequencyIn : IN NATURAL;
            frequencyOut : IN NATURAL;
            clk_out : OUT BIT
        );
    END COMPONENT;
    SIGNAL frequencyIn : NATURAL := 50e6;
    SIGNAL frequencyOut2 : NATURAL := 20;
    SIGNAL clk_out2 : BIT;
    SIGNAL clk_out2Old : BIT;
    CONSTANT max_count : NATURAL := 2;
BEGIN

    frequencerMap : frequencer PORT MAP(
        clk_in => clk_pin,
        frequencyIn => frequencyIn,
        frequencyOut => frequencyOut2,
        clk_out => clk_out2
    );
    pmain : PROCESS (clk_pin)
        VARIABLE count : unsigned (31 DOWNTO 0);
        VARIABLE subCount : unsigned (1 DOWNTO 0);
        VARIABLE state : STD_LOGIC_VECTOR(1 DOWNTO 0);
        VARIABLE subState : STD_LOGIC_VECTOR(1 DOWNTO 0);
    BEGIN
        IF isUp(clk_out2) THEN
            clk_out2Old <= clk_out2;
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
        END IF;
    END PROCESS;
END;