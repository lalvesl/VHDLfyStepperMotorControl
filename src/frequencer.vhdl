LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY frequencer IS
    PORT (
        config : IN std_config;
        frequencyOut : IN NATURAL;
        clk_out : OUT BIT := '0'
    );
END frequencer;

ARCHITECTURE afrequencer OF frequencer IS
    SIGNAL counter : NATURAL := 1;
    SIGNAL counterMax : NATURAL;
    SIGNAL counter2Precision : NATURAL := 1;
    SIGNAL counter2PrecisionMax : NATURAL;
    SIGNAL state : BIT := '0';
    SIGNAL clk_inOld : BIT;
BEGIN
    pfrequencer : PROCESS (config.clk_in, config.frequencyStd, frequencyOut)
    BEGIN
        IF (isUp(config.clk_in) AND frequencyOut /= 0) THEN

            -- Commented this code becase this greater preciosion isn't necessary
            -- IF ((config.frequencyStd MOD frequencyOut) /= 0) THEN
            --     counter2PrecisionMax <= ((config.frequencyStd/((config.frequencyStd MOD frequencyOut)/2))/(config.frequencyStd/frequencyOut));
            --     IF (counter2PrecisionMax < counter2Precision) THEN
            --         counterMax <= (config.frequencyStd/frequencyOut) + ((config.frequencyStd/((config.frequencyStd MOD frequencyOut)/2)) - (counter2PrecisionMax * (config.frequencyStd/frequencyOut)));
            --         ELSE
            --         counterMax <= (config.frequencyStd/frequencyOut);
            --     END IF;
            --     ELSE
            --     counterMax <= (config.frequencyStd/frequencyOut);
            -- END IF;

            -- Replaced for olny this code
            counterMax <= (config.frequencyStd/frequencyOut);

            IF counter < counterMax THEN
                counter <= counter + 1;
            ELSE
                IF (counter2PrecisionMax < counter2Precision) THEN
                    counter2Precision <= 1;
                ELSE
                    counter2Precision <= counter2Precision + 1;
                END IF;
                counter <= 1;
                clk_out <= NOT state;
                state <= NOT state;
            END IF;
        END IF;
    END PROCESS;
END;