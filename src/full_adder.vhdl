LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY full_adder IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        ci : IN STD_LOGIC;
        s : OUT STD_LOGIC;
        co : OUT STD_LOGIC);
END;

ARCHITECTURE behavioral OF full_adder IS
BEGIN
    s <= a XOR b XOR ci;
    co <= (a AND b) OR ((a XOR b) AND ci);
END;