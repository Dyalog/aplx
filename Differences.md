# Differences between APLX and Dyalog APL
Although both APL systems are variations on IBM APL2, and most computational code will work unchanged or can be translated automatically. At the other end of the spectrum, user interface code and code which uses object oriented features of APLX may require a complete rewrite of parts of an application. The differences can be broken down as follows:

* Differences in primitives and system functions or variables for which translations and emulations are readily available, such as ```⎕EXPORT```
*	Core language differences which are difficult to translate automatically, like binding strength differences and some object oriented features.
*	Complex components like ```⎕WI```, ```⎕CHART```, which will require some rewriting of code under Windows

In the following, issues are categorised by estimated difficulty: 

(1) refers to differences which are covered by the provided translation / emulation tools. If xfrpc is used to export APLX code, code will be converted to call emulation functions as appropriate.

(2) identifies differences which will probably require some limited re-coding

(3) means that if this feature is used in the APLX application, significant rewrites of code which uses it may be required.

**NB:** This table is under revision and is likely to change as we understand the differences better. Some differences may be re-categorised as we add emulation software. Input to help prioritise this work is very welcome!

###Emulations
All the emulations can be found in the file APLX.dyalog in the repository:

####System Functions which are Identical

      ⎕CR ⎕D ⎕DL 

####Complete or Nearly Complete System Functions

(For example, APLX.∆a emulates ⎕a)

      ∆a    ∆AF  ∆AI  ∆AV   ∆B     ∆BOX   ∆C    ∆CALL  ∆DBR  ∆DISPLAY  
      ∆DR   ∆EA  ∆EM  ∆ERM  ∆EXPORT  
      ∆FI    ∆GETCLASS  ∆HOST
      ∆I    ∆IMPORT   ∆L    ∆LIB   ∆M   ∆MOUNT  ∆N  
      ∆NAPPEND  ∆NERASE  ∆NREAD  ∆NREPLACE  ∆NWRITE   
      ∆OV   ∆R  ∆SS ∆TIME  ∆UP   ∆VI    ∆W   

####Functions Used to Deal with Translation of Primitives

      ∆EQ_ ∆LSHOE ∆RSHOE

#####Known Limitations
* Native file functions to not handle explicit byte swapping, 64-bit integers or single-precision floats
* Import/Export do not handle the ```slk``` format
* ```∆CALL```	(only .Net calls)
* ```∆ERX```	It is not really possible to fully emulate ⎕ERX
* ```∆FDROP (⍗)``` Can only drop the last component
* ```∆FHOLD (⍐)``` Monadic only (⎕FRESIZE) 
* ```∆FREAD (⍇)``` Monadic only, and passnumbers are ignored
* ```∆FWRITE (⍈)``` User ID and passno ignored
* ```∆MOUNT``` Beginning of support
* ```∆GETCLASS``` Microsoft.NET only 
* ```∆HOST``` No timeout, and the format of results is nested 
* ```∆NERROR``` Error message texts will be different, and sometimes reflect other recent errors not related to native files 
* ```∆SS``` is work in progress, we are not 100% sure we have all the cases covered, especially not regular expression cases
* 

###Currently Missing

⎕AT Object Attributes

⎕CC Console Control

⎕CS Similar functionality to ⎕ML, but completely different

⎕CHART	this might be replaced by ⎕SE.UCMD 'chart …'

⎕CL	can be replaced by  (⍬⍴⎕LC)

⎕CLASS	has 2 nested vectors in Dyalog

⎕CLASSES (⎕NL 9) provides similar functionality in Dyalog APL

⎕CONF	has no equivalent in Dyalog

⎕DR Similar but the exact functionality is different

⎕EDIT Similar but not identica to ⎕ED

⎕FC	is used to control dyadic format (⍕) in APLX. There is no equivalent in Dyalog.

⎕HC	Hard Copy, no such equivalent in Dyalog

⎕ID		System ID number, no such thing in Dyalog

⎕MC Dyalog has full Unicode support and has no concept of a "Missing Character"

⎕SQL must be replaced by calls to the functions in distributed workspace SQAPL

⎕WI

⎕OV: APLX "overlays" are a mechanism for storing names and definitions accessible through the system function ⎕OV. Dyalog namespaces are significantly more powerful.

⎕TF	produces a simple string of the representation of a function or variable in APLX; user commands can be used for this in Dyalog APL.

###Other Differences Worth Mentioning

(1) ⎕CT	is 1E¯13 by default in APLX instead of 1e¯14 in Dyalog

(1)* ⎕EDIT	is ⎕ED in Dyalog but APLX allows you to specify the type using a left argument 

(2) ⎕EVAL: Dyalog has an R interface in RConnect.dws, but it is completely different from the APLX functionality

