:Namespace convertionTools
⍝ === VARIABLES ===

L←⎕av[3+⎕io]
_←⍬
_,←'This namespace, "convertionTools", is used to find'
_,←L,'and solve some possible conversion problems.'
_,←L
_,←L,'At the moment it can only find the use of [brackets] in vectors.'
_,←L,'APLX uses A B[i] to mean A (B[i]) in Dyalog.'
_,←L,'When code from APLX is transferred to Dyalog no such translation is '
_,←L,'usually performed and this tool here can help with that.'
_,←L
_,←L,'The program "findBrackets" accepts the name of a program as argument'
_,←L,'and shows where problems are likely to exist.'
_,←L
_,←L,'For example, if line 23 of program "Calc" reads'
_,←L
_,←L,'[23] A+B C[i]'
_,←L
_,←L,'then the tool will show'
_,←L
_,←L,'    findBrackets ''Calc'''
_,←L
_,←L,'    ∇ #.Calc (1 found)'
_,←L,'[23] A+B C[i]'
_,←L,'       ^^^^^^'
_,←L,7⍴' '
_,←L,'If an empty list is given to "findBrackets" then all programs in the'
_,←L,'workspace will be searched. '
_,←L
_,←L,'Note that overlapping matches are not found. If line 23 of the preceding'
_,←L,'example were '
_,←L
_,←L,'[23] A+B C[i] D[j]'
_,←L
_,←L,'then only '
_,←L
_,←L,'[23] A+B C[i] D[j]'
_,←L,'       ^^^^^^'
_,←L,'would be found and shown.'
_,←L,'Also, text and comments are NOT searched but it reports problematic lines'
_,←L,'in text following ∆EA:'
_,←L
_,←L,'[24] '''' ∆EA ''A+B C[i]''     '
_,←L,'               ^^^^^^'
_,←L
_,←L,'If replacement is required the program "addParens" works the same way: it'
_,←L,'accepts the name of a program or an empty string to mean "all programs". '
_,←L,'But it only changes code, not code in text following ∆EA for example.'
_,←L
_,←L,'    addParens ''Calc'''
_,←L
_,←L,'    ∇ #.Calc (1 found)'
_,←L,'[23] A+B (C[i])'
_,←L,'         ^^^^^^'
_,←L,'1 replacement made.  '
_,←L
_,←L,'If the line has overlapping matches like'
_,←L
_,←L,'    findBrackets''Calc'''
_,←L
_,←L,'    ∇ #.Calc (1 found)                                       '
_,←L,'[23]  A+B C[i] D[j]                                           '
_,←L,'        ∧∧∧∧∧∧'
_,←L
_,←L,'then "addParens" will do them all'
_,←L
_,←L,'    addParens ''Calc'''
_,←L
_,←L,'    ∇ #.Calc (1 found)'
_,←L,'[23] A+B (C[i])D[j]'
_,←L,'         ^^^^^^   '
_,←L
_,←L,'    ∇ #.Calc (1 found)'
_,←L,'[23] A+B (C[i])(D[j])'
_,←L,'               ^^^^^^'
_,←L
_,←L
_,←L
_,←L,'NOTE:'
_,←L
_,←L,'For these tools to work you need at least V15 and user commands version 2.12'
_,←L,'To find out which version you are running type'
_,←L
_,←L,'    ]version '
_,←L
_,←L,'If your version is not good enough you can do '
_,←L
_,←L,'    ]uupdate '
_,←L
_,←L,'To update your tools.'
_,←L
_,←L,'DanB 2016'
_,←L
Describe←_

RBV←'''((?(DEFINE)(?<S>(?>''''(''''''''|[^''''])*''''))(?<noP>(?>(((&S)|[^()])*)))(?<noB>(?>(((&S)|[^][])*)))(?<P>\((?&noP)?(?&P)?(?&noP)?\))(?<B>\[(?&noB)?(?&B)?(?&noB)?\]))(?<item>((?>⍵)|(?>⍺)|(?&S)|(?&P))\s*(?&B)??) *)((?&item) *(?&B))'''

⎕ex¨'L_'

⍝ === End of variables definition ===

(⎕IO ⎕ML ⎕WX)←1 1 3

∇ addParens arg;exp
⍝ Add parentheses around the 1st element with brackets in a vector
 exp←RBV,(1+~0∊⍴arg)⊃' -class=3'{⍺ ⍵}' -object=',arg
 exp←'locate -pattern -show -exclude=ct  -callback=#.convertionTools.prune ',exp,' -replace "\1 (\G)"'
 :Repeat ⋄ :Until '0'=1↑⎕RSI[⎕IO]⎕SE.UCMD exp
∇

∇ findBrackets arg;exp
⍝ Find where bracketed expressions involving vectors are found
 ⎕←'* List of places where parentheses would be needed in code only:'
 exp←RBV,(1+~0∊⍴arg)⊃' -class=3'{⍺ ⍵}' -object=',arg
 ⎕RSI[⎕IO]⎕SE.UCMD'locate -pattern -show -exclude=ct -callback=#.convertionTools.prune ',exp
 ⎕←2 1⍴''
 ⎕←'* List of places where parentheses would be needed after ∆EA:'
 exp←'''∆EA''''.*?\K',1↓exp
 ⎕RSI[⎕IO]⎕SE.UCMD'locate -pattern -show -exclude=c -callback=#.convertionTools.prune ',exp
∇

∇ r←prune exp;noun
 :If r←3≠#.⎕NC noun←(∧\exp∊⎕A,'abcdefghijklmnopqrstuvwxyz∆⍙',⎕D)/exp
 :AndIf 9=⎕NC'#.APLX'
     r←~(#.APLX.⎕NC noun)∊3 4
 :EndIf
∇

:EndNamespace 
