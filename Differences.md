# Differences between APLX and Dyalog APL
Both APL systems are variations on IBM APL2, and most computational code will work unchanged, with automatic translation, or minor manual changes. This repository contains tools to perform automated translation and provide emulations of frequently-used features that are missing from Dyalog APL.

This document lists the emulations provided, the limitations that we are currently aware of, and a discussion of differences that we are unlikely to address unless someone find a way to motivate us. It is very much work in progress; and if you find that there are features that you desperately need, please get in touch to discuss. Contributions of enhancements or additions to the emulations, or simply failing test cases, are all very welcome.

Fundamental Differences
In addition to the emulations and automated transformations, you application may use features of APLX which are not supported at all in Dyalog APL, and which we are not currently planning to work on:

* The ```⎕WI``` user interface tool is not provided, and Dyalog has no plans to work on this, as the UI paradigm that it represents is fundamentally obsolete (this is a major part of the reason why APLX was discontinued). Contact Dyalog to discuss how you can provide alternative user interfaces in Dyalog APL using WPF, HTML/Javascript or other technologies.
* ```⎕CHART``` is not emulated: Dyalog provides SharpPlot and interfaces to Javascript-based charting as alternatives.
* Object Oriented features in Dyalog are more similar to OO in languages like C# and Java. There is currently no support for external Java and Ruby objects.
* Dyalog APL essentially provides the same native and component file functionality, but there is no concept of library numbers, and Dyalog APL insists that component files have positive tie numbers, while native file ties are negative. See the separate sections below for further discussion.
* The R interface is significantly different but should provide the same capabilities.
* There are a handful of core language differences which are difficult to translate automatically and will probably require manual recoding:
   * Brackets bind differently: ```A[2]B[1]``` is ```(A[2])(B[1])``` in APLX, but ```((A[2])B)[1]``` in Dyalog APL.
   * Slashes (```/``` and ```⌿```) are strictly operators in APLX, but in Dyalog APL they are functions when there is an array on the left. This gives different results when slashes are combined with other operators. For example ```1 0 1/¨⍳3``` returns ```(1 1)(2 2)(3 3)``` in APLX and ```(,1)⍬(,3)``` in Dyalog APL. The equivalent expression in Dyalog APL would be ```1 0 1∘/¨⍳3```.
   * In Dyalog APL, Monadic ```↑``` is *mix*, ```⊃``` is *first*, and ```≡``` (*depth*) works slightly differently from APLX, unless ```⎕ML>1```.
   * ```⍎``` accepts system commands (```X←⍎')SYMBOLS'```) in APLX but not in Dyalog APL. System functions and I-Beams can provide the same functionality but will need recoding. In this particular case, just delete the code - Dyalog APL has a dynamic Symbol Table and you do not need to worry about how big it is.
   * Monadic Left Tack (```⊣```) returns a shy result of ```0 0⍴0``` in APLX, in Dyalog it returns the right argument unchanged (there is insufficient space to explain why this is better in this document). ```{}``` can be used to "sink" a result.
   * Partitioned enclose (dyadic ```⊂```), works differently from APLX unless ⎕ML←3.
   * Dyalog APL does not support ```⍺``` picture formatting, and ```⎕FC``` cannot be used to control formatting.
   * ```⍞``` works differently: In APLX the prompt (if any) is replaced according to ```⎕PR```
   * ```⎕RL``` is richer in Dyalog APL, allowing the selection of several different random number generators. In Dyalog APL, ⎕RL←0 generates a "truly" random seed. APLX code should work unchanged but seed-setting functions should be examined and random sequences may be different
   * Note that the default comparison tolerance in (```⎕CT```) in APLX is 1E¯13, but 1e¯14 in Dyalog APL, which could concievably cause computational differences; you may need to set it explicitly.
   * APLX variable names can contain a high minus (```¯```), this not allowed in Dyalog APL
   * Dyalog APL does not have 64-bit integers, even in the 64-bit versions.
   * Dyalog APL does not allow "undefined" assignments to system variables (```⎕WA←3```).
   * There are some differences in Control Structures (detailed in a separate section in this document).

###Control structures
There are some significant differences in control structures:

