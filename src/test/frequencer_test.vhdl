LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY frequencer_test IS
END;

ARCHITECTURE afrequencer_test OF frequencer_test IS
    COMPONENT frequencer IS
        PORT (
            config : IN std_config;
            frequencyOut : IN NATURAL;
            clk_out : OUT BIT
        );
    END COMPONENT;
    SIGNAL config : std_config;
    SIGNAL frequencyOut : NATURAL := 300;
    SIGNAL clk_out : BIT := '0';
    SIGNAL clk_outOldState : BIT := '0';
    SIGNAL testCounter : NATURAL := 0;
    CONSTANT repetitions : NATURAL := 2;

BEGIN
    config.frequencyStd <= 5e5;
    frequencerMap : frequencer PORT MAP(
        config,
        frequencyOut,
        clk_out
    );

    pfrequencer_test : PROCESS
    BEGIN
        ASSERT clk_out = '0' REPORT "clk_out not started in LOW state";
        FOR freq IN 0 TO 3 LOOP
            frequencyOut <= ((config.frequencyStd/500) * freq);
            WAIT FOR 10 ns;
            testCounter <= 0;
            clk_outOldState <= '0';
            WAIT FOR 10 ns;
            -- REPORT "Testing for a generate a frequency = " & INTEGER'image(frequencyOut);
            FOR i IN 0 TO (config.frequencyStd * repetitions) LOOP
                config.clk_in <= NOT config.clk_in;
                WAIT FOR 10 ns;
                IF (clk_outOldState /= clk_out) THEN
                    WAIT FOR 10 ns;
                    clk_outOldState <= clk_out;
                    WAIT FOR 10 ns;
                    testCounter <= testCounter + 1;
                    WAIT FOR 10 ns;
                END IF;
            END LOOP;
            WAIT FOR 10 ns;
            -- REPORT "Frequency gerated = " & INTEGER'image(testCounter/(repetitions/2));
            ASSERT (((testCounter/(repetitions/2)) <= ((frequencyOut * 102)/100)) AND (testCounter/(repetitions/2)) >= frequencyOut) REPORT "error on test frequency = " & INTEGER'image(frequencyOut);
            WAIT FOR 10 ns;
        END LOOP;
        REPORT "Test frequencer_test finished";
        WAIT;
    END PROCESS;
END;