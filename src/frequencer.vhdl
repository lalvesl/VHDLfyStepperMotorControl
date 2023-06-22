LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY frequencer IS
    PORT (
        clk_in : IN BIT;
        frequencyIn : IN NATURAL;
        frequencyOut : IN NATURAL;
        clk_out : OUT BIT
    );
END frequencer;

ARCHITECTURE afrequencer OF frequencer IS
    SIGNAL counter : NATURAL RANGE 0 TO frequencyIn := 0;
    SIGNAL state : BIT := '0';
BEGIN
    pfrequencer : PROCESS (clk_in, frequencyIn, frequencyOut)
    BEGIN
        IF (clk_in'event) THEN
            IF counter < ((frequencyIn/frequencyOut) - 1) THEN
                counter <= counter + 1;
            ELSE
                counter <= 0;
                clk_out <= NOT state;
                state <= NOT state;
            END IF;
        END IF;
    END PROCESS;
END;