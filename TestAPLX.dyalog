:Require file://./APLX.dyalog

:Namespace TestAPLX

∇ Run;⎕IO;⎕ML;folder;⎕PATH;z;text
⍝ Test the APLX emulation functions
 ⎕IO←1 ⋄ ⎕ML←1
 ⎕PATH←'#.APLX'

 folder←{(1-⌊/(⌽⍵)⍳'\/')↓⍵}{⊃⍵[⍵[;1]⍳⎕THIS;4]}↑5177⌶⍬
 :If ⎕NEXISTS filename←folder,'APLXtest.dat'
     ⎕NDELETE filename
 :EndIf

 text←'hello',∆L,'world'
 text ∆EXPORT filename'txt' 
 assert text≡∆IMPORT filename 'txt'
 
 text←'⍋⍒'
 text ∆EXPORT filename'utf8'
 assert 226 141 139 226 141 146≡n_get 'c:\devt\aplx\aplxtest.dat'
 assert text≡∆IMPORT filename 'UTF-8'
 
 assert text≡∆IMPORT filename 'txt'
 
 ⎕NDELETE filename

 assert ∆a≡⎕UCS 96+⍳26
 assert 105086=+/⎕UCS ∆C
 assert 241=≢∪∆AV
 assert 225 97 65≡∆AF'aA⍺'

 assert 8 10 13≡⎕UCS ∆B ∆L ∆R
 assert 'SMTWTFS'≡∆W[;1]
 assert 'JFMAMJJASOND'≡∆M[;1]

 assert(2 3⍴'AB CDE')≡∆BOX'AB CDE'
 assert(2 3⍴'AB.CDE')≡'/.'∆BOX'AB/CDE'

 assert 4≡'42'∆EA'2+2'
 assert 42≡'42'∆EA'1÷0'

 assert(↑⎕DM)≡∆EM

 assert 1 0 1≡∆VI'1 E 2'
 assert 1 0 2≡∆FI'1 E 2'

 assert(2 2⍴1 2 4 2)≡∆SS'.ABC.'('ABC' 'C.')  
 assert 5 8 14 17≡{(⍵∊'-.')/⍳⍴⍵}∆TIME

 assert'A B C'≡∆DBR'  A  B  C '
 assert 1∊'TestAPLX.dyalog'⍷∆LIB folder

 assert 3 1≡+/'→∊'∘.=,∆DISPLAY(1 2 3)'ABC'

 :If 0≠≢z←{(~1∊¨⍵⍷¨⊂⎕VR'Run')/⍵}'∆'#.APLX.⎕NL ¯3
     ⎕←'NB: ',(⍕≢z),' functions not tested:'
     ⎕←z
     ⎕←' '
 :EndIf

 ⎕←'APLX tests completed'
∇

∇assert ok
 :If ~ok
    ⎕←'*** Assertion failed: '
    ⎕←'   ',(⎕CR 2⊃⎕SI)[1+2⊃⎕LC;]
    ⎕←' '
 :EndIf
∇

expecterror←{
   0::⎕SIGNAL(⍺≡⊃⎕DMX.DM)↓11
   z←⍺⍺ ⍵
   ⎕SIGNAL 11
}            
      
:EndNamespace
