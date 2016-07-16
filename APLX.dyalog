:Namespace APLX
⍝ Dyalog covers for APLX functionality

⍝ This namespace can be added as is in a workspace or individual items )COPYed.
⍝ If the whole workspace is added ⎕PATH should be set to '#.APLX' in order to get at the code.

∆af←{⎕IO←0 ⋄ 0∊1↑0⍴⍵:⎕AV[⍵] ⋄ ⎕AV⍳⍵}

∇r←x ∆at y
⍝ Emulate ⎕AT under APLX
 :Select x
 :Case 0  ⍝ valence
 :Case 1  ⍝ timestamp
 :Case 2  ⍝ properties
 :Case 3  ⍝ size
     r←⎕SIZE t
 :EndSelect
∇

∇ Z←V ∆ea P
⍝ Emulate APLX ⎕ea
     
:Trap 0
    Z←⎕RSI[⎕IO]⍎P
:Else
    Z←⎕RSI[⎕IO]⍎V
:EndTrap
∇

∇r←∆fi y
⍝ Emulate ⎕FI under APLX
r←(1+⎕IO)⊃⎕VFI y
∇         

∇r←∆vi y
⍝ Emulate ⎕VI under APLX
r←⎕IO⊃⎕VFI y
∇                  

∇ r←env ∆call args;⎕USING
⍝ Simulate ⎕CALL in APLX
 'Only .Net supported'⎕SIGNAL 11/⍨'.net'≢env
 ⎕USING←''
 :If 1=≡,args
     r←⍎args
 :Else
     r←(⍕1⊃args)2⊃args
 :EndIf
∇

∇r←∆dbr v
 r←1↓(r⍲1⌽r←v∊' ')/v←,' ',v
∇

