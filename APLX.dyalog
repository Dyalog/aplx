:Namespace APLX
⍝ Dyalog cover functions for APLX  V1.12

⍝ This namespace can be added as is in a workspace or individual items )COPYed.
⍝ If the whole workspace is added ⎕PATH should be set to '#.APLX' in order to get at the code.
⍝ If only items are copied the namespace should be erased if it was brought in whole.

    ∇ Z←∆a    ⍝ Emulate APLX ⎕a
      Z←'abcdefghijklmnopqrstuvwxyz'
    ∇

⍝ ⎕AV, based on ⎕UCS ⎕AV in APLX
⍝ Note that SOME control characters (1 2 3 4 5 6 8 10 13) are repeated
⍝ in the 2nd half of ⎕AV, and SPACE appears 7x at (0 32 128 222 223 224 254)
    ∆av ←  32    1    2    3    4    5    6 9040    8 9047   10 9031 9032   13 9073 9074
    ∆av,←9042 9035 9021 9033 8854 9055 9014 9067 9038 9045 9024 9023 9053 9054   33 9017
    ∆av,←  32  168   41   60 8804   61   62   93 8744   94 8800  247   44   43   46   47
    ∆av,←  48   49   50   51   52   53   54   55   56   57   40   91   59  215   58   92
    ∆av,← 175 9082 8869 8745 8970 8714   95 8711  123 9075 8728   39 9109  124 8868 9675
    ∆av,←  42   63 9076 8968  126 8595 8746 9077 8835 8593 8834 8592 8866 8594 8805   45
    ∆av,←8900   65   66   67   68   69   70   71   72   73   74   75   76   77   78   79
    ∆av,←  80   81   82   83   84   85   86   87   88   89   90 8710 8867 9066   36  125
    ∆av,←  32    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15
    ∆av,←9484 9488 9492 9496 9472 9474 9532 9500 9508 9524 9516   27   28  205   30   31
    ∆av,←  34   35   37   38   64  163   96 8801 8802 9079 9080 9019 9026 9060 9061 9015
    ∆av,← 196  197  199  201  209  214  220  225  224  226  228  227  229  231  233  232
    ∆av,← 234  235  237  236  238  239  241  243  242  244  246  245  250  249  251  252
    ∆av,← 192  195  213  338  339  198  230 9068  216  248  191  161  223  255   32   32
    ∆av,←  32   97   98   99  100  101  102  103  104  105  106  107  108  109  110  111
    ∆av,← 112  113  114  115  116  117  118  119  120  121  122 9049  200 8364   32  127
    ∆av←⎕UCS ∆av

