:Require file://./APLX.dyalog

:Namespace TestAPLX
 ⎕PATH←'#.APLX' 

∇ {tests} Run DEBUG;⎕IO;⎕ML;FOLDER;fn;fns;z
⍝ Test the APLX emulation functions   

 ⎕IO←1 ⋄ ⎕ML←1   
 ⎕NUNTIE ⎕NNUMS
 ⎕FUNTIE ⎕FNUMS

 FOLDER←{(1-⌊/(⌽⍵)⍳'\/')↓⍵}{⊃⍵[⍵[;1]⍳⎕THIS;4]}↑5177⌶⍬ ⍝ find loaded files' location

 :For fn :In fns←'T' ⎕NL ¯3
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

∇Test_Misc;z;text      

 assert 4≡'42'∆EA'2+2⊣∆a'
 assert 42≡'42⊣∆a'∆EA'1÷0'

 assert(↑⎕DM)≡∆EM  
 assert(¯1↓⊃,/⎕DM,¨⎕UCS 13)≡∆ERM

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
 
 ∆ERX L10 
 assert ~0∊⍴⎕trap
 ÷0
 L10:∆ERX 0
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

assert 0∊⍴∆MOUNT''
{}∆MOUNT 'dsa'
assert ((∆MOUNT'')∨.≠' ')≡10↑1

∇          

∇ Test_ImportExport;filename;text;data

 1 ⎕NDELETE filename←FOLDER,'APLXtest.dat'

 text←'hello',∆L,'world'
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

 ⎕NDELETE filename
∇

∇ Test_NFiles;filename;z;tn
 ⍝ /// Work in Progress 

 1 ⎕NDELETE filename←FOLDER,'APLXtest.dat'
 
 tn←filename ⎕NCREATE 0
 ⍝ 'aA⍺0' ∆NAPPEND tn 0    ⍝ Untranslated
 (8⍴0 1) ∆NAPPEND tn 1   ⍝ Bool
 42 ∆NAPPEND tn 2        ⍝ Int32
 ¯1 ∆NAPPEND tn 3        ⍝ Float64
 ⍝ 'aA⍺0' ∆NAPPEND tn 4    ⍝ Translated Char
 ⍝'aA⍺0' ∆NAPPEND tn 5    ⍝ UTF-16
 ⍝ Skip 6 (Float32)
 ⍝'aA⍺0' ∆NAPPEND tn 8    ⍝ UTF-8
 assert z≡z←⎕UCS ⎕NREAD tn 80 (⎕NSIZE tn) 0 
 ⎕NUNTIE tn

 ⎕NDELETE filename

 assert 1∊'TestAPLX.dyalog'⍷∆LIB FOLDER
∇

∇ Test_SS;assert;t;MAIL;vtv;⎕IO
⍝ Test suite for ∆SS
 ⎕IO←1
 assert←{x←÷⍵}
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

 vtv←'bill.gates@microsoft.com' 'jim@microapl.co.uk'
⍝ assert vtv≡t←2 1 ∆SS MAIL'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b'
∇    

∇assert ok
 :If ~ok  
    ⎕←'*** Assertion failed at ',(2⊃⎕SI),'[',(⍕2⊃⎕LC),']: '
    ⎕←'   ',(⎕CR 2⊃⎕SI)[1+2⊃⎕LC;]
    ⎕←' '
    :If DEBUG ⋄ (1+⎕LC) ⎕STOP 'assert'
        ⍝ stop here
    :EndIf
 :EndIf
∇

expecterror←{
   0::⎕SIGNAL(⍺≡⊃⎕DMX.DM)↓11
   z←⍺⍺ ⍵
   ⎕SIGNAL 11
}        
      
:EndNamespace
