:Require file://./APLX.dyalog

:Namespace TestAPLX

∇Run;⎕IO;⎕ML;folder
⍝ Test the APLX emulation functions
 ⎕IO←1 ⋄ ⎕ML←1

 folder←{(1-⌊/(⌽⍵)⍳'\/')↓⍵}{⊃⍵[⍵[;1]⍳⎕THIS;4]}↑5177⌶⍬
 
 ⍝/// ∆af and ∆at not tested; they don't work

 assert #.APLX.∆a≡⎕UCS 96+⍳26  
 assert 105086=+/⎕UCS  #.APLX.∆C

 assert 4≡'42' #.APLX.∆EA '2+2'
 assert 42≡'42' #.APLX.∆EA '1÷0'

 assert (↑⎕DM)≡#.APLX.∆EM
 
 assert 1 0 1≡#.APLX.∆VI'1 E 2'
 assert 1 0 2≡#.APLX.∆FI'1 E 2'

 ⍝ /// no test for ∆call - don't know a good test
 
 assert 'A B C'≡#.APLX.∆DBR'  A  B  C '
 assert 1∊'TestAPLX.dyalog'⍷#.APLX.∆LIB folder

 assert 3 1≡+/'→∊'∘.=,#.APLX.∆DISPLAY (1 2 3)'ABC'

 ⎕←'APLX tests completed'
∇

assert←{'Assertion failed'⎕SIGNAL(⍵=0)/11}

expecterror←{
   0::⎕SIGNAL(⍺≡⊃⎕DMX.DM)↓11
   z←⍺⍺ ⍵
   ⎕SIGNAL 11
}            
      
:EndNamespace
