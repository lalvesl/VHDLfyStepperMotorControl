LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY frequencer IS
    PORT (
        frequencer_clk_pin : IN BIT;
        frequencyIn : IN NATURAL;
        frequencyOut : IN NATURAL;
        clk_out : OUT STD_LOGIC
    );
END frequencer;

ARCHITECTURE afrequencer OF frequencer IS
    SIGNAL counter : NATURAL RANGE 0 TO frequencyIn;
    SIGNAL state : STD_LOGIC := '0';
BEGIN
    pfrequencer : PROCESS (frequencer_clk_pin, frequencyIn, frequencyOut)
    BEGIN
        IF (frequencer_clk_pin'event AND frequencer_clk_pin = '1') THEN
            IF counter < (frequencyIn/frequencyOut) THEN
                counter <= counter + 1;
            ELSE
                counter <= 0;
                state <= NOT state;
                clk_out <= state;
            END IF;
        END IF;
    END PROCESS;
END;