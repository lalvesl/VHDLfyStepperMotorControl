LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- USE ieee.numeric_std.all;

ENTITY stepper_half_single_test IS
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
    stim_proc : PROCESS
        VARIABLE counter : STD_LOGIC_VECTOR(0 TO 3);
    BEGIN
        l_parity : FOR i IN 0 TO 15 LOOP
            REPORT "TESTETS";
        END LOOP l_parity;
        REPORT "full_adder_test finished";
        WAIT;
    END PROCESS;
END;