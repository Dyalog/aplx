# Differences between APLX and Dyalog APL
Although both APL systems are variations on IBM APL2, and most computational code will work unchanged or can be translated automatically. At the other end of the spectrum, user interface code and code which uses object oriented features of APLX may require a complete rewrite of parts of an application. The differences can be broken down as follows:

* Differences in primitives and system functions or variables for which translations and emulations are readily available, such as ⎕EXPORT
*	Core language differences which are difficult to translate automatically, like binding strength differences and some object oriented features.
*	Complex components like ⎕WI, ⎕CHART, which will require some rewriting of code under Windows, Dyalog adds the extension DCF if none exists. It also ignores any (library) number before the name and assumes it IS part of the name.

:bang: APLX also uses library numbers, associating a positive integer to a folder using ⎕MOUNT. There is no equivalent in Dyalog.
:bang: ⎕FDUP is ⎕FCOPY in Dyalog. The access code is different (16384 vs 4096).
:bang: ⎕FLIB also accepts a library number (integer) as argument. This represents a row in the MOUNT table. Only files which end in the AQF extension will appear in the list.
(2) ⎕FRDCI reports the time when the component was written in seconds since 2000/1/1. Dyalog reports it in 1/60th of a second since 1970/1/1.
(2) ⎕FRDFI similarly reports timestamps. In APLX it is a 4x2 matrix of WHO, WHEN of creation/reserved/reserved/update . Dyalog reports creation/reserved/access matrix/reserved/update.
(2) ⎕FCSIZE Dyalog does not have the equivalent of this function which reports the size of an object on file and in the workspace.
(2) ⎕FRENAME accepts a filename as right argument under APLX, Dyalog doesn't.
(2) ⎕FSIZE reports 5 elements in APLX while Dyalog reports 4. The 4th element may be 0 in APLX meaning "no limit". Not so in Dyalog. The 5th element is the unused space in the file.
(2) APLX has 2 file functions not defined in Dyalog: ⎕FWRITE and ⎕FDELETE which allow you to insert and delete specific components.
Native files
(2) ⎕LIB is pretty much the same as ⎕NINFO⍠1 in Dyalog, you need to supply the folder name only, not the \* after.
(2) ⎕NCREATE	does not support a 2nd element in the right argument and tie numbers must be negative in Dyalog
(3) ⎕NERROR has no equivalent in Dyalog∆∇⍺∆∇⌈_⍺⍺⌈⌈⌈⍺
(2) ⎕NLOCK is similar to Dyalog
(3) ⎕NTYPE has no equivalent in Dyalog
(2)* ⎕NWRITE is very much like ⎕NREPLACE
(1) ⎕NREAD cannot properly handle element counts for UTF translations.
(1) NWRITE to current position (¯1) requires a copy of Dyalog APL from late July.
APLX Control structures
(2) :repeat accepts a number while Dyalog does not
(1)* :try is :trap in Dyalog
(2):try and :endtry cannot appear on the same line
(1)* :catchall is :else
(2) :catchif takes a Boolean argument. There is no catching on a specific error (number). Typically a programmer will use :CatchIf  11=↑⎕LER
(2) :leave may take a label as argument 
Classes
Classes (OO) are very different in Dyalog. Any implementation will not work as is.
Dyalog only supports APL and .Net classes (no Ruby or Java)
There is no NULL object in Dyalog although there is a ⎕NULL.
Close to Dyalog:
(2) ⎕GETCLASS	: for APL and .Net only you can use execute (⍎)
(2) ⎕CLASSNAME: format (⍕) will display a string of the class name.
Not supported:
(3) ⎕DS, ⎕IC, ⎕MIXIN, ⎕UNMIX and most other OO related functions.
Other System functions possibly presenting problems
Function 	Comment
(1)* ⎕a		lowercase Alphabet, Dyalog only has ⎕A
(1)* ⎕AI		has 7 elements, Dyalog cannot supply meaningful values for the last 3 ones. [1] is 1000 by default whereas it is 0 on Dyalog
(2)* ⎕CALL	only .Net can be supported
(2) ⎕C		this is akin to ⎕ARBIN/ARBOUT in Dyalog
(2) ⎕CHART	this might be replaced by ⎕SE.UCMD 'chart …'
(1)* ⎕CL	can be replaced by  (⍬⍴⎕LC)
(2) ⎕CLASS	has 2 nested vectors in Dyalog
(3) ⎕CONF	has no equivalent in Dyalog
(3) ⎕C		has no equivalent in Dyalog but is used for old APL.68000 workspaces so is unlikely to cause problems
(1) ⎕CT	is 1E¯13 by default in APLX instead of 1e¯14 in Dyalog
(1)* ⎕EDIT	is ⎕ED in Dyalog but APLX allows you to specify the type using a left argument 
(2) ⎕EVAL	Dyalog can only talk to R and is very different
(1) ⎕EX	APLX reports if the name has been erased, Dyalog reports if the name is available AFTER attempting erasure, not a big deal
(3) ⎕FC	is used in APLX when format (⍕) is used dyadically. No equivalent in Dyalog.
(1)* ⎕FI/VI	is like ⎕VFI in Dyalog
(3) ⎕HC	Hard Copy, no such equivalent in Dyalog
(1)* ⎕HOST	there is no way to use the timeout (left argument) feature of APLX in Dyalog
(3) ⎕ID		System ID number, no such thing in Dyalog
(2)* ⎕IMPORT/EXPORT are missing in Dyalog. All but 'slk' can be emulated fairly easily
(1)* ⎕M/W	are character matrices of Months and Weekdays unavailable in Dyalog
(2) ⎕MC	is Missing Character for ⎕UCS and has no equivalent in Dyalog
(1)* ⎕N	is UCS 1 in APLX. Dyalog has its own ⎕NULL. APLX does have a ⎕NULL but it is related to the Null Object (OO)
(1) ⎕NA	is very similar to Dyalog
(1)* ⎕OV	is like static namespaces in Dyalog
(2) ⎕PROFILE	is similar to Dyalog 
(1) ⎕RL	there is only one Random Number Generator in APLX but it accepts arguments up to 2*1024
(2) ⎕SETUP	is used to set or query various parameters for the interface with external architectures such as .Net (e.g. Using)
(1) ⎕SI		is a simple vector in APLX
(2) ⎕SQL	has no equivalent in Dyalog. Ws SQAPL is the closest thing Dyalog has
(2)* ⎕SS	is a function akin to ⎕S/⎕R in Dyalog
(1) ⎕STOP/TRACE accepts 0 as left argument to REMOVE control, not set a stop on line 0 as in Dyalog
(1) ⎕SYMB	Dyalog has no limit on the symbol table so doesn't have this concept
(1) ⎕TC	also ⎕I , ⎕TCBEL, ⎕TCBS, ⎕ TCDEL, ⎕TCESC, ⎕HT (⎕T), ⎕FF, ⎕ LF (⎕L), ⎕NL (⎕R) and ⎕NUL. Those are individual characters that may have a special effect in APLX
(2) ⎕TF	produces a simple string of the representation of a function or variable in APLX
(1)* ⎕TIME	reports the time in APLX
(2) ⎕TR	translates text between APLX and the rest of the world
(2) ⎕TT	is Terminal Type in APLX
(3)* ⎕UL	is the number of APLX tasks running
(1) ⎕WSSIZE	is ws TOTAL size in APLX

