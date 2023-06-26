LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY stepper IS
    PORT (
        config : IN std_config;
        frequencyOut : IN NATURAL;
        enable : IN BIT;
        diraction : IN BIT;
        switchs_out : OUT STD_LOGIC_VECTOR(0 TO 3) := "0000"
    );
END stepper;

ARCHITECTURE astepper OF stepper IS

    COMPONENT frequencer IS
        PORT (
            config : IN std_config;
            frequencyOut : IN NATURAL;
            clk_out : OUT BIT
        );
    END COMPONENT;
    SIGNAL clk_out : BIT;
    SIGNAL frequency : NATURAL;
    SIGNAL state : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";
BEGIN
    frequencerMap : frequencer PORT MAP(
        config,
        frequencyOut => frequency,
        clk_out => clk_out
    );

    pstepper : PROCESS (config.clk_in, config.frequencyStd, frequencyOut)
    BEGIN
        frequency <= frequencyOut * 8;
        IF (enable = '1') THEN
            IF isUp(clk_out) THEN
                IF (diraction = '1') THEN
                    state <= shift(state, 1);
                ELSE
                    state <= unshift(state, 1);
                END IF;
            END IF;
            switchs_out <= state;
        ELSE
            switchs_out <= "1111";
        END IF;
    END PROCESS;
END;