# Introduction
##### Dated July 29th, 2016
On July 11th 2016, MicroAPL announced the end of support for the APLX product. Dyalog has been working with APLX users on developing tools to assist in the migration of existing applications from APLX to Dyalog APL. At this time, the tools are very much “work in progress” and will be updated frequently as we receive feedback.

Comments and contributions are very welcome. Since Dyalog Ltd still has relatively limited knowledge of active APLX applications, we need input from APLX users to help us prioritise our work! Write to us at [aplx@dyalog.com](mailto:aplx@dyalog.com), or watch the forum section created for this purpose: [http://www.dyalog.com/forum/viewforum.php?f=37]() (note that membership not required in order to read the contents of the Dyalog forums).

###Acknowledgements
Many thanks to *Jay Whipple III* for suffering through the first versions of the mulations - all APLX users who follow in his footsteps should be grateful for his pioneering spirit!

Thanks to *Dan Baronet* for contributing the "xfrpc" tools which he has worked on for decades.

**NB:** The tools remain in a state of rapid flux. Feedback and contributions are very welcome!

##Overview
At the moment, the following resources are available or under development:

**List of Differences:** A document containing a list of differences between APLX and Dyalog APL, and a discussion of strategies for dealing with them.

**```]in``` user command:** This user command is available with all standard installations of Dyalog APL v15.0 or later, can import files in APL Transfer format (.ATF) that are created by the ```)out``` system command which is found in many APL systems, including APLX. For increasing amounts of online help, type ```]?in```,  ```]??in``` (and so on) in a Dyalog session.

**Source Code Translation Tool:** The APLX workspaces ```xfrpx.aws``` and ```xfrpcV5.aws``` (for APLX v5) are APLX versions of Dan Baronets xfrpc tool, which creates “enhanced” transfer files. The ```]in``` user command recognises these files and will perform translation of APLX statements into Dyalog equivalents, including references to the emulation functions described below:

**Emulations of APLX Features:** The file APLX.dyalog defines a Dyalog namespace containing emulations for APLX primitives and system functions that are different or do not exist at all in Dyalog APL.

**Test Cases:** The file TestAPLX.dyalog contains a collection of tests which put the emulation through its paces. If you have problems with any emulated features, a **VERY GOOD THING TO DO** is to contribute a failing test which someone will hopefully fix! 

## Getting Set Up
All the materials developed in this process are available as open source tools via github, and can be found at [http://github.com/Dyalog/aplx](). The easiest way to get hold of a local copy is to download the zip package [https://github.com/Dyalog/aplx/archive/master.zip](), if you want to participate actively or be able to easily view the revision history as new versions are developed, we suggest that you install a GUI front-end for git, for example SourceTree (which is used within the Dyalog development team) or git gui, and clone the repository.
Once you have the materials downloaded (for example to a folder called ```/Users/mkrom/aplx```), you have a few choices:

*	```]load``` the APLX namespace and set ```⎕PATH←'#.APLX'```
*	“disperse” the individual functions into the root of your workspac
*	If desired, create APLX cover-functions [more to come]

## Running the Tests
