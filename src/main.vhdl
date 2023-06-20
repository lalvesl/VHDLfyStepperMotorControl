--  Hello world program.
USE std.textio.ALL; --  Imports the standard textio package.

--  Defines a design entity, without any ports.
ENTITY main IS
END main;

ARCHITECTURE behaviour OF main IS
BEGIN
    PROCESS
        VARIABLE l : line;
    BEGIN
        write (l, STRING'("Hello worasdasdld!"));
        writeline (output, l);
        WAIT;
    END PROCESS;
END behaviour;
