:Require file://./APLX.dyalog

:Namespace TestAPLX     ⍝ V1.01
 ⎕PATH←'#.APLX' 

∇ {tests} Run DEBUG;⎕IO;⎕ML;FOLDER;fn;fns;z;m
⍝ Test the APLX emulation functions   

 ⎕IO←1 ⋄ ⎕ML←1   
 ⎕NUNTIE ⎕NNUMS
 ⎕FUNTIE ⎕FNUMS
 #.APLX.⎕EX '⍙MOUNTS'

 FOLDER←{(1-⌊/(⌽⍵)⍳'\/')↓⍵}{⊃⍵[⍵[;1]⍳⎕THIS;4]}↑5177⌶⍬ ⍝ find loaded files' location

 fns←'T' ⎕NL ¯3 
 :If 2=⎕NC 'tests'
    :If (⊂tests)∊'list' '?' ⋄ ⎕←5↓¨fns ⋄ →0 ⋄ :EndIf  
    tests←'Test_'∘,¨{1=≡⍵:,⊂⍵ ⋄ ⍵},tests
    :If ∨/m←~tests∊fns
        ('Unknown test(s): ',,⍕m/tests) ⎕SIGNAL 11
    :EndIf
    fns←fns∩tests
 :EndIf

 :For fn :In fns
     ⍎fn
 :EndFor

 :If 0≠≢z←{(~1∊¨⍵⍷¨,/⎕VR¨fns)/⍵}'∆'#.APLX.⎕NL ¯3
     ⎕←'NB: ',(⍕≢z),' functions not tested:'
     ⎕←z
     ⎕←' '
 :EndIf

 ⎕←'APLX tests completed'
∇

∇Test_Chars

 assert ∆a≡⎕UCS 96+⍳26
 assert 105086=+/⎕UCS ∆C
 assert 241=≢∪∆AV
 assert 225 97 65≡∆AF'aA⍺'

 assert 1 8 10 13≡⎕UCS ∆N ∆B ∆L ∆R     

 assert 'SMTWTFS'≡∆W[;1]
 assert 'JFMAMJJASOND'≡∆M[;1]

 assert(2 3⍴'AB CDE')≡∆BOX'AB CDE'
 assert(2 3⍴'AB.CDE')≡'/.'∆BOX'AB/CDE'

 assert'A B C'≡∆DBR'  A  B  C '

∇

∇Test_Errors_Traps;⎕trap

 assert 4≡'42'∆EA'2+2⊣∆a'
 assert 42≡'42⊣∆a'∆EA'1÷0'

 assert(↑⎕DM)≡∆EM  
 assert(¯1↓⊃,/⎕DM,¨⎕UCS 13)≡∆ERM 

∇
 
∇Test_Misc
 
 assert '(System.DateTime)'≡⍕'.net' ∆GETCLASS 'System.DateTime'

 assert ∆WSSIZE=2000⌶16

 assert 1 0 1≡∆VI'1 E 2'
 assert 1 0 2≡∆FI'1 E 2'

 assert 5 8 14 17≡{(⍵∊'-.')/⍳⍴⍵}∆TIME

 assert 3 1≡+/'→∊'∘.=,∆DISPLAY(1 2 3)'ABC' 
 
 assert 7∊⍴∆AI

 assert 14=≢(⍕'.net'∆CALL'System.DateTime.Now')∩⎕D

 assert 2≤+/'<DIR>'⍷∆HOST'dir'
 
 text←'Quack Quack Quack!'
 assert 2∊⍴ns.⎕nl-2 3⊣ns←0 ∆OV +z←↑'assert' 'text' 
 assert z≡3 ∆OV ns   
 
 assert (⍳7)≡∆DR¨ (0 1 0 1) 2 3.14 'A' (⎕NS '') ('A' 1) # 
 
 {}∆ERX L10 
 assert ~0∊⍴⎕trap
 ÷0
 L10:{}∆ERX 0
 assert 0∊⍴⎕trap   
 
 assert 0=∆EQ_ 6
 assert 2=∆EQ_ 'dsa' 3
 assert 'dsa' ∆EQ_'dsa'
 assert (⊂'dsa')≡∆LSHOE'dsa'
 assert 'dsa' 'dsa' ≡1 1 1 0 1 1 1 ∆LSHOE'dsa dsa'
 assert 2≡2 ∆RSHOE 'dsa' 2
 assert (2 3⍴'dsa')≡∆RSHOE 'dsa' 'dsa'
 assert 3≡∆UP 3 4
 assert 1 2≡2 ∆UP ⍳6

 new←0=#.APLX.⎕nc'⍙MOUNT'
 assert new≤0∊⍴∆MOUNT'' ⍝ this could be false if tests are run more than once. 'new' solves this
 {}∆MOUNT 'dsa'
 assert ((∆MOUNT'')∨.≠' ')≡10↑1