(1) ⎕EX	APLX reports if the name has been erased, Dyalog reports if the name is available AFTER attempting erasure, not a big deal

(1)* ⎕HOST: ∆HOST is not able to emulate the timeout (left argument) feature of APLX

(1)* ⎕N	is UCS 1 in APLX. Dyalog has its own ⎕NULL. APLX does have a ⎕NULL but it is related to the Null Object (OO)

(1) ⎕NA	is similar to Dyalog

(2) ⎕PROFILE is similar to Dyalog 

(1) ⎕RL	there is only one Random Number Generator in APLX but it accepts arguments up to 2*1024

(2) ⎕SETUP	is used to set or query various parameters for the interface with external architectures such as .Net (e.g. Using)

(1) ⎕SI		is a simple vector in APLX

(1) ⎕STOP/TRACE accepts 0 as left argument to REMOVE control, not set a stop on line 0 as in Dyalog

(1) ⎕SYMB Dyalog has no limit on the symbol table so doesn't have this concept

(1) ⎕TC	also ⎕I , ⎕TCBEL, ⎕TCBS, ⎕TCDEL, ⎕TCESC, ⎕HT (⎕T), ⎕FF, ⎕ LF (⎕L), ⎕NL (⎕R) and ⎕NUL. Those are individual characters that may have a special effect in APLX


(2) ⎕TR	translates text between APLX and the rest of the world
(2) ⎕TT	is Terminal Type in APLX
(3)* ⎕UL	is the number of APLX tasks running
(1) ⎕WSSIZE	is ws TOTAL size in APLX



###Component Files

####Library Numbers

(2) Dyalog APL has no concept of library numbers; a number at the beginning of a file name will be interpreted as part of the name.

(2) APLX also uses library numbers, associating a positive integer to a folder using ⎕MOUNT. There is no equivalent in Dyalog.

(2) In APLX, ⎕FLIB also accepts a library number (integer) as argument. This represents a row in the MOUNT table. Only files which end in the AQF extension will appear in the result.

####Other Component File Differences
(2) ```⎕FDUP``` in APLX is ```⎕FCOPY``` in Dyalog. The access code is different (16384 vs 4096).

(2) When creating a file Dyalog adds the extension ```.dcf``` if no extension is provided.

(2) ```⎕FRDCI``` reports the time when the component was written in seconds since 2000/1/1. Dyalog reports it in 1/60th of a second since 1970/1/1.

(2) ```⎕FRENAME``` accepts a filename as right argument under APLX, Dyalog doesn't.

(2) ```⎕FSIZE``` returns 5 elements in APLX while Dyalog reports 4. The 4th element may be 0 in APLX meaning "no limit"; Dyalog implements no limits. In APLX, the 5th element is the unused space in the file.

(2) ```⎕FRDFI```, ```⎕FCSIZE```, ```⎕FWRITE``` and ```⎕FDELETE``` do not exist in Dyalog APL (and are not currently emulated).

###Native files

(1) ⎕LIB, ⎕NWRITE, ⎕NAPPEND, ⎕NREPLACE and ⎕NREAD have emulation functions which allow the use of nearly all APLX type numbers. However, ∆NREAD cannot read a specific number of elements counts for UTF-8 and UTF-16 translations.

(2) ```⎕NCREATE``` does not support a 2nd element in the right argument and tie numbers must be negative in Dyalog

(2) ```⎕NERROR``` has no equivalent in Dyalog; ∆NERROR provides similar functionality but the error messages will be different.

(2) ```⎕NLOCK``` is similar to Dyalog

(3) ```⎕NTYPE``` has no equivalent in Dyalog (but is probably not significant)

###Control structures
There are some significant differences in control structures:

(1)  APLX ```:Try``` is ```:Trap``` in Dyalog APL, and ```:CatchAll``` is ```:Else``` (converted)

(3)  APLX ```:CatchIf``` takes a Boolean argument. There is no catching on a specific error (number). Typically a programmer will use :CatchIf  11=↑⎕LER

(3) ```:Repeat``` accepts a number of repetitions in APLX, but not in Dyalog APL

(3) ```:Leave``` may take a label as argument in APLX, not in Dyalog APL

###Classes

Unfortunately, the Object Oriented functionality of the two systems are very different, although many capabilities are presented in both systems.

Dyalog only supports APL and .Net classes.

Close to Dyalog:

(2) ⎕GETCLASS	: for APL and .Net only you can use execute (⍎)
(2) ⎕CLASSNAME: format (⍕) will display a string of the class name.

Not supported:
(3) ⎕DS, ⎕IC, ⎕MIXIN, ⎕UNMIX and most other OO related functions.

Other System functions possibly presenting problems
Function 	Comment
