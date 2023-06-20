LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY full_adder_test IS
END full_adder_test;

ARCHITECTURE behavior OF full_adder_test IS
    COMPONENT full_adder IS
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            ci : IN STD_LOGIC;
            s : OUT STD_LOGIC;
            co : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL input : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL output : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    uut : full_adder PORT MAP(
        a => input(0),
        b => input(1),
        ci => input(2),
        s => output(0),
        co => output(1)
    );

    stim_proc : PROCESS
    BEGIN
        input <= "000";
        WAIT FOR 1 ns;
        ASSERT output = "00" REPORT "0+0+0 failed";
        input <= "001";
        WAIT FOR 1 ns;
        ASSERT output = "01" REPORT "0+0+1 failed";
        input <= "010";
        WAIT FOR 1 ns;
        ASSERT output = "01" REPORT "0+1+0 failed";
        input <= "100";
        WAIT FOR 1 ns;
        ASSERT output = "01" REPORT "1+0+0 failed";
        input <= "011";
        WAIT FOR 1 ns;
        ASSERT output = "10" REPORT "0+1+1 failed";
        input <= "110";
        WAIT FOR 1 ns;
        ASSERT output = "10" REPORT "1+1+0 failed";
        input <= "111";
        WAIT FOR 1 ns;
        ASSERT output = "11" REPORT "1+1+1 failed";
        REPORT "full_adder_test finished";
        WAIT;
    END PROCESS;
END;