∇          

∇ Test_ImportExport;filename;text;data

 1 ⎕NDELETE filename←FOLDER,'APLXtest.dat'

 text←'hello',∆R,'world'
 text ∆EXPORT filename'txt' 
 assert text≡∆IMPORT filename 'txt'
 text ∆EXPORT filename'txt' 
 assert text≡∆IMPORT filename 'txt'
 
 text←'⍋⍒'
 text ∆EXPORT filename'utf8'
 assert 226 141 139 226 141 146≡⎕UCS n_get filename
 assert text≡∆IMPORT filename 'UTF-8'
 
 data←{⍵⍪-⌿⍵}2 4⍴11300 13220 16550 19230, 12450 12950 13620 13980
 data←'' 'Q1' 'Q2' 'Q3' 'Q4'⍪'Sales' 'Expenses' 'Profit',data
 data ∆EXPORT filename 'csv'
 assert data≡∆IMPORT filename 'csv' 

 {0 ⎕NRESIZE ⍵ ⋄ ⎕NUNTIE ⍵}filename ⎕NTIE 0
 assert 0=⍴∆IMPORT filename 'txt'

 ⎕NDELETE filename
∇

∇ Test_CFiles;filename;tn;z
 1 ⎕NDELETE filename←FOLDER,'APLXtest.dcf'
 
 tn←filename ⎕FCREATE 0
 'Hello' ∆FWRITE tn 0 ⍝ ⎕FAPPEND
 assert 'Hello'≡∆FREAD tn 1     
 'There' ∆FWRITE tn 1 ⍝ ⎕FREPLACE
 assert 'There'≡∆FREAD tn 1     
 z←∆FHOLD tn 1E6
 assert 1≡∆FDROP tn 0 ⍝ ⎕FDROP tn ¯1
 assert 1 1 1E6≡1 1 0 1/⎕FSIZE tn

 ⎕FUNTIE tn
 1 ⎕NDELETE filename
∇

∇ Test_NFiles;filename;z;tn;expect;text
 ⍝ /// Work in Progress 

 1 ⎕NDELETE filename←FOLDER,'APLXtest.dat'
 
 tn←filename ⎕NCREATE 0
 expect←⍬
 text←'aA⍺0'
 text ∆NAPPEND tn 0 ⋄ expect,←¯1+∆AV⍳text      ⍝ Untranslated
 assert text≡∆NREAD tn 0 4 0                                 

 (8⍴0 1) ∆NAPPEND tn 1 ⋄ expect,←2⊥8⍴0 1       ⍝ Bool
 assert (8⍴0 1)≡∆NREAD tn 1 8 4
 42 ∆NAPPEND tn 2 ⋄ expect,←4↑42               ⍝ Int32
 assert (,42)≡∆NREAD tn 2 1 5
 42 ∆NWRITE tn 2 5                             ⍝ Test NWRITE does the same thing
 assert (,42)≡∆NREAD tn 2 1 5

 ¯0.1 ∆NAPPEND tn 3 ⋄ expect,←⎕UCS 80 ⎕DR ¯0.1 ⍝ Float64
 assert (,¯0.1)≡∆NREAD tn 3 1 9
 ¯0.1 ∆NREPLACE tn 9 3                         ⍝ Test NREPLACE as well
 assert (,¯0.1)≡∆NREAD tn 3 1 9

 text ∆NAPPEND tn 4 ⋄ expect,←97 65 184 48     ⍝ Translated Char
 assert text≡∆NREAD tn 4 4 17
 text ∆NAPPEND tn 5                            ⍝ UTF-16   
 assert text≡∆NREAD tn 5 4 21
 expect,←,⌽⍉256 256⊤'UTF-16' ⎕UCS text   
 ⍝ Skip 6 (Float32)
 text ∆NAPPEND tn 8 ⋄ expect,←'UTF-8' ⎕UCS text ⍝ UTF-8  
