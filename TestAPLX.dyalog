:Require file://./APLX.dyalog

:Namespace TestAPLX

∇Run;⎕IO;⎕ML;folder;⎕PATH;z
⍝ Test the APLX emulation functions
 ⎕IO←1 ⋄ ⎕ML←1           
 ⎕PATH←'#.APLX'

 folder←{(1-⌊/(⌽⍵)⍳'\/')↓⍵}{⊃⍵[⍵[;1]⍳⎕THIS;4]}↑5177⌶⍬
 
 assert ∆a≡⎕UCS 96+⍳26  
 assert 105086=+/⎕UCS  ∆C  
 assert 241=≢∪∆AV 
 assert 225 97 65≡∆AF 'aA⍺'

 assert 4≡'42' ∆EA '2+2'
 assert 42≡'42' ∆EA '1÷0'

 assert (↑⎕DM)≡∆EM
 
 assert 1 0 1≡∆VI'1 E 2'
 assert 1 0 2≡∆FI'1 E 2'
 
 assert 'A B C'≡∆DBR'  A  B  C '
 assert 1∊'TestAPLX.dyalog'⍷∆LIB folder

 assert 3 1≡+/'→∊'∘.=,∆DISPLAY (1 2 3)'ABC'
 
 :If 0≠≢z←{(~1∊¨⍵⍷¨⊂⎕VR 'Run')/⍵}'∆' #.APLX.⎕NL ¯3
     ⎕←(≢z),' functions untested:'
     ⎕←z
 :EndIf

 ⎕←'APLX tests completed'
∇

assert←{'Assertion failed'⎕SIGNAL(⍵=0)/11}

expecterror←{
   0::⎕SIGNAL(⍺≡⊃⎕DMX.DM)↓11
   z←⍺⍺ ⍵
   ⎕SIGNAL 11
}            
      
:EndNamespace
