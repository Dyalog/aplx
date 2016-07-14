:Require file://./APLX.dyalog

∇Init;path
⎕ML←3
:If 'Dyalog'≡APLVERSION←(4 7⍳⍴⎕AI)⊃'Dyalog' 'APLX' 'APLX'  
    EMULATED←APLX.⎕NL ¯3 ⍝ Use the list of functions 
:Else
    EMULATED←'R' 'L' 'box' 'ss'
:EndIf
FixCovers
∇                          

∇FixCovers;fn;hdr;val
⍝ Create emulation function templates

:For fn :In EMULATED
    :Select APLVERSION
    :Case 'APLX'
       :If (⎕AF 'Z')<⎕AF 1⊃fn ⍝ lowercase => function
          ⎕FX ⊃('Z←L ∆',fn,' R')(':If 2=⎕NC ''L'' ⋄ Z←L ⎕',fn,' R')(':Else ⋄ Z←⎕',fn,' R')':EndIf' 
       :Else ⍝ Niladic
          ⎕FX ⊃('Z←∆',fn)('Z←⎕',fn)
       :EndIf      
    :Case 'Dyalog'
        :If 0≠1 2⊃APLX.⎕AT fn
          ⎕FX ⊃('Z←{L} ',fn,' R')(':If 2=⎕NC ''L'' ⋄ Z←L #.APLX.',fn,' R')(':Else ⋄ Z←#.APLX.',fn,' R')':EndIf' 
       :Else ⍝ Niladic
          ⎕FX ⊃('Z←',fn)('Z←#.APLX.',fn) 
       :EndIf
    :EndSelect
:EndFor
∇

∇Z←∆sh V
⍝Emulate the nested array result of Dyalog ⎕sh
              
:Select APLVERSION
:Case 'APLX'
    Z←⎕HOST V
    Z←,∆db¨⊂[2]∆R ∆box Z
:Case 'Dyalog'
    :Trap 0 ⋄ Z←⎕SH V
    :Else ⋄ Z←⍬ 
    :EndTrap
:EndSelect
∇
