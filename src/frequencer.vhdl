LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY work;
USE work.edge_funcs.ALL;

ENTITY frequencer IS
    PORT (
        clk_in : IN BIT;
        frequencyIn : IN NATURAL;
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
    pfrequencer : PROCESS (clk_in, frequencyIn, frequencyOut)
    BEGIN
        IF isUp(clk_in) THEN

            -- Commented this code becase this greater preciosion isn't necessary
            -- IF ((frequencyIn MOD frequencyOut) /= 0) THEN
            --     counter2PrecisionMax <= ((frequencyIn/((frequencyIn MOD frequencyOut)/2))/(frequencyIn/frequencyOut));
            --     IF (counter2PrecisionMax < counter2Precision) THEN
            --         counterMax <= (frequencyIn/frequencyOut) + ((frequencyIn/((frequencyIn MOD frequencyOut)/2)) - (counter2PrecisionMax * (frequencyIn/frequencyOut)));
            --         ELSE
            --         counterMax <= (frequencyIn/frequencyOut);
            --     END IF;
            --     ELSE
            --     counterMax <= (frequencyIn/frequencyOut);
            -- END IF;

            -- Replaced for olny this code
            counterMax <= (frequencyIn/frequencyOut);

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