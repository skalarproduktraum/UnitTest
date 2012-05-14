BeginPackage["UnitTest`"];

UnitTest::usage = "UnitTest[Test, ExpectedResult] runs the command(s) given in the expression 
    Test and compares the result to ExpectedResult. The return value is set to UTPass[] if the 
    test did work well and to UTFailed[] if the test failed to produce the expected result.";

UnitTestSummary::usage = "UnitTestSummary[] produces a summary of failed and succeeded unit tests
    in the current context.";

UnitTestFailed::usage = "UnitTestFailed[] and UnitTestPassed[] are used as storage for the status
    and return values of UnitTest[].";

UnitTestPassed::usage = UnitTestFailed::usage;

$UnitTestTimedOut::usage = "$UnitTestTimedOut is a special symbol that is returned if a unit test
    does not complete within the specified timeframe.";

$UnitTestOutOfMemory::usage = "$UnitTestOutOfMemory is a special symbol that is returned if a unit test
    exceeds the specified memory constraints.";

Begin["`Private`"];

<<UnitTest/UnitTest.m

End[];
EndPackage[];
