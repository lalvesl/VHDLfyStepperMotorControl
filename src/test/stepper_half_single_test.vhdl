LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY stepper_half_single_test IS
    PORT (
        a : IN BIT
    );
END stepper_half_single_test;

ARCHITECTURE behavior OF stepper_half_single_test IS
    COMPONENT stepper_half_single IS
        PORT (
            state : IN STD_LOGIC_VECTOR(0 TO 3);
            switchs : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;
    SIGNAL stateCount : STD_LOGIC_VECTOR(0 TO 3);
    SIGNAL switchsOut : STD_LOGIC_VECTOR(0 TO 3);
BEGIN
    pstepper_half_single_test : PROCESS
    BEGIN
        REPORT "full_adder_test finished";
        WAIT;
    END PROCESS;
END;