* APLX ```:Try``` is ```:Trap``` in Dyalog APL, and ```:CatchAll``` is ```:Else``` (converted)
* APLX ```:CatchIf``` takes a Boolean argument. There is no catching on a specific error (number). Typically a programmer will use :CatchIf  11=↑⎕LER
* ```:Repeat``` accepts a number of repetitions in APLX, but not in Dyalog APL
* ```:Leave``` may take a label as argument in APLX, not in Dyalog APL

###Component Files
Dyalog APL has no concept of numeric libraries, and component file tie numbers must be positive. The following differences are worth noting, many of which could be handled by additional emulation functions:

* ```⎕FDUP``` in APLX is ```⎕FCOPY``` in Dyalog. The access code is different (16384 vs 4096).
* When creating a file Dyalog adds the extension ```.dcf``` if no extension is provided.
*```⎕FRDCI``` reports the time when the component was written in seconds since 2000/1/1. Dyalog reports it in 1/60th of a second since 1970/1/1
* ```⎕FRENAME``` accepts a filename as right argument under APLX, Dyalog doesn't.
* ```⎕FSIZE``` returns 5 elements in APLX while Dyalog reports 4. The 4th element may be 0 in APLX meaning "no limit". In APLX, the 5th element is the unused space in the file.
* ```⎕FRDFI```, ```⎕FCSIZE```, ```⎕FWRITE``` and ```⎕FDELETE``` do not exist in Dyalog APL

###Native files
Note that an update to Dyalog 15.0 was released at the beginning of August, with support for ¯1 in the arguments to ```⎕NREPACE (used by ∆NWRITE)``` (position of ¯1 means write to current position) and ```⎕NREAD``` (count of ¯1 means read to end of file).

* The emulation functions for ```⎕NWRITE, ⎕NAPPEND, ⎕NREPLACE, ⎕NREAD``` support nearly all APLX type numbers. However, ∆NREAD cannot read a specific number of elements counts for variable-length encodings (UTF-8 and UTF-16).
* ```⎕NCREATE``` does not support a 2nd element (permissions) in the right argument
* ```∆NERROR``` attempts to emulate ```⎕NERROR```, but the error messages will not be identical, and Native File errors are not separated from other errors.

###Classes

Unfortunately, the Object Oriented functionality of the two systems are very different, although many capabilities are presented in both systems.

Dyalog only supports internal classes defined in APL and .Net classes, and the following emulations kind of work:

* ⎕GETCLASS	: for APL and .Net only you can use execute (⍎)
* ⎕CLASSNAME: format (⍕) will display a string of the class name.

Most OO related functions are not supported:

⎕DS, ⎕IC, ⎕MIXIN, ⎕UNMIX, ⎕RC, ⎕RECLASS, ⎕REPARENT.

## Emulations

After all the bad news: fairly decent emulations are provided for a large number of the most frequently used system functions. These functions have names beginning with ∆, in the APLX namespace. For example, ```APLX.∆a``` emulates ```⎕a``` (the lowercase letters from a-z):

      ∆a   ∆AF  ∆AI  ∆AV   ∆B   ∆BOX  ∆C         ∆CALL  
      ∆DBR      ∆DISPLAY   ∆DR  ∆EA   ∆EM        ∆ERM    
      ∆EXPORT   ∆FI        ∆GETCLASS  ∆HOST      ∆I
      ∆IMPORT    ∆L  ∆LIB  ∆M         ∆N  
      ∆NAPPEND  ∆NERASE    ∆NREAD     ∆NREPLACE  ∆NWRITE   
      ∆OV   ∆R  ∆SS  ∆TIME ∆VI  ∆W    ∆WSSIZE

### Replacements for ML-Dependend Primitives

Emulation functions are provided for the primitives which can be brought to behave the same way as APLX by setting ⎕ML. This allows a migrated application to immeduately run with the default Dyalog Migration Level of 1, and for the use of these functions to be replaced over time. 

      ∆EQ_ (≡), ∆LSHOE (⊂), ∆RSHOE (⊃), ∆UP, (↑)

### Emulation Not Required

