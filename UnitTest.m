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

SetAttributes[UnitTest, HoldFirst];
Options[UnitTest] = {Timeout->Infinity, MemoryLimit->Infinity};

UnitTest[Test_, ExpectedResult_, OptionsPattern[]] := Module[{Result = Null},
    If[
        MemoryConstrained[
            TimeConstrained[
                FullSimplify[Test === ExpectedResult], 
                OptionValue[Timeout], 
                Result = $UnitTestTimedOut; False
            ], 
            OptionValue[MemoryLimit], 
            Result = $UnitTestOutOfMemory; False
        ],
        Print[Style["Pass", Bold, Darker[Green]]]; UnitTestPassed[],
        Print[Style["FAILED", Bold, Darker[Red]]]; UnitTestFailed[If[Result===Null, Hold[Test], Result], ExpectedResult]
    ]
];

UnitTestSummary[] := Module[{failedTests, passedTests},
    failedTests = Select[Names["Global`*"], Head[Symbol[#]] == UnitTestFailed && # != "UTFailed" && # != "UTPass" &];
    passedTests = Select[Names["Global`*"], Head[Symbol[#]] == UnitTestPassed && # != "UTFailed" && # != "UTPass" &];

    If[!$BatchOutput,
        TabView[{
           If[Length[failedTests] > 0, Style["Failed tests (" <> ToString[Length[failedTests]] <> ")", Red], "Failed tests"] -> Column[OpenerView[{Text[#], 
                                Grid[{{Text["Expected result: "], Level[Symbol[#], 1][[2]]},
                                      {Text["Actual result:"],  
                                        Row[
                                            {
                                            Level[Symbol[#], 1][[1]] 
                                            }
                                            ] }}, Alignment->Left]
                               }]&/@failedTests],
            If[Length[passedTests] > 0, "Passed tests (" <> ToString[Length[passedTests]] <> ")", "Passed tests"] -> Column[Text["\[Bullet] " <> #]&/@passedTests]
        }
        ],
        Print["Tests: " <> ((Length[failedTests]+Length[passedTests])//ToString) <> " Passed: " <> (Length[passedTests]//ToString) <> " Failed: " <> (Length[failedTests]//ToString) <> "\n"];
        Print["Failed tests:  " <> Join[failedTests]];
        Print["Passed tests: " <> Join[passedTests]];
    ]
];

End[];

EndPackage[];
