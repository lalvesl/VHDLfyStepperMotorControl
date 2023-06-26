LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY numberIncDec IS
    PORT (
        config : IN std_config;
        switchHigh : IN BIT;
        switchLow : IN BIT;
        numberMax : IN NATURAL;
        numberMin : IN NATURAL;
        numberOut : OUT NATURAL
    );
END numberIncDec;

ARCHITECTURE anumberIncDec OF numberIncDec IS

    COMPONENT frequencer IS
        PORT (
            config : IN std_config;
            frequencyOut : IN NATURAL;
            clk_out : OUT BIT
        );
    END COMPONENT;
    SIGNAL clk_out : BIT;
    SIGNAL frequencyOut : NATURAL := 100;
    SIGNAL state : NATURAL;
BEGIN
    frequencerMap : frequencer PORT MAP(
        config,
        frequencyOut => frequencyOut,
        clk_out => clk_out
    );

    pnumberIncDec : PROCESS (config.clk_in, config.frequencyStd, frequencyOut)
    BEGIN
        IF isUp(clk_out) THEN
            IF (switchHigh = '1') THEN
                IF (numberMax > state) THEN
                    state <= state + 10;
                END IF;
            END IF;
            IF (switchLow = '1') THEN
                IF (numberMin < state) THEN
                    state <= state - 10;
                END IF;
            END IF;
        END IF;
        numberOut <= state;
    END PROCESS;
END;