⍝ ⎕NWRITE conversion code 4 table:
    ∆x4 ←  32  32  32  32  32  32  32 210   8 211  10 212 213  13 139 138
    ∆x4,← 148 147 178 179 180 181 167 162 150 149 153 154 169 171  33 142
    ∆x4,←  32 168  41  60 136  61  62  93 159  94 172 247  44  43  46  47
    ∆x4,←  48  49  50  51  52  53  54  55  56  57  40  91  59 215  58  92
    ∆x4,← 175 184 131 240 152 185  95 146 123 188 176  39 140 124 130 177
    ∆x4,←  42  63 189 151 126 135 158 190 156 134 155 132 164 133 137  45
    ∆x4,← 170  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79
    ∆x4,← 80  81  82  83  84  85  86  87  88  89  90 145 202 174  36 125
    ∆x4,←   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
    ∆x4,← 218 204 192 217 206 219 207 195 221 193 194  27  32 205  32  32
    ∆x4,←  34  35  37  38  64 163  96 166 187 186 165   0   0 253 246 222
    ∆x4,← 196 197 199 201 209 214 220 225 224 226 228 227 229 231 233 232
    ∆x4,← 234 235 237 236 238 239 241 243 242 244 246 245 250 249 251 252
    ∆x4,← 208 182 183  32  32 198 230 203 216 248 191 161 223 255  32  32
    ∆x4,←  32  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111
    ∆x4,← 112 113 114 115 116 117 118 119 120 121 122 254 200 128  32  32
    ∆x4←⎕UCS ∆x4

    ∆AF←{⎕IO←0 ⋄ 0∊1↑0⍴⍵:∆av[⍵] ⋄ ∆av⍳⍵}

    ∇ r←∆AI ⍝ ⎕AI in APLX
      r←7↑r+1000×4↑0=1↑r←⎕AI
    ∇

    ∇ r←∆AV ⍝ Emulate APLX ⎕AV: Note that it does not have 256 distinct elements
      r←∆av
    ∇

    ∇ Z←∆B  ⍝ Emulate APLX ⎕B
      Z←⎕UCS 8
    ∇

    ∇ r←{la}∆BOX ra;sep;fill;b;max;⎕ML
    ⍝ ⎕BOX in APLX
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

    ∇ Z←∆C ⍝ Emulate APLX ⎕C
      Z←⎕UCS 32 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 9484 9488 9492 9496 9472 9474 9532 9500 9508 9524 9516 27 28 205 30 31 127
    ∇

    ∇ r←env ∆CALL args;⎕USING
    ⍝ Simulate ⎕CALL in APLX
      'Only .Net supported'⎕SIGNAL 11/⍨'.net'≢env
      ⎕USING←''
      :If 1=≡,args
          r←⍎args
      :Else
          r←(⍎1⊃args)2⊃args
      :EndIf
    ∇

    ∇ Z←∆DR data ⍝ ⎕DR in APLX
      →0/⍨Z←1 2 3 4 0[1 3 5 0⍳10|⎕DR data]
      Z←5 6 7[9.1 2.1⍳⎕NC⊂'data']
    ∇

    ∆DBR←{⍺←' ' ⋄ 1↓(r⍲1⌽r←v∊⍺)/v←⍺,⍵}

      ∆DISPLAY←{⎕IO ⎕ML←0                             ⍝ Boxed display of array.
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

    ∇ Z←V ∆EA P ⍝ Emulate APLX ⎕ea
      Z←⍬
      :Trap 0
          :Trap 85 ⍝ ignore no result
              Z←⎕RSI[⎕IO].{0(85⌶)⍵}P
          :EndTrap
      :Else
          :Trap 85
              Z←⎕RSI[⎕IO].{0(85⌶)⍵}V
          :EndTrap
      :EndTrap
    ∇

    ∇ Z←∆EM;⎕ML ⍝ Emulate APLX ⎕EM
      ⎕ML←1 ⋄ Z←↑⎕DM
    ∇

    ∆EQ_←{⎕ML←2 ⋄ ⍺←⊢ ⋄ ⍺≡⍵} ⍝ ≡

    ∇ Z←∆ERM ⍝ Emulate APLX ⎕ERM
      Z←¯1↓↑,/⎕DM,¨⎕UCS 13
    ∇

    ∇ r←∆ERX label ⍝ ⎕ERX in APLX
     ⍝ There are many problems with this program:
     ⍝ the line # given as arg is where control should be returned
     ⍝ in the calling program. For that to work ⎕TRAP should be local
     ⍝ and the trap set to  0 'C' '→nn' NOT  0 'E' '→nn' but
     ⍝ there is no way to localize ⎕TRAP above so using 'E' MAY
     ⍝ work but there is no guaranty.
      r←⎕TRAP ⍝ this is not a label
      :If 0∊1↑0⍴label ⍝ a number?
          :If 0∊label ⋄ ⎕TRAP←0⍴⎕TRAP
          :Else ⋄ ⎕TRAP←0 'E'('→',⍕label)
          :EndIf
      :Else
          ⎕TRAP←label ⍝ assume valid ⎕TRAP argument
      :EndIf
    ∇

    ∇ Z←data ∆EXPORT V;file;type;⎕IO
    ⍝ Emulate APLX ⎕export
      ⎕IO←1
      :If 1=≡,V ⋄ V←V({(-⊥⍨'.'≠⍵)↑⍵}V) ⋄ :EndIf ⍝ use extension as type if simple string
      file←1⊃V
      type←819⌶2⊃V ⍝ Lowercase
     
      1 ⎕NDELETE file
     
      :Select type
      :Case 'txt'
    ⍝ data can be anything. It must be formatted if not character already.
          :If 326≠⎕DR data
              data←1↓,(⎕UCS 13),⍕data
          :EndIf
          Z←data n_put file
      :CaseList 'utf8' 'utf-8' 'utf16' 'utf-16'
          type←(1+'6'=¯1↑type)⊃'UTF-8' 'UTF-16'
          data←⎕UCS type ⎕UCS data
          Z←data n_put file
      :CaseList 'csv' 'tsv'
          Z←LoadData.SaveTEXT data file(('csv' 'tsv'⍳⊂type)⊃',',⎕UCS 9)
      :Case 'xml'
          Z←(⊂⎕XML data)⎕NPUT file'utf-8'
      :Else
          'Unknown file type'⎕SIGNAL 11
      :EndSelect
      Z←0 0⍴0
    ∇

    ∇ r←{la}∆FDROP arg
    ⍝ ⍗ in APLX
      :If 900⌶⍬
          :If 0=1↓2↑arg ⍝ 0=drop last component
              ⎕FDROP(1↑arg),¯1 ⋄ r←1
          :Else
              'Unable to drop from middle of file'⎕SIGNAL 11
          :EndIf
      :Else
          .
      :EndIf
    ∇

    ∇ {r}←{opt}∆FHOLD fs
⍝ File resize/hold in APLX
      :If 900⌶r←0 0⍴0
          (1↓fs)⎕FRESIZE 1↑fs
      :Else
          ÷'hold not implemented'
      :EndIf
    ∇

    ∇ r←∆FI y ⍝ Emulate ⎕FI under APLX
      r←(1+⎕IO)⊃⎕VFI y
    ∇

    ∇ r←{opt}∆FREAD arg
⍝ ⎕← file fn
⍝ arg is {[LIBRARY]} FILE, COMPONENT {,USER, PASSWORD}
⍝ we only implement FILE (tie), CPT
      :If 900⌶⍬
          :If 0=1↑1↓arg ⋄ arg[1+⎕IO]←¯1+1↑1↓⎕FSIZE 1↑arg ⋄ :EndIf ⍝ 0 cpt= last cpt
          r←⎕FREAD arg
      :Else
          ÷'not implemented'
      :EndIf
    ∇

    ∇ {r}←data ∆FWRITE fc;file;cpt
⍝ File write in APLX
      r←⍬
      (file cpt)←fc
      :If cpt=0
          data ⎕FAPPEND file
      :Else
          data ⎕FREPLACE fc
      :EndIf
    ∇

    ∇ r←{env}∆GETCLASS name;⎕USING
⍝ ⎕GETCLASS in APLX
      :If 900⌶⍬ ⋄ env←'' ⋄ :EndIf
      :If '.net'≡env
          ⎕USING←''
      :EndIf
      r←⍎name
    ∇

    ∇ r←{timeout}∆HOST string;v;⎕ML
    ⍝ ⎕HOST in APLX
    ⍝ timeout feature is not enabled
      ⎕ML←1
      v←⊃⊃'.'⎕WG'APLVersion'
      :If ''≡string ⍝ return OS type
          r←('WLMA'⍳v)⊃'WINDOWS' 'LINUX' 'MACOS' 'AIX' '?unknown'
      :Else
          r←1↓↑,/(⎕UCS 13),¨⎕SH ((∊string)~'↑↓'),(v≠'W')/' 2>&1; exit 0'
          ⍝ Always on client, Never fail, return error messages as output
      :EndIf
    ∇

    ∇ Z←∆I ⍝ ⎕I (Idle) in APLX
      Z←⎕UCS 1
    ∇

    ∇ Z←∆IMPORT V;file;type;⎕IO ⍝ Emulate APLX ⎕import
      ⎕IO←1
      :If 1=≡,V ⋄ V←V({(-⊥⍨'.'≠⍵)↑⍵}V) ⋄ :EndIf ⍝ use extension as type if simple string
      file←1⊃V ⋄ type←819⌶2⊃V ⍝ Lowercase
     
      :Select type
      :Case 'txt'
          Z←n_get file
          :If 'W'=1 1⊃'.'⎕WG'aplversion'
              Z←(~¯1⌽Z⍷⍨⎕UCS 13 10)/Z ⍝ change CRLF into CR
          :Else
              ((Z=⎕UCS 10)/Z)←⎕UCS 13 ⍝ APLX return CR
          :EndIf
      :CaseList 'utf8' 'utf-8' 'utf16' 'utf-16'
          type←(1+'6'=¯1↑type)⊃'UTF-8' 'UTF-16'
          Z←n_get file
          Z←type ⎕UCS ⎕UCS Z
      :CaseList 'csv' 'tsv'
          Z←LoadData.LoadTEXT file(('csv' 'tsv'⍳⊂type)⊃',',⎕UCS 9)
      :Case 'xml'
          Z←⎕XML 1⊃⎕NGET file'UTF-8'
      :Else
          'Unknown file type'⎕SIGNAL 11
      :EndSelect
    ∇

    ∇ Z←∆L ⍝ Emulate APLX ⎕L
      Z←⎕UCS 10
    ∇

    ∇ r←∆LIB path;⎕ML;wild;⎕IO ⍝ Emulate APLX ⎕LIB
⍝ Extension: allows filtering of terminal node, e.g. ∆lib 'c:\temp\*.csv'
      ⎕ML←1 ⋄ ⎕IO←1
      wild←'*'∊path
      r←↑↑(⎕NINFO⍠1)path,((wild∨(¯1↑path)∊'/\')↓'/'),wild↓'*'
      r←(1+(≢path)-⌊/(⌽path)⍳'/\')↓⍤1⊢r
    ∇

    ∆LSHOE←{⍺←⊢ ⋄ ⎕ML←3 ⋄ ⍺⊂⍵} ⍝ ⊂

    ∇ r←∆M
      r←↑⍤0⊢'JANUARY' 'FEBRUARY' 'MARCH' 'APRIL' 'MAY' 'JUNE' 'JULY' 'AUGUST' 'SEPTEMBER' 'OCTOBER' 'NOVEMBER' 'DECEMBER'
    ∇

    ∇ r←∆MOUNT arg;id;sha;shm;max
    ⍝ Simulate ⎕MOUNT in APLX
      :If 0=⎕NC id←'#.APLX.⍙MOUNTS' ⋄ ⍎id,'←10 0⍴⎕a' ⋄ :EndIf
      :If 0∊⍴arg ⋄ r←⍎id
      :Else
          sha←⍴arg←(¯2↑1 1,⍴arg)⍴arg
          max←0 1×sha⌈shm←⍴r←⍎id
          r←(max⌈shm)↑r
          r[⍳⍴arg]←arg←(max⌈sha)↑arg
          ⍎id,'←r'
      :EndIf
    ∇

    ∇ Z←∆N ⍝ ⎕N in APLX
      Z←⎕UCS 1
    ∇

    ∇ r←∆NERROR
    ⍝ Similar to APLX ∆NERROR, but won't return the same texts
      :If 0=≢3⊃⎕DMX.OSError
          r←'Insufficient data available'
      :Else
          r←⎕DMX.Message,': ',(⎕IO+2)⊃⎕DMX.OSError
      :EndIf
    ∇

    ∇ {r}←data ∆NAPPEND arg;tieno;type;conv
    ⍝ Emulate APLX ⎕NAPPEND
     
      (tieno conv)←arg,(≢arg)↓0 0
     
      type←n_type conv
      data←data n_data conv
      data ⎕NAPPEND tieno type
      r←0 0⍴0
    ∇

    ∇ {file}∆NERASE tieno
    ⍝ Emulate APLX ⎕NERASE
      :If 900⌶⍬ ⍝ monadic case?
          :If 0=tieno←(⎕NNUMS,0)[(~∘' '¨↓⎕NNAMES)⍳⊂file←tieno] ⍝ tied already?
              tieno←file ⎕NTIE 0
          :EndIf
      :EndIf
      file ⎕NERASE tieno
    ∇

    ∇ r←∆NREAD arg;startbyte;count;conv;tieno;type;ix;bytes
    ⍝ Emulate APLX ⎕NREAD
     
      ⎕IO←1
      (tieno conv count startbyte)←arg,(≢arg)↓0 0 ¯1 ⍬
      type←n_type conv
     
      :If count≠¯1
          bytes←count×1+(count≠¯1)∧conv=5 ⍝ Double byte count for UTF-16
          r←⎕NREAD tieno type bytes,startbyte
      :EndIf
     
      :Select conv
      :Case 0 ⋄ r←∆av[1+⎕UCS r]
      :Case 4 ⋄ r←∆av[∆x4⍳r]
      :Case 5 ⋄ r←⎕UCS 256⊥⍉⌽(count 2)⍴⎕UCS r
      :Case 8
          'Element-counted UTF-8 not supported'⎕SIGNAL(count≠¯1)/11
          r←'UTF-8'⎕UCS ⎕UCS r
      :EndSelect
    ∇

    ∇ {r}←data ∆NREPLACE arg;tieno;type;conv;startbyte
    ⍝ Emulate APLX ⎕NREPLACE
     
      (tieno startbyte conv)←arg,(≢arg)↓0 ¯1 0
      type←n_type conv
      data←data n_data conv
     
      r←data ⎕NREPLACE tieno startbyte type
      r←0 0⍴0
    ∇

    ∇ {r}←data ∆NWRITE arg;tieno;startbyte;type;conv
    ⍝ Emulate APLX ⎕NWRITE
    ⍝ startbyte=-1 not supported yet
     
      :If 1∊⍴,arg ⍝ write as is
          r←data ⎕NAPPEND tieno
      :Else
          (tieno conv startbyte)←arg,(≢arg)↓0 0 ¯1
          type←n_type conv
          data←data n_data conv
     
          :If startbyte=¯2 ⋄ r←data ⎕NAPPEND tieno type
          :Else ⋄ r←data ⎕NREPLACE tieno startbyte type
          :EndIf
      :EndIf
      r←0 0⍴0
    ∇

    ∇ r←la ∆OV ra;src;nl ⍝ ⎕OV in APLX
      src←⎕IO⊃⎕NSI
      nl←{⍵.⎕NL⍳10}
      :Select la
      :Case 0
          r←#.⎕NS(src,'.')∘,¨↓ra
      :CaseList 2 1
          src ⎕NS ra ⋄ r←nl ra
      :Case 3
          r←nl ra
      :EndSelect
    ∇

    ∇ Z←∆R  ⍝ Emulate APLX ⎕R
      Z←⎕UCS 13
    ∇

    ∆RSHOE←{⍺←⊢ ⋄ ⎕ML←2 ⋄ ⍺⊃⍵} ⍝ ⊃

    ∇ r←{opt}∆SS arg;text;from;to;type;flags;fix;⎕IO;norm;⎕ML;add1;search;io;show
⍝ Mimic APLX' ⎕ss function
⍝ arg is a 2 (search) or 3 (replace) element
      :If 900⌶0 ⋄ opt←0 ⋄ :EndIf  ⍝ simple search
      ((show type) flags)←2↑opt,4 ⍝ advance by 1 after search
     
      (text from to)←3↑arg,0
      fix←⊢
      :If norm←type=0  ⍝ turn regex meta char x into \x
          fix←'{}[]()\^$|.?*+'∘{(⍵,b/'\')[⍋⍋b←≠\b/⍨1+b←⍵∊⍺]}
          :AndIf 0=10|⎕dr to 
          to←(1+'\'=to)/to
      :EndIf
      show←0,norm↓1    ⍝ return also length for regex
      add1←1,norm↓0    ⍝ for ⎕IO adjustment later
      :If 1=≡,from ⋄ from←fix from
      :Else ⋄ from←fix¨from ⋄ show,←3 ⍝ show pattern number too
          add1,←1
      :EndIf
     
      ⎕IO←0 ⋄ ⎕ML←1
      :If search←to≡0
          fix←from ⎕S show
      :Else
          fix←from ⎕R to
      :EndIf
      :If flags>0
          flags←⌽(9⍴2)⊤flags
          fix←fix ⎕OPT(0⊃flags)     ⍝ case insensitive?
          fix←fix ⎕OPT'ML'(1⊃flags) ⍝ stop after 1st
          :If search
              fix←fix ⎕OPT'OM'(2⊃flags) ⍝ advance by 1?
          :EndIf
          fix←fix ⎕OPT'Mode'(0⊃((type=0)∨3⊃flags)⌽'LM') ⍝ Line or Mixed mode?
      :AndIf 1=1↑type
          fix←fix ⎕OPT'DotAll'(4⊃flags) ⍝ . matches all?
         ⍝ Return all matches for multiple searches are ignored
          fix←fix ⎕OPT'EOL'((flags[6 7]⍳1)⊃'CR' 'LF' 'CRLF')
      :EndIf
     
      r←↑fix text
    ⍝ We need to adjust for the caller's ⎕IO
      :If search
          :If ⎕THIS=1⍴⎕RSI ⋄ io←1↑3⊃⎕STATE'⎕io'
          :Else ⋄ io←⎕RSI[0].⎕IO
          :EndIf
          r←r+(⍴r)⍴add1∧io
      :EndIf
    ∇

    ∇ r←∆TIME
      r←,'G<9999-99-99 99.99.99>'⎕FMT 100⊥6⍴⎕TS
    ∇

    ∆UP←{⍺←⊣ ⋄ ⎕ML←2 ⋄ ⍺↑⍵} ⍝ ↑

    ∇ r←∆VI y
      r←⎕IO⊃⎕VFI y
    ∇

    ∇ r←∆W
      r←↑⍤0⊢'SUNDAY' 'MONDAY' 'TUESDAY' 'WEDNESDAY' 'THURSDAY' 'FRIDAY' 'SATURDAY'
    ∇

    ∇ r←∆WSSIZE
      r←2000⌶16
    ∇

    ∇ type←n_type conv;⎕IO;ix
    ⍝ Convert APLX native file conversion codes
    ⍝ conv 325 and 643 (=7) not suppported
      ⎕IO←1
      :If conv∊11 82{⍺,⍵,-⍵}163 323 645
          type←|conv
      :Else
          type←(10⌊1+|conv)⊃80 11 323 645 80 80 0 0 80 0
          'Unsupported conversion type'⎕SIGNAL type↓11
      :EndIf
    ∇

    ∇ data←data n_data conv;ix
    ⍝ Convert data for native file write
     
      ⎕IO←1
      :Select conv
      :Case 0 ⋄ data←⎕UCS ¯1+∆av⍳data
      :Case 4 ⋄ data←∆x4[∆av⍳data]
      :Case 5 ⋄ data←⎕UCS,⌽⍉256 256⊤'UTF-16'⎕UCS data
      :Case 8 ⋄ data←⎕UCS'UTF-8'⎕UCS data
      :EndSelect
    ∇

    ∇ r←n_get filename;tn
      tn←filename ⎕NTIE 0
      r←⎕NREAD tn 80(⎕NSIZE tn)0
      ⎕NUNTIE tn
    ∇

    ∇ r←data n_put filename;tn
      tn←filename ⎕NCREATE 0
      r←data ⎕NAPPEND tn 80
      ⎕NUNTIE tn
    ∇


    :Namespace LoadData
⍝ Functions copied from distributed workspace LoadData.dws

        ∇ data←LoadTEXT params;file;string;cr;Quote;tmp;sep;⎕ML;⎕IO;vi;Sep;fget;nested;filename;specialchars;NL;CR;cols;header;rows;ncol;lCase;criteria;if;isChar;n;csv;text;num
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
          lCase←819⌶
         
          ⎕IO←⎕ML←1 ⋄ (NL CR)←⎕TC[2 3]         ⍝ --- local variables ---
          params←,{⊂⍣(1=≡,⍵)⌷⍵}params ⍝ nest if only a filename (string) as argument
         
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
          fget←{z←¯1↓1⊃⎕NGET ⍵}
         
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

        ∇ rc←{options}SaveTEXT params;file;⎕ML;⎕IO;NL;CR;lCase;if;isChar;CRLF;LF;data;fdel;rdel;stream;sz;tie;win;Q
⍝ Save data to a TEXT file                                   danb 2008 V1.1
         
⍝ Arguments are:  Data Filename [Separators]
⍝ The default separators is ',' CRLF (for Windows, NL for Unix)
⍝ If the separator is found in the data it is enclosed in '"', therefore '"' must NOT appear in the data.
⍝ If a fixed length is instead given for each column then any character may exist in the data.
⍝ It will complain if anything seems out of order.
         
⍝ The options are: 0 (default): create new file, 1:overwrite if necessary
⍝ The function returns 0 if all went well or a return code (1=file exists)
         
⍝ Example:
⍝   SaveTEXT data '\temp\myfile.csv' ';'           ⍝ CSV file using ';' as delimiter
⍝   SaveTEXT data '\temp\myfile.txt' ',' LF        ⍝ , delimited file using LF as record delimiter
⍝   SaveTEXT data '\temp\myfile.wxyz' (23 32 21)   ⍝ fixed width delimited file using CRLF as record delimiter
⍝   SaveTEXT data '\temp\myfile.wxyz' (3 9 8) 133  ⍝ fixed width delimited file using #133 as record delimiter
         
          if←/⍨                       ⍝ --- local fns ---
          isChar←{0 2∊⍨10|⎕DR 1/⍵}
          lCase←{n←⍴l←'abcdefghijklmnopqrstuvwxyz' ⋄ ⎕IO←0 ⋄ ~∨/b←n>i←⎕A⍳s←⍵:⍵ ⋄ (b/s)←l[b/i] ⋄ s}
         
          ⎕IO←⎕ML←1                   ⍝ --- local variables ---
          win←'W'∊⊃⊃'.'⎕WG'aplversion'
          (CR LF)←CRLF←⎕UCS(~win)↓13 10 ⋄ Q←'"'
          (data file fdel rdel)←params,(⍴params)↓0 0 ','CRLF ⍝ 4 arguments
         
          :If 0∊⍴data
              stream←''
          :Else ⍝ something to do
              :If isChar fdel
                  data←{∨/(fdel,Q)∊⍵:Q,((1+Q=⍵)/⍵),Q ⋄ ⍵}¨⍕¨data ⍝ add double quotes around
                  data←1↓¨,/fdel,¨data
              :Else
                  sz←⍴data←(¯2↑1,⍴data)⍴data ⍝ ensure matrix
                  fdel←fdel×¯1*~isChar¨data[⊃sz;] ⍝ better be all the same
                  data←,/(sz⍴fdel)↑¨data
              :EndIf
    ⍝ If the record separator is numeric we turn it into text
              :If ~isChar rdel ⋄ rdel←⎕UCS rdel ⋄ :EndIf
              stream←(⍴,rdel)↓∊rdel∘,¨data
          :EndIf
         
⍝ This version does without .Net
          rc←1
          :Trap 22
              :If 0=⎕NC'options' ⋄ options←0 ⋄ :EndIf
              :If 1∊options
                  {22:: ⋄ ⍵ ⎕NERASE ⍵ ⎕NTIE 0}file
              :EndIf
              tie←file ⎕NCREATE 0   ⍝ the file must NOT exist
⍝ Change the stream into UTF-8 format
              stream←¯17 ¯69 ¯65,{⍵-256×127<⍵}'UTF-8'⎕UCS stream
⍝ Write out
              stream ⎕NAPPEND tie 83
              ⎕NUNTIE tie
              rc←0
          :EndTrap
        ∇

    :EndNamespace ⍝ LoadData

    ⍝ Things to watch for:
    ⍝ ⊣ is {6::z←0 0⍴0 ⋄ ⍺}
    ⍝ ⎕CL is (⍬⍴⎕lc)
    ⍝ ⎕CLASSES is (⎕nl-9.4 9.6)
    ⍝ ⎕ERS is 99 ⎕SIGNAL⍨...
    ⍝ ⎕ERX X is ⎕TRAP←0 'E' ('→',⍕X) with ⎕trap localized


:EndNameSpace
