:Namespace APLX
⍝ Dyalog covers for APLX functionality

∇ Z←∆R
Z←⎕UCS 13 ⍝ Emulate APLX ⎕R
∇        

∇ Z←∆L
Z←⎕UCS 10 ⍝ Emulate APLX ⎕L
∇        

∇ y←chars ∆box x;fill;len;m;of;pos;s;sep;⎕IO
⍝'box' vector <x> using separator and fill character <chars>
⍝.e (3 5⍴'applebettycat  ') = '/' ∆box 'apple/betty/cat'
⍝.k reshape
⍝.t 1988.4.28.1.20.21
⍝.v 2.0 / 8jul83
⍝chars[1]=separator; chars[2]=fill; defaults are blank/zero
⍝<y>  matrix corresponding to a vector delimited into logical fields
 ⎕IO←1
 y←0 0⍴x
 →(0∊⍴x)/0
 chars←chars,(×/⍴chars)↓2↑0⍴x
⍝separator
 sep←chars[1]
⍝filler
 fill←chars[2]
⍝add sep to end if necessary
 x←x,(sep≠¯1↑x)/sep
⍝lengths
 pos←(x=sep)/⍳⍴x
 m←⌈/len←¯1+pos-0,¯1↓pos
⍝offsets
 of←(len+1)∘.⌊⍳m
⍝starting indices
 s←⍉(m,⍴len)⍴0,¯1↓pos
⍝replace separator with fill character
 x[(x=sep)/⍳⍴x]←fill
⍝return matrix
 y←x[s+of]
∇       

∇ Z←{time}∆host V
⍝ Emulate the APLX  ⎕host
 :If V≡''
     Z←'MACOS'
 :Else
     Z←¯1↓∊(∆sh V),¨∆R
 :EndIf
∇

∆ss←{⎕ML←3                           ⍝ Approx alternative to xutils' ss.
     srce find repl←,¨⍵              ⍝ Source, find and replace vectors.
     cvex←{(+\find⍷⍵)⊂⍵}find,srce    ⍝ Partitioned at find points.
     (⍴repl)↓∊{repl,(⍴find)↓⍵}¨cvex  ⍝ Collected with replacements.
    }

:EndNameSpace
