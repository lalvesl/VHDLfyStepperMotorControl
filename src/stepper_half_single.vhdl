LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY stepper_half_single IS
    PORT (
        state : IN STD_LOGIC_VECTOR(0 TO 3);
        switchs : OUT STD_LOGIC_VECTOR(0 TO 3)
    )
END;

ARCHITECTURE stepper_half_single_a OF stepper_half_single IS
    SIGNAL subState : STD_LOGIC_VECTOR(0 TO 1);
BEGIN
    subState = state(0) & state(1);
    switchs(0) <= subState = 0;
    switchs(1) <= subState = 1;
    switchs(2) <= subState = 2;
    switchs(3) <= subState = 3;
END;