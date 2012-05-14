# UnitTest
UnitTest is a lean unit testing framework for Mathematica.

# Requirements
* UnitTest is usable (read: tested) with Mathematica 7 and up - it may or may not work with older versions

# Installation
* clone this repository somewhere on your harddisk
* create a symbolic link to the `UnitTest` directory of this package in your `Mathematica/Applications` or `Mathematica/Autoload` directory. On Mac OS X, you can find this directory in ~username/Library/Mathematica, on Linux it's located in ~username/.mathematica

# The road runners guide to Mathematica Unit Testing
You can load the package in Mathematica via 
    <<UnitTest`
A unit test is then defined by the following:
    UTMyFirstUnitTest = UnitTest[1+1, 2];
The first argument to `UnitTest[]` is the expression to check, the second the expected result.
When you execute this, Mathematica will show `Passed` or `FAILED`.

If you have many unit tests defined in your notebook or .m file, UnitTestSummary[] comes in handy:
It will collect all unit test and show you in a convenient manner which test succeeded and which failed - and where.
You can also use UnitTestSummary[] in a Mathematica script, it will then not use GUI elements but output the stats in a machine-readable manner, which is useful for automated building or continous integration.

For more advanced examples, see the `Examples/` directory of this repository.

# License
UnitTest is available under the very permissive MIT license, which means you can use it for whatever you want, you do not need to pay me, but if you need to leave the licensing information intact if you use my code. Lawyers rejoice: There is also a file called LICENSE in this package with all the lawyer-y stuff.
