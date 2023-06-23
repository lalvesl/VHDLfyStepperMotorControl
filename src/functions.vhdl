LIBRARY ieee;

PACKAGE edge_funcs IS -- sample package declaration
    FUNCTION isUp(SIGNAL arg : BIT) RETURN BOOLEAN;
    FUNCTION isDown(SIGNAL arg : BIT) RETURN BOOLEAN;
END PACKAGE edge_funcs;

PACKAGE BODY edge_funcs IS -- corresponding package body
    FUNCTION isUp(SIGNAL arg : BIT) RETURN BOOLEAN IS
    BEGIN
        RETURN (arg'EVENT AND (arg = '1'));
    END FUNCTION isUp;

    FUNCTION isDown (SIGNAL arg : BIT) RETURN BOOLEAN IS
    BEGIN
        RETURN (arg'EVENT AND (arg = '0'));
    END FUNCTION isDown;
END PACKAGE BODY edge_funcs;