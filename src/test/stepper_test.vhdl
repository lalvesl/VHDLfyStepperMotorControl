LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE ieee.std_logic_textio.ALL;
USE ieee.std_logic_misc.ALL;
LIBRARY work;
USE work.Edge_funcs.ALL;
USE work.std_configs.ALL;

ENTITY stepper_test IS
END;

ARCHITECTURE astepper_test OF stepper_test IS

    COMPONENT stepper IS
        PORT (
            config : IN std_config;
            frequencyOut : IN NATURAL;
            enable : IN BIT;
            switchs_out : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;

    SIGNAL config : std_config;
    SIGNAL frequencyOut : NATURAL := 5e5;
    SIGNAL enable : BIT;
    SIGNAL switchs_out : STD_LOGIC_VECTOR(0 TO 3) := "0000";
    SIGNAL switchs_outSpect : STD_LOGIC_VECTOR(0 TO 3) := "0111";
BEGIN
    config.frequencyStd <= 5e5;
    stepperMap : stepper PORT MAP(
        config,
        frequencyOut,
        enable,
        switchs_out
    );

    pstepper_test : PROCESS
    BEGIN
        -- enable <= '1';
        -- WAIT FOR 10 ns;
        -- ASSERT switchs_out = "1111" REPORT "Switchs_out not disabled";
        -- enable <= '0';
        -- WAIT FOR 10 us;
        -- WAIT FOR 10 us;
        -- ASSERT switchs_out /= "1111" REPORT "Switchs_out not enabled";
        -- FOR i IN 0 TO 4 LOOP
        --     FOR j IN 0 TO 1000 LOOP
        --         config.clk_in <= NOT config.clk_in;
        --         WAIT FOR 10 ns;
        --     END LOOP;
        --     REPORT "aaaaaaaaaaa = " & INTEGER'image(to_integer(unsigned(switchs_out)));
        --     switchs_outSpect <= shift(switchs_outSpect, 1);
        --     ASSERT switchs_out = switchs_outSpect REPORT "Switchs_out spected in different state";
        -- END LOOP;
        REPORT "Stepper_test finished";
        WAIT;
    END PROCESS;
END;