We currently believe that the following system functions do not need emulation (in the vast majority of uses):

      ⎕CR ⎕D ⎕DL ⎕FX ⎕NC ⎕NCREATE ⎕RESIZE ⎕SIZE ⎕NTIE 
      ⎕NULL ⎕PFKEY ⎕THIS ⎕STOP ⎕TRACE ⎕TS ⎕UCS ⎕A

### Known Limitations of Emulations
* Native file functions to not handle conversion codes for explicit byte swapping, 64-bit integers or single-precision (4-byte) floats
* Import/Export do not handle the ```slk``` format
* ```∆CALL``` only handles Microsoft.Net
* ```∆ERX``` This emulation is very partial; it is not really possible to fully emulate ⎕ERX
* ```∆FDROP (⍗)``` Can only drop the last component of a file
* ```∆FHOLD (⍐)``` Monadic use only (⎕FRESIZE) 
* ```∆FREAD (⍇)``` Monadic use only, and passnumbers are ignored
* ```∆FWRITE (⍈)``` User ID and passno ignored
* ```∆MOUNT``` There is no real support for library numbers
* ```∆GETCLASS``` Microsoft.NET only 
* ```∆HOST``` No timeout, and the format of results is nested 
* ```∆NERROR``` Error message texts will be different, and sometimes reflect other recent errors not related to native files 
* ```∆SS``` will hopefully become complete, but is work in progress, we are not 100% sure we have all the cases covered, especially not regular expression cases

##Other Issues

This is mostly a list of features which are not currently emulated, and comments on differences between system functions in the two systems which have not been discussed already. Please contact us to help prioritise further work on emulations, if there is something you really need:

* ⎕AT Object Attributes
* ⎕CC Console Control
* ⎕CS Provides similar functionality to ⎕ML, but completely different and mostly(?) irrelevant
* ⎕CL	can be replaced by  (⍬⍴⎕LC)
* ⎕CLASS has 2 nested vectors in Dyalog
* ⎕CLASSES is missung but (⎕NL 9) provides similar functionality in Dyalog APL
* ⎕CONF	has no equivalent in Dyalog
* ⎕DR Similar but the exact functionality is different
* ⎕EDIT Similar but not identical to Dyalog's ⎕ED
* ⎕EVAL No direct support in Dyalog APL, but Microsoft.Net and R objects are easy to access using other means.
* ⎕EX: APLX reports whether the name was erased, Dyalog APL whether it is now free for use.
* ⎕HC Hard Copy
* ⎕ID System ID number is an unknown concept in Dyalog APL
* ⎕MC - but since Dyalog has full Unicode support, there is no "Missing Character"
* ⎕NA is similar but has some differences, especially in character type conversions
* ⎕NTYPE is MacOS specific in APLX and not supported at all in Dyalog APL
* ⎕PFKEY is similar but not supported on all platforms in Dyalog APL.
* ⎕PROFILE is similar but different.
* ⎕SI could probably be emulated if there is sufficient demand (see ⎕SI, ⎕LC & ⎕STACK)
* ⎕SQL must be replaced by calls to the functions in distributed workspace SQAPL
* ⎕SV* Shared variables exist but are considered obsolete in Dyalog APL, and are not used for APs (which are also considered obsolete).
* ⎕OV: Some emulation is provided through ∆OV, but Dyalog namespaces are significantly more powerful.
* ⎕STOP & ⎕TRACE with a left argument of zero clear all stops in APLX, but set a stop/trace on line [0] in Dyalog APL (emulation would be possible).
* ⎕SYMB Dyalog APL has no symbol table limitations so this function is unnecessary
* ⎕TC* (BEL, BS, DEL, ESC, ...) are not provided (would be easy to emulate). The effect of displaying control characters in the session may differ. For example, ⎕TCBEL will produce a audible sound in APLX but not in Dyalog APL (but there are other ways to produce sound).
* ⎕TF	produces a simple string of the representation of a function or variable in APLX; user commands can be used for this in Dyalog APL.
* ⎕TR Dyalog is a Unicode system so no translation of character data is done when sharing it with the outside world.
* ⎕TT terminal Type - Does not exist in Dyalog APL.
* ⎕SETUP does not exist but many of the facilities provided have simple alternatives, at least for Microsoft.NET (Using, ByRef, Version)
* ⎕UL User Load - not supported