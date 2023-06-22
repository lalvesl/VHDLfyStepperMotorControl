LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY frequencer_test IS
END;

ARCHITECTURE afrequencer_test OF frequencer_test IS
    COMPONENT frequencer IS
        PORT (
            clk_in : IN BIT;
            frequencyIn : IN NATURAL;
            frequencyOut : IN NATURAL;
            clk_out : OUT BIT
        );
    END COMPONENT;
    SIGNAL clk_in : BIT;
    SIGNAL frequencyIn : NATURAL := 1e5;
    SIGNAL frequencyOut : NATURAL := 300;
    SIGNAL clk_out : BIT;
    SIGNAL clk_outOldState : BIT := '0';
    SIGNAL testCounter : NATURAL := 0;
BEGIN
    uut : frequencer PORT MAP(
        clk_in,
        frequencyIn,
        frequencyOut,
        clk_out
    );

    pfrequencer_test : PROCESS
    BEGIN
        ASSERT clk_out = '0' REPORT "clk_out not started in LOW state";
        FOR freq IN 1 TO 3 LOOP
            frequencyOut <= ((frequencyIn/100) * freq);
            WAIT FOR 10 ns;
            FOR i IN 0 TO (frequencyIn * 90) LOOP
                IF (clk_out /= '0') THEN
                    clk_in <= NOT clk_in;
                    WAIT FOR 10 ns;
                END IF;
            END LOOP;
            WAIT FOR 10 ns;
            -- REPORT "Testing for a generate a frequency=" & INTEGER'image(frequencyOut);
            FOR i IN 0 TO (frequencyIn - 1) LOOP
                clk_in <= NOT clk_in;
                WAIT FOR 3 ns;
                IF (clk_outOldState /= clk_out) THEN
                    WAIT FOR 10 ns;
                    clk_outOldState <= clk_out;
                    WAIT FOR 10 ns;
                    testCounter <= testCounter + 1;
                    WAIT FOR 10 ns;
                END IF;
            END LOOP;
            WAIT FOR 10 ns;
            ASSERT ((testCounter < ((frequencyOut * 102)/100)) AND testCounter >= frequencyOut)REPORT "error on test frequency = " & INTEGER'image(frequencyOut);
            WAIT FOR 10 ns;
            testCounter <= 0;
            clk_outOldState <= '0';
        END LOOP;
        REPORT "Test frequencer_test finished";
        WAIT;
    END PROCESS;
END;