⍝ assert text≡∆NREAD tn 8 4 29
  
 assert expect≡z←⎕UCS ⎕NREAD tn 80 (⎕NSIZE tn) 0     
 filename ∆NERASE tn

 :Trap 22
    filename ⎕NTIE tn 
 :Else               
    assert 'Unable to open file'{⍺≡(≢⍺)↑⍵}∆NERROR
 :EndTrap
 
 assert 1∊'TestAPLX.dyalog'⍷∆LIB FOLDER
∇

∇ Test_SS;t;MAIL;vtv;⎕IO
⍝ Test suite for ∆SS
 
 ⎕IO←1
 assert 19=+/t←∆SS'A pixel color (or colour)' 'colour'
 assert(9 19,⍪1 2)≡t←∆SS'A pixel color (or colour)'('color' 'colour')
 ⎕IO←0
 assert(9 19,⍪1 2)≡1+t←∆SS'A pixel color (or colour)'('color' 'colour')

 ⎕IO←1 
 assert(2 2⍴2 1 4 2)≡t←∆SS'.ABC.'('ABC' 'C.')  
 assert(2 2⍴9 5 19 6)≡t←1 ∆SS'A pixel color (or colour)' 'colou?r'
 assert(3 3⍴9 5 1 19 6 1 42 4 2)≡t←1 ∆SS'A pixel color (or colour), such as light grey'('colou?r' 'gr[ea]y')
 assert(3 2⍴9 5 19 6 42 4)≡t←1 ∆SS'A pixel color (or colour), such as light grey' 'colou?r|gr[ea]y'
 MAIL←'Try e-mailing bill.gates@microsoft.com or, better, jim@microapl.co.uk'
 assert(2 2⍴15 24 52 18)≡t←1 1 ∆SS MAIL'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b'
 assert(1 12 19 23,⍪2/3 4)≡t←1 ∆SS'<P>This is <B>bold</B></P>' '<[^>]+>'
 assert'∆This is ∆bold∆∆'≡t←1 ∆SS'<P>This is <B>bold</B></P>' '<[^>]+>' '∆'
 assert'This is bold'≡t←1 ∆SS'<P>This is <B>bold</B></P>' '<[^>]+>' ''
 assert'[HTML: <P>]This is [HTML: <B>]bold[HTML: </B>][HTML: </P>]'≡t←1 ∆SS'<P>This is <B>bold</B></P>' '<[^>]+>' '[HTML: \0]'
 
 assert 'abc..def..'≡∆SS ('abc',∆R,'def',∆R) ∆R '..'

 vtv←'bill.gates@microsoft.com' 'jim@microapl.co.uk'
⍝ assert vtv≡t←2 1 ∆SS MAIL'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b'
∇                           

∇assert ok;caller
 caller←⎕IO+1
 :If ~ok  
    ⎕←'*** Assertion failed at ',(caller⊃⎕SI),'[',(⍕caller⊃⎕LC),']: '
    ⎕←'   ',(⎕CR caller⊃⎕SI)[1+caller⊃⎕LC;]
    ⎕←' '
    'assertion failed' ⎕SIGNAL DEBUG/11
 :EndIf
∇

expecterror←{
   0::⎕SIGNAL(⍺≡⊃⎕DMX.DM)↓11
   z←⍺⍺ ⍵
   ⎕SIGNAL 11
}   

⍝ We should provide utilities to detect potential problems.
⍝ For example ⎕WA← is illegal in Dyalog but not in APLX.
⍝ A[2] B[3] is fine in APLX but an INDEX error in Dyalog

⍝ The first one can be solved by doing

⍝    ]locate (⎕AI|⎕AV|⎕D|⎕A|⎕EM|⎕B|⎕C|⎕CL|⎕ERM|⎕I|⎕ID|⎕L|⎕LC|⎕LER|⎕M|⎕N|⎕NULL|⎕R|⎕SI|⎕T|⎕TC|⎕THIS|⎕TIME|⎕TS|⎕T|⎕UL|⎕W|⎕WA)← -pat -excl=c -in

⍝ The simple cases of the 2nd one could be

⍝    ]locate  "(⍺\[[ ;0-9]+\]){2,}" -pat -exc=c
      
:EndNamespace
