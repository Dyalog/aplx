:Require file://./APLX.dyalog                   

∇FixCovers;T
⍝ Create emulation function templates

:If 'Dyalog'≡APLVERSION←(4 7⍳⍴⎕AI)⊃'Dyalog' 'APLX' 'APLX'  
    EMULATED←APLX.⎕NL ¯3 ⍝ Use the list of functions 
:Else ⍝ Hardcoded in APLX - remember to update!
    T←'/∆AF/∆AI/∆AV/∆B/∆BOX/∆C/∆CALL/∆DBR/∆DISPLAY/∆DR/∆EA/∆EM/∆EQ_'
    T←T,'/∆ERM/∆ERX/∆EXPORT/∆FDROP/∆FHOLD/∆FI/∆FREAD/∆FWRITE/∆GETCLASS'
    T←T,'/∆HOST/∆I/∆IMPORT/∆L/∆LIB/∆LSHOE/∆M/∆MOUNT/∆N/∆NAPPEND'
    T←T,'/∆NERASE/∆NERROR/∆NREAD/∆NREPLACE/∆NWRITE/∆OV/∆R/∆RSHOE'
    T←T,'/∆SS/∆TIME/∆UP/∆VI/∆W/∆WSSIZE/∆a'
    EMULATED←1↓¨(+\T='/')⊂T
:EndIf

:For fn :In EMULATED
    :Select APLVERSION
    :Case 'APLX'
       :If (⎕AF 'Z')<⎕AF 1⊃fn ⍝ lowercase => function
          ⎕FX ⊃('Z←L ',fn,' R')(':If 2=⎕NC ''L'' ⋄ Z←L ⎕',fn,' R')(':Else ⋄ Z←⎕',fn,' R')':EndIf' 
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