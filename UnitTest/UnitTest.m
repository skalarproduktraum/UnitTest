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

UnitTestSummary[TestSuite_:None] := Module[{failedTests, passedTests, testList},
    testList = If[TestSuite == None, Names["Global`*"], TestSuite];
    failedTests = Select[testList, Head[Symbol[#]] == UnitTestFailed && # != "UTFailed" && # != "UTPass" &];
    passedTests = Select[testList, Head[Symbol[#]] == UnitTestPassed && # != "UTFailed" && # != "UTPass" &];

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
        Print["-------------------"];
        If[TestSuite != None, Print["Test Suite: " <> Name[TestList]], Null];
        Print["Tests: " <> ((Length[failedTests]+Length[passedTests])//ToString) <> " Passed: " <> (Length[passedTests]//ToString) <> " Failed: " <> (Length[failedTests]//ToString) <> "\n"];
        Print["Failed tests: " <> Join[failedTests]];
        Print["Passed tests: " <> Join[passedTests]];
    ]
];
