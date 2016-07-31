# Introduction
##### Dated July 30th, 2016
On July 11th 2016, MicroAPL announced the end of support for the APLX product. Since that date, Dyalog has been working with APLX users on developing tools to assist in the migration of existing applications from APLX to Dyalog APL. At this time, the tools are very much “work in progress” and will be updated frequently as we receive feedback.

Comments and contributions are very welcome. Since Dyalog Ltd still has relatively limited knowledge of active APLX applications, we need input from APLX users to help us prioritise our work! Write to us at [aplx@dyalog.com](mailto:aplx@dyalog.com), or participate in [the forum section created for this purpose](http://www.dyalog.com/forum/viewforum.php?f=37) (note that membership not required in order to read the contents of the Dyalog forums).

**Important:** *All of the tools and documents and other information contained in this repository are provided free of charge and without warranty of any kind. Dyalog will endeavour to correct any defects that are reported, but this is a community effort and not a supported product from Dyalog Ltd.* 

###Acknowledgements
Many thanks to *Jay Whipple III* for suffering through the first versions of the emulations - all APLX users who subsequently use these tools should be grateful for his pioneering spirit and prepare to buy him the drink of his choice at the next User Meeting!

Thanks to *Dan Baronet* for contributing the "xfrpc" tools which he has worked on for decades.

**NB:** The tools remain in a state of rapid flux. Feedback and contributions are very welcome!
 Did we say that already?

##Overview
At the moment, the following resources are available or under development:

**Updates to Dyalog v15.0:** Builds of Version 15.0 dated July 29th 2016 or later, include the following APLX-related improvements:

* A fix to an issue with communication between the interpreter and the RIDE, which was causing slow execution of code when using RIDE as the development environment.
* ```⎕NREAD``` now accepts ```¯1``` for the number of elements to read, meaning read to end of file
* ```⎕NREPLACE``` accepts ```¯1``` as a position, meaning "the current position"

**List of Differences:** A document containing a [list of differences](Differences.md) between APLX and Dyalog APL, and a discussion of strategies for dealing with them.

**Emulations of APLX Features:** The file [APLX.dyalog](APLX.dyalog) defines a Dyalog namespace containing emulations for APLX primitives and system functions that are different or do not exist at all in Dyalog APL.

**```]in``` user command:** This user command is available with all standard installations of Dyalog APL v15.0 or later. It can import files in APL Transfer format (.ATF) that are created by the ```)out``` system command which is found in many APL systems, including APLX. For increasing amounts of online help, type ```]?in```,  ```]??in``` (and so on) in a Dyalog session.

**Source Code Translation Tool:** The APLX workspaces ```xfrpx.aws``` and ```xfrpcV5.aws``` (for APLX v5) are APLX versions of Dan Baronets xfrpc tool, which creates “enhanced” transfer files. The ```]in``` user command recognises these files and will perform translation of APLX statements into Dyalog equivalents, including references to the emulation functions.

**Test Cases:** The file [TestAPLX.dyalog]() contains a collection of tests which put the emulations through their paces. If you have problems with any emulated features, a **VERY GOOD THING TO DO** is to contribute a failing test which someone will hopefully fix! 

## Getting Set Up
All the materials developed in this process are available as open source tools via github, and can be found at [http://github.com/Dyalog/aplx](). The easiest way to get hold of a local copy is to download the [zip package](https://github.com/Dyalog/aplx/archive/master.zip), if you want to participate actively or be able to easily view the revision history as new versions are developed, we suggest that you install a GUI front-end for git, for example [SourceTree](https://www.sourcetreeapp.com/) (which is used within the Dyalog development team) or use the [git gui](https://git-scm.com/downloads), and clone the repository.

### Running the Tests

Once you have the materials downloaded (for example to a folder called ```/Users/mkrom/aplx```), it is suggested that you load and run the test script:

        ⎕FIX 'file:///Users/mkrom/aplx/TestAPLX.dyalog'
        TestAPLX.Run 0
    APLX tests completed

You can now edit the TestAPLX and APLX namespaces (the latter was brought in automatically thanks to a :Require statement in TestAPLX) and add new emulations or test cases - and submit proposals for extensions.

## Bringing your Code Across

You export your workspace using ```)OUT``` in APLX, and then import it with ```]in``` under Dyalog APL, and make your own modifications to your source code in order to call the emulation functions. Alternatively, you can use the ```xfrpc``` tool to automatically modify the code to call emulation functions and make other changes to the code.

The conversions are controlled by the file [xfrdefs.txt](xfrdefs.txt); if you are dissatisfied with these definitions and you are brave, you can experiment with adding lines to this file (in the section following ```:APX```), or perhaps more likely, you can remove conversions that you do not wish to make.

Once you have made any changes that you wish to make, copy the latest versions of the files ```xfrcode.dws```, ```APLX.dyalog```, and ```xfrdefs.txt``` from the repository to the Dyalog "ws" folder (```xfrcode.dws``` will be there already, it is used by by ```]in``` user command, it is best to update it just in case you have an older version).

Now we are ready to do the transfer: In APLX, ```)Load``` the workspace to be transferred, then:

         )COPY /Users/mkrom/aplx/xfrpcV5.aws
    SAVED  2014-02-01 23.21.35
      
         ∆xfrto '/Users/mkrom/myws'
    * XFR version 3.11
    1243 objects transferred

This will create the file myws.xpw. Next, start Dyalog APL and import the file.

        ]in /Users/mkrom/myws.xpw -trans=2 -replace
    * XFR version 3.88
    Using the external file "...[dyalog folder]...\ws\xfrdefs.txt" for translations.
    APX3.11 20160729 223656; WS=CLEAR WS
    #.APLX defined from file "...[dyalog folder]...\ws\APLX.dyalog"
    1243 objects defined
     
At this point, ```APLX``` will be a namespace containing the emulation functions, and ```⎕PATH``` will have been set to ```#.APLX```.

##Running the same code in APLX and Dyalog APL
The files ReadCovers/FixCovers are work in progress, with the intention of creating cover-functions in both APLX (for real system functions) and Dyalog APL (for emulation functions), so that the same application code can run on both systems. This will be useful for application which are in active development under APLX while migration work is in progress. This code is not yet working.

##Further Reading

See the list and discussion of differences between APLX and Dyalog APL in the file [Differences.md](Differences.md).

##Comments and Questions

Please send question and comments to [aplx@dyalog.com](mailto:aplx@dyalog.com), or the [Dyalog Forums](http://www.dyalog.com/forum/viewforum.php?f=37), or sign up to GitHub and submit comments and change requests there!