∇r←∆lib path;⎕ML;wild;⎕IO
⍝ Emulate APLX ⎕LIB 
⍝ Extension: allows filtering of terminal node, e.g. ∆lib 'c:\temp\*.csv'

 ⎕ML←1 ⋄ ⎕IO←1
 wild←'*'∊path
 r←↑↑(⎕NINFO⍠1)path,((wild∨(¯1↑path)∊'/\')↓'/'),wild↓'*'
 r←(1+(≢path)-⌊/(⌽path)⍳'/\')↓⍤1⊢r
∇

∆display←{⎕IO ⎕ML←0                             ⍝ Boxed display of array.

     ⍺←1 ⋄ chars←⍺⊃'..''''|-' '┌┐└┘│─'           ⍝ ⍺: 0-clunky, 1-smooth.

     tl tr bl br vt hz←chars                     ⍝ Top left, top right, ...

     box←{                                       ⍝ Box with type and axes.
         vrt hrz←(¯1+⍴⍵)⍴¨vt hz                  ⍝ Vert. and horiz. lines.
         top←(hz,'⊖→')[¯1↑⍺],hrz                 ⍝ Upper border with axis.
         bot←(⊃⍺),hrz                            ⍝ Lower border with type.
         rgt←tr,vt,vrt,br                        ⍝ Right side with corners.
         lax←(vt,'⌽↓')[¯1↓1↓⍺],¨⊂vrt             ⍝ Left side(s) with axes,
         lft←⍉tl,(↑lax),bl                       ⍝ ... and corners.
         lft,(top⍪⍵⍪bot),rgt                     ⍝ Fully boxed array.
     }

     deco←{⍺←type open ⍵ ⋄ ⍺,axes ⍵}             ⍝ Type and axes vector.
     axes←{(-2⌈⍴⍴⍵)↑1+×⍴⍵}                       ⍝ Array axis types.
     open←{(1⌈⍴⍵)⍴⍵}                             ⍝ Expose null axes.
     trim←{(~1 1⍷∧⌿⍵=' ')/⍵}                     ⍝ Remove extra blank cols.
     type←{{(1=⍴⍵)⊃'+'⍵}∪,char¨⍵}                ⍝ Simple array type.
     char←{⍬≡⍴⍵:hz ⋄ (⊃⍵∊'¯',⎕D)⊃'#~'}∘⍕         ⍝ Simple scalar type.
     line←{(6≠10|⎕DR' '⍵)⊃' -'}                  ⍝ underline for atom.

     {                                           ⍝ Recursively box arrays:
         0=≡⍵:' '⍪(open ⎕FMT ⍵)⍪line ⍵           ⍝ Simple scalar.
         1 ⍬≡(≡⍵)(⍴⍵):'∇' 0 0 box ⎕FMT ⍵         ⍝ Object rep: ⎕OR.
         1=≡⍵:(deco ⍵)box open ⎕FMT open ⍵       ⍝ Simple array.
         ('∊'deco ⍵)box trim ⎕FMT ∇¨open ⍵       ⍝ Nested array.
     }⍵
 }

∇Z←data ∆export V;file;type;⎕IO
⍝ Emulate APLX ⎕export
 ⎕IO←1
 file←1⊃V ⋄ type←2⊃V
 :If type≡'txt'
     Z←(data)⎕NPUT file
 :ElseIf type≡'csv'
     ∘∘∘
 :ElseIf type≡'xml'
 :Else
     'Unknown file type'
 :EndIf
∇

∇ Z←∆import V;file;type;⎕IO
⍝ Emulate APLX ⎕import
 ⎕IO←1
 file←1⊃V
 type←819⌶2⊃V ⍝ Lowercase

 :Select type
 :Case 'txt'
     Z←1⊃⎕NGET file
 :CaseList 'utf8' 'utf-8' 'utf16' 'utf-16'
     Z←1⊃⎕NGET file type
 :CaseList 'csv' 'tsv'
     Z←LoadData.LoadTEXT file (('csv' 'tsv'⍳⊂type)⊃',',⎕UCS 9)
 :Case 'xml'
     Z←⎕XML 1⊃⎕NGET file
 :Else
     'Unknown file type'⎕SIGNAL 11
 :EndSelect
∇

∇ Z←∆a
Z←'abcdefghijklmnopqrstuvwxyz' ⍝ Emulate APLX ⎕a
∇             
    
∇ Z←∆A
Z←'ABCDEFGHIJKLMNOPQRSTUVWXYZ' ⍝ Emulate APLX ⎕A
∇             

∇ Z←∆B
Z←⎕UCS 8 ⍝ Emulate APLX ⎕B
∇        

∇ Z←∆C
Z←⎕UCS ¯1+⍳32 ⍝ Emulate APLX ⎕C
∇        

∇ Z←∆D
Z←'0123456789' ⍝ Emulate APLX ⎕D
∇        


∇ Z←∆L
Z←⎕UCS 10 ⍝ Emulate APLX ⎕L
∇             

∇ Z←∆R
Z←⎕UCS 13 ⍝ Emulate APLX ⎕R
∇        

∇r←{la}∆box ra;sep;fill;b;max;⎕ML
⍝ Box a la APLX
 :If 900⌶⍬ ⋄ la←''⍴0⍴ra ⋄ :EndIf
 (sep fill)←2↑la
 ⎕ML←0
 :If 2∊⍴⍴ra ⍝ matrix case
     b←,1,⌽∨\⌽fill≠ra ⋄ r←1↓b/,sep,ra
 :Else ⍝ vector case
     max←⌈/⊃,/⍴¨r←1↓¨(r∊sep)⊂r←sep,ra
     r←↑max↑¨r,¨⊂max⍴fill
 :EndIf
∇


∇ Z←{time}∆host V
⍝ Emulate the APLX  ⎕host
 :If V≡''
     Z←('WLA'⍳1↑2⊃'.' ⎕WG 'aplversion')⊃'WINDOWS' 'LINUX' 'UNIX' 'MACOS'
 :Else
     Z←¯1↓∊(⎕sh V),¨∆R
 :EndIf
∇

∇ r←la ∆ov ra;src;nl
⍝ ⎕OV in APLX
 src←⎕IO⊃⎕NSI
 nl←{⍵.⎕NL⍳9}
 :Select la
 :Case 0
     r←⎕NS src∘,¨↓ra
 :CaseList 2 1
     src ⎕NS ra ⋄ r←nl ra
 :Case 3
     r←nl ra
 :EndSelect
∇

∇ r←{opt}∆ss arg;text;from;to;type;flags;fix;⎕IO;norm;⎕ML;add1;search
⍝ Mimic APLX' ⎕ss function
⍝ arg is a 2 (search) or 3 (replace) element
 :If 900⌶0 ⋄ opt←0 ⋄ :EndIf  ⍝ simple search
 (type flags)←2↑opt,4        ⍝ advance by 1 after search

 (text from to)←3↑arg,0
 fix←⊢
 :If norm←type=0  ⍝ turn regex meta char x into \x
     fix←'{}\.[^|]$(?*)+'∘{pat←⍵ ⋄ r←1+b←⍵∊⍺ ⋄ (pat b)←r∘/¨pat b ⋄ pat⊣((≠\b)/pat)←'\'}
 :EndIf
 type←0,norm↓1    ⍝ return also length for regex
 add1←(⍴type)⍴1 0 ⍝ for ⎕IO adjustment later
 :If 1=≡from ⋄ from←fix from
 :Else ⋄ from←fix¨from ⋄ type,←3 ⍝ show pattern number too
     add1,←1
 :EndIf

 ⎕IO←0 ⋄ ⎕ML←1
 :If search←to≡0
     fix←from ⎕S type
 :Else
     fix←from ⎕R to
 :EndIf
 :If flags>0
     flags←⌽(9⍴2)⊤flags        ⍝ case insensitive?
     fix←fix ⎕OPT(0⊃flags)
     fix←fix ⎕OPT'ML'(1⊃flags) ⍝ stop after 1st
     fix←fix ⎕OPT'Mode'(0⊃flags[3]⌽'LM') ⍝ Line or Mixed mode?
 :AndIf 1=1↑type
     fix←fix ⎕OPT'DotAll'(4⊃flags) ⍝ . matches all?
    ⍝ Return all matches for multiple searches are ignored
     fix←fix ⎕OPT'EOL'((flags[6 7]⍳1)⊃'CR' 'LF' 'CRLF')
 :AndIf search
     fix←fix ⎕OPT'OM'(2⊃flags) ⍝ advance by 1?
 :EndIf

 r←↑fix text
⍝ We need to adjust for the caller's ⎕IO
 :If search∧1↑3⊃⎕STATE'⎕io'
     r←r+(⍴r)⍴add1
 :EndIf
∇

∇r←∆time
 r←,'G<9999-99-99 99.99.99>'⎕FMT 100⊥6⍴⎕TS
∇

∇r←∆M
 r←↑⍤0⊢'JANUARY' 'FEBRUARY' 'MARCH' 'APRIL' 'MAY' 'JUNE' 'JULY' 'AUGUST' 'SEPTEMBER' 'OCTOBER' 'NOVEMBER' 'DECEMBER'
∇

∇r←∆W
 r←↑⍤0⊢'SUNDAY' 'MONDAY' 'TUESDAY' 'WEDNESDAY' 'THURSDAY' 'FRIDAY' 'SATURDAY'
∇         

 
:Namespace LoadData
⍝ Functions copied from distributed workspace LoadData.dws

∇data←LoadTEXT params;file;string;cr;Quote;tmp;sep;⎕ML;⎕IO;vi;Sep;fget;nested;filename;specialchars;NL;CR;cols;header;rows;ncol;lCase;criteria;if;isChar;n;csv;text;num
⍝ Load data from a TEXT file                                   danb 2008

⍝ Arguments are:  Filename [SpecialChars [SelectionCriteria]]
⍝ Selection criteria is made in the form
⍝ ('Column' or 'Row' followed by a series of numbers or column heading)
⍝ Example:
⍝   LoadTEXT '\temp\myfile.csv' ';' ('columns' 'name,age,telephone')  ⍝ CSV file using ';' as delimiter
⍝   LoadTEXT '\temp\myfile.txt' (12 5 6 256) ('rows' (2×⍳999))        ⍝ keep every 2nd row of fixed fields width file

⍝ This version assumes the data is delimited by a specific character (default comma)
⍝ and that string that includes the separator is surrounded by quotes (default ")
⍝ It will complain if anything seems out of order.

 if←/⍨                                ⍝ --- local fns ---
 isChar←{0 2∊⍨10|⎕DR 1/⍵}
 lCase←{n←⍴l←'abcdefghijklmnopqrstuvwxyz' ⋄ ⎕IO←0 ⋄ ~∨/b←n>i←⎕A⍳s←⍵:⍵ ⋄ (b/s)←l[b/i] ⋄ s}

 ⎕IO←⎕ML←1 ⋄ (NL CR)←⎕TC[2 3]         ⍝ --- local variables ---
 params←,{⊂⍣(1∊≡,⍵)⌷⍵}params ⍝ nest if only a filename (string) as argument

 :If ∨/nested←1<|≡¨params
    ⍝ Each criteria must be a 2 element nested array
     ⎕SIGNAL 5 if 2∨.≠↑⍴¨tmp←nested/params
     criteria←lCase∘⊃¨tmp
     ⎕SIGNAL 11 if~∧/criteria∊'columns' 'rows'  ⍝ only accept these
    ⍝ If a character column specification is supplied we assume there is a header
     header←isChar 2⊃(criteria⍳⊂'columns')⊃tmp,⊂0 0
 :Else
     criteria←⍴header←0
 :EndIf

 (filename specialchars)←2↑(~nested)/params
 data←0 0⍴0

⍝ This version assumes v15.0 or later:
 fget←{z←⎕NGET ⍵ ⋄ (-≢3⊃z)↓1⊃z}

 :If ~0∊⍴string←fget filename
    ⍝ There can be 3 types of line delimiter: NL, CR, CR+LF
    ⍝ CR,NL and lone NLs will be turned into CRs
     string←CR,(~CR NL⍷string)/string
     ((string=NL)/string)←CR
     cr←CR=string                         ⍝ line delimiters
     :If csv←isChar specialchars          ⍝ fixed field or CSV?
         (Sep Quote)←',"'{(⍴⍺)↑⍵,(⍴⍵)↓⍺}specialchars~' '
         text←≠\string=Quote              ⍝ string
         cr←cr>text
         sep←cr∨text<string=Sep           ⍝ items separator
     :Else
         tmp←(+/specialchars)⍴0 ⋄ tmp[+\specialchars]←1
         sep←∊(⍴¨cr⊂cr)↑¨⊂1 0,tmp         ⍝ first field has NL
         text←0 ⋄ Quote←''                ⍝ no text or quotes to remove
     :EndIf
    ⍝ Take care of doubled quotes
     data←{¯1↑q←⍵∊Quote:¯1↓⍵/⍨q⍲≠\q ⋄ ⍵}¨↑(sep/cr)⊂(sep/cr∨csv)↓¨sep⊂string
    ⍝ We know there is at least ONE row
     tmp←↑(sep/cr)⊂1∊¨sep⊂text            ⍝ Quote used?
    ⍝ Columns of numbers are to be returned as such
     :If ∨/cols←~∧⌿tmp                    ⍝ columns that don't use quotes   
         num←cols/data
         (∊num)←{w←⍵ ⋄ ((w='-')/w)←'¯' ⋄ w}∊num ⍝ treat - as ¯
         num←(⊂,1)≡∘⊃¨tmp←⎕VFI¨num        ⍝ all the numeric items
         :If header<∨/ncol←∧⌿num          ⍝ do we have full length columns of numbers?
             rows←1                       ⍝ then change all rows
         :Else
             header∨←n←∨/ncol←∧⌿1 0↓num   ⍝ maybe if we remove the first line
             rows←0,1↓(⊃⍴data)⍴n
         :EndIf
         (rows⌿ncol/cols/data)←2 1∘⊃¨rows⌿ncol/tmp
     :EndIf
 :EndIf

 ⍝ Take care of constraints
 :If 0<⍴criteria
     :If ∨/tmp←'columns'∘≡¨criteria
         :If ' '∊1↑0⍴cols←2⊃(tmp⍳1)⊃nested/params
             cols←(lCase¨data[1;])⍳1↓¨(tmp=',')⊂tmp←',',cols
         :EndIf
         data←data[;cols]
     :EndIf
     :If ∨/tmp←'rows'∘≡¨criteria
         rows←header+2⊃(tmp⍳1)⊃nested/params ⍝ row numbers start at 1; header does not count
         data←data[(rows≤1↑⍴data)/rows;]     ⍝ keep valid rows only
     :EndIf
 :EndIf
∇
:EndNamespace
:EndNameSpace
