# UnitTest
UnitTest is a lean unit testing framework for Mathematica.

# Requirements
* UnitTest is usable with Mathematica 7 and up - it may or may not work with older versions. It was tested with versions 7, 8, 9 and 10 on Windows, Linux and OS X.

# Installation
* clone this repository somewhere on your harddisk
* create a symbolic link to the `UnitTest` directory of this package in your `Mathematica/Applications` or `Mathematica/Autoload` directory. On OS X, you can find this directory in ~username/Library/Mathematica, on Linux it's located in ~username/.mathematica

# The road runners guide to Mathematica Unit Testing
You can load the package in Mathematica via 

    <<UnitTest`

A unit test is then defined by the following:

    UTMyFirstUnitTest = UnitTest[1+1, 2];

The first argument to *UnitTest[]* is the expression to check, the second the expected result.
When you execute this, Mathematica will show _Passed_ or _FAILED_.

If you have many unit tests defined in your notebook or .m file, *UnitTestSummary[]* comes in handy:
It will collect all unit test and show you in a convenient manner which test succeeded and which failed - and where.
You can also use *UnitTestSummary[]* in a Mathematica script, it will then not use GUI elements but output the stats in a machine-readable manner, which is useful for automated building or continuous integration.

For more advanced examples, see the `Examples/` directory of this repository. There, you will find _Example.mscript_, an executable script that can be run with MathematicaScript, and _Example.nb_, demonstrating how UnitTest may be used interactively.

# License
UnitTest is available under the very permissive MIT license, which means you can use it for whatever you want, you do not need to pay me, but if you need to leave the licensing information intact if you use my code. Lawyers rejoice: There is also a file called LICENSE in this package with all the lawyer-y stuff.
