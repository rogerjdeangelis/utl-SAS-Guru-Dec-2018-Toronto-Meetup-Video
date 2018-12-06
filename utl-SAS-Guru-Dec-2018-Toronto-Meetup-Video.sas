SAS Guru Dec 2018 Toronto Meetup Video

Part1
https://www.dropbox.com/s/dinhiqt3zik7af4/camtst.zip?dl=0

Part2
https://www.dropbox.com/s/nr7v7hwrakh7f66/camtst2.zip?dl=0


                  Server and Workstation.
               The SAS best of both worlds.

Details
https://github.com/rogerjdeangelis
https://www.youtube.com/channel/UCUzsiGhcv3OFovLJTazTc2w

Logitech G203 Prodigy Gamming Mouse
Driver: SetPoint6.67.83_smartw10

I don't have time to show the workstation connection to the unix server.
Most of what is below applies to both the workstation and server.
This includes mouse buttons and command macros.

 I. Big data and Big Computation (server space)

     Working definition of big data and big computation?

     Big data involves a single table over 1TB
     Big Computation 64 cores at over 20 percent system utilization for a week.

     A server can provide data for the workstation.

 2. Hardware: Server and Workstation.

  a  Server: Large Linux data warehouse 1000 cores and
     samba disk storage appliance. (no VM Virtual Machines)

  b  Workstation: 64gb ram, 8 cores,
     dual raid 0 arrays and SPDE disk storage appliance(partitioned files).


 3.  Workstation Software

  a  SAS 9.4M2 64bit(Base, Graph, Stat and Connect)
  b  Vanillia R CRAN 64bit
  c  Microsoft R with Math Kernel Library (Intel MKL)
  d  Python 2.7 and 3.5 64bit
  e  Strawberry PERL
  f  Ghostscript (better than Adobe Acrobat?)


 4. Server Software

  1. SAS  9.4M2 64bit
     (Base, Graph, Stat and Connect)
  2. Vanillia CRAN R 64bit
  3. Python 2.7 and 3.5 64bit
  4. PERL (usually part of the operating system)


 5. Benchmarks workstation and server (22gb SAS table)

    BENCHMARKS  (query a 22gb table for 10,000 records)

                                            $800
                                    Server  2008 Dell T7400
                                     EG     Workstation
     SPDE(free with base sas)
     SDS not available in EG?
     SQL query (with SPDE index)     N/A*    0.45 ** best parallel index

     SASFILE(I have 64gb ram)
     SQL query (no index)            N/A**   4.30 ** no index!!

     Create data (22gb)              355      129
     Sort data                       331      181
     Index data (create)              51**    111

     sql query (with index)         2.12**   2.78
     sql query (without index)     10.74    10.59

                                   EG Grid   SYSTASK(no grid)
     Job (4 tasks)*                  99       114

     WORKSTATION GRID (no need to run)

     Workstation 4 simultaneous systasks
     after EG VM enhancement I can only run 3 - due to VM solitary confinement)

     options noxwait noxsync;
     %let tym=%sysfunc(time());
     systask kill sys1 sys2 sys3 sys4;
     systask command "&_s -termstmt %nrstr(%query(1);) -log d:\log\a1.log" taskname=sys1;
     systask command "&_s -termstmt %nrstr(%query(2);) -log d:\log\a2.log" taskname=sys2;
     systask command "&_s -termstmt %nrstr(%query(3);) -log d:\log\a3.log" taskname=sys3;
     systask command "&_s -termstmt %nrstr(%query(4);) -log d:\log\a4.log" taskname=sys4;
     waitfor sys1 sys2 sys3 sys4;
     %put %sysevalf( %sysfunc(time()) - &tym);?


 6, Folder Setup unix and windows (for new cliical trial token 'dna' childhood cancer trial;

    d:/dna (sas output objects in parent)

      d:/dna/xls
      d:/dna/doc
      d:/dna/csv
      d:/dna/shp
      d:/dna/pdf
      d:/dna/zip
      d:/dna/png
      d:/dna/xml
      d:/dna/htm

     SAS tables are stored in d:/dna

      dna_100getDem.sas7bdat (c:/utl/dna_100getDem.sas created the table)
      dna_200getLab.sas7bdat (c:/utl/dna_200getLab.sas created the table)


 7. Self locating files

   d:/dna/xml/dna_cdisc.xml

   I know dna_cdisc.xml came from d:/dna/xml
   because dna is the parent and xml is the subfolder

   After database lock rename

   d:/dna => d:/dna_childhood_cancer (all programs will not run - good)


 8. SAS invocation

    You need these folders before invoking SAS

    a. c:/utl (for all SAS code). I have 40 years of code in here.
       Tokens are used to catagorize programs

       dna_100getDem.sas  (cancer trials)
       rna_100getDem.sas  (diabetes trials)

    b. c:/oto (autocall library and autoexec file)
    c. c:/etc (sasuser.profile)
    d. c:/cfg (configuration settings)
    c. c:/wrk (SAS work ligrary)

    c:\sashome\SASFoundation\9.4\sas.exe
    -work c:\wrk
    -sasuser c:\etc
    -RLANG
    -autoexec c:\oto\autoexec.sas
    -sasinitialfolder  .         /* c:/utl is defined on icon */
    -nosplash
    -autosaveloc c:\ver\pgm.sas  /* auto save every minute to this folder */
    -config c:\cfg\config.cfg
    -nodmsexp                    /* turn off explorer */
    -sasautos c:\oto
    -awscontrol notitle
    -emailsys SMTP

     After invocation you need to make many chages to clean up
     the interface. You need to hide EE editor.
     You can turn off the horizontal scroll bar. I use F3 and F4 for left right


 9. AUTOEXEC

    Nice things to have in your autoexec

    %inc "&_o/utl_perpac.sas"; * performace package - command macros;

    options ls=171 ps=65 cmdmac nofmterr nocenter nodate
           nonumber noquotelenmax validvarname=upcase
           compress=no FORMCHAR='|----|+|---+=|-/\<>*';

    ods results off; /* never use this - clutters up */

    * useful macro variables;

    %let lettersq=%str(
       "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O",
       "P","Q","R","S","T","U","V","W","X","Y","Z");

    %let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;

    %let numbersq=%str("1","2","3","4","5","6","7","8","9","10");

    %let numbers=1 2 3 4 5 6 7 8 9 10;

    %let monthsq=%str("JAN" ,"FEB" ,"MAR" ,"APR" ,"MAY" ,"JUN"
                ,"JUL" ,"AUG", "SEP" ,"OCT" ,"NOV" ,"DEC");

    %let months=JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC;

    options fmtsearch=(work.formats mta.mta_formats_v1f mta.var2des);

    options cmplib=work.functions; /* swap pairs of variables */
    proc fcmp outlib=work.functions.swap;
    subroutine swapn(a,b);
    outargs a, b;
        h = a; a = b; b = h;
    endsub;
    subroutine swapc(a $,b $);
    outargs a, b;
        h = a; a = b; b = h;
    endsub;
    run;quit;

    /*
     data _null_;
       one='two';
       two='one';
       put one= / two= //;
       call swapc(one,two);
       put one= / two=;
     run;quit;


     ONE=two
     TWO=one

     After swap

     ONE=one
     TWO=two

    */

   * missing populated format;
   proc format;

      value num2mis
       . = 'MIS'
       0 = 'ZRO'
       0<-high = "POS"
       low-<0 = 'NEG'
       other='POP'
       ;

       value $chr2mis
       'Unknown',' ','UNK','U','NA','UNKNOWN',
       'Missing','MISSING','MISS' ='MIS'

       other='POP'
     ;
   run;quit;

   * pop off a word from the start or end of string;

   proc fcmp outlib=work.functions.pop;
      Subroutine utl_pop(string $,word $,action $);
          outargs word, string;
          length word $4096;
          select (upcase(action));
            when ("LAST") do;
              call scan(string,-1,_action,_length,' ');
              word=substr(string,_action,_length);
              string=substr(string,1,_action-1);
            end;

            when ("FIRST") do;
              call scan(string,1,_action,_length,' ');
              word=substr(string,_action,_length);
              string=substr(string,_action + _length);
            end;

            otherwise put "ERROR: Invalid action";

          end;
      endsub;
   run;quit;

   /* POP OFF

   data _null_;
     str="MIN QTR1 MEDIAN QTR3 MAX";
     ret=str;
     call utl_pop(str,ret,"first");
     put ret= str=;
     call utl_pop(str,ret,"last");
     put ret= str=;
   run;quit;

   str="MIN QTR1 MEDIAN QTR3 MAX";

   POP first word off  RET=MIN    STR= QTR1 MEDIAN QTR3 MAX
   POP last word off   RET=MAX    STR= QTR1 MEDIAN QTR3

   */

    * Recall last program in program editor;
    dm "home;pgm;home;copy pgm_last";



 10. You need the 1980s classic editor for most ofthe following.
     Some functions will not work in (EE, UE, EG, SAS Studio, on Demand ...)
     Some SAS editor scripting is disabled on all these editors(store command)

     Your editor needs to look like (unable to remove solutions tab)

     +---------------------------------------------+
     | file edit view tools solutions window help  |
     --------------------------------------------- +
     | Program - Editor utl_100getDem.sas          |
     +---------------------------------------------+
     Command ===>
     00001
     00002
     00003
     ....

 11. Classic Editor Top Productivity Tools

  1. Two or three 27in screens
      A second program editor identical to first 'note g'

  2. $29 programmable 6 button logitech mouse (20 actions)
     Completely programmable.

  3. Cheat sheets taped above function keys (have to have)

  4. Quickly submit this code 5 times for 5 tables

     %let idx=%eval( 0&idx + 1);
     data class&idx;
       set sashelp.class;
     run;quit;

     proc datasets lib=work;
      delete class:;
     run;quit;

                   Member
     #  Name       Type

     1  CLASS1     DATA
     2  CLASS2     DATA
     3  CLASS3     DATA
     4  CLASS4     DATA
     5  CLASS5     DATA


 12. Magic string (will unfreeze a frozen SAS)

     1.  Place cursor anywhere in program editor
     2.  Hit pf12 highlight and submit


     * setup;

      keydef "F12" '~;;;;/*''*/ *);*};*];*/;/*"*/;%mend;run;quit;%end;end;run;endcomp;%utlfix;";

      Put the macro below in your autocall library.
      Turn on 'options cmdmac'

      %macro utlfix(dum);

      * fix frozen sas and restore to invocation ;
       dm "odsresults;clear;";
       options ls=171 ps=65;run;quit;
       ods listing;
       ods select all;
       ods graphics off;
       proc printto;run;
       goptions reset=all;
       endsubmit;
       endrsubmit;
       run;quit;
       %utlopts;

      %mend utlfix;

 13. VERSIONING

    First set autosave to 1 minute.

    If I press down on middle mouse button here is what happens

    program saved in

      c:/utl/dna_100getDem.sas

      also timstamped and saved in

      d:/ver/dna_100getDem34676.sas  /* timestamp will change when run again */


 14. Print first 40 obs to clipboard and output window)

     Last Dataset          SHIFT RMB
     Highlighted dataset   CTL RMB

 15. Proc contents

     Last Dataset          SHIFT LMB
     Highlighted dataset   CTL LMB

 16. FRQ proc freq (sex*age)

     Last Dataset         On command line FRQ sex*age
     Highlighted dataset  On command line FRQH sex*age

    UNIX (rsubmitted code)

     Last Dataset         On command line FRQX sex*age
     Highlighted dataset  On command line FRQXH sex*age

 17. AVGH proc means

     Highlighted dataset class  On command line

     Command ===>
     00001 %let pgm=dna_100getDem;
     00002
     00003  data class;
     00003    sashelp.class;
     00003  run;quit;
     00003

     Variable     N     Sum          Mean   Minimum  Quartile Median  Quartile  Maximum
     ----------------------------------------------------------------------------------
     AGE         19     253.0        13.3     11.0     12.0    13.0      15.0    16.0
     HEIGHT      19    1184.4        62.3     51.3     57.5    62.8      66.5    72.0
     WEIGHT      19    1900.5       100.0     50.5     84.0    99.5     112.5   150.0
     ----------------------------------------------------------------------------------

 19. SUMH - Highlight a column of numbers and type sumh on the command line

     Command ===>
     00001 %let pgm=dna_100getDem;
     00002
     00003 1
     00004 2
     00005 3
     00007 4
     00009 5
     00010 6
     00011 7
     00012
     ....


     N      Sum       Mean    Minimum   Quartile   Median   Quartile   Maximum
     --------------------------------------------------------------------------
     7      28.0       4.0       1.0       2.0       4.0       6.0       7.0
     --------------------------------------------------------------------------


  20. EVLH - Highlight a formula and type evlh on command line

     Command ===>
     00001 %let pgm=dna_100getDem;
     00002
     00003  10*sqrt(9)*constant('PI')

     RESULT=94.247779608


  21 SHF MMB - Print middle observation vertically

     Command ===>
     00001 %let pgm=dna_100getDem;
     00002
     00003 data class;
     00004   set sashelp.class;
     00005 run;quit;
     00007

     Middle Observation(9 ) of sashelp.class - Total Obs 19

      -- CHARACTER --

     NAME       C8       Jeffrey
     SEX        C1       M
     TOTOBS     C16      19

      -- NUMERIC --

     AGE        N8       13
     HEIGHT     N8       62.5
     WEIGHT     N8       84

 18. CUTH - Reducing spacing to one space

     Highlight and type cuth on the command line
     Command ===>
     00001 %let pgm=dna_100getDem;
     00002
     00003 data &pgm.Cut;
     00004  input a     b         d;
     00005 cards4;
     d
     00007 1    2     3  4
     d
     00009 2 4    6   8
     00010 ;;;;
     00011 run;quit;
     00012

     Command ===>
     00001 %let pgm=dna_100getDem;
     00002
     00003 data &pgm.Cut;
     00004  input a b d;
     00005 cards4;
     00007 1 2 3 4
     00009 2 4 6 8
     00010 ;;;;
     00011 run;quit;
     00012
     ....


 22. XPY - Exploded text ito clipboard for pasting  (Python code on command line)

     Command ===> xpy input
     00001 %let pgm=dna_100getDem;

     *_                   _
     (_)_ __  _ __  _   _| |_
     | | '_ \| '_ \| | | | __|
     | | | | | |_) | |_| | |_
     |_|_| |_| .__/ \__,_|\__|
             |_|
     ;

 23.  Command macro cheat sheet

  Here is sample of the utilities in the package  (* most used or most critical)
  You can build on these macros they are just minimal SAS code.

    avgh     proc means last dataset
    cnt      unique cnt name*sex - last dataset number unique combinations
    cnth     unique cnt name*sex - hi-lited dataset
    cntv     cnt hi-lited variable last dataset
    con      contents last dataset
    conh     contents hi-lited dataset
   *debugh   macro debug hi-lited
   *dmp      contents with sample data
   *dmph     contents with sample data hi-lited dataset
   *frq      freq sex*age last dataset
   *frqh     freq sex*age hi-lited dataset
    frqv     freq hilited variable last dataset
    iota     column of consecutive integers
   *ls40     40 obs last dataset
   *ls40h    40 obs hi-lited dataset
    lsal     all obs last dataset
    parh     does hi-lited code have matched paraentheses
    proch    syntax for the proc - hi-lite 'proc reg' and get syntax with example
   *prtw     prtw 'sex="M"' - last dataset subset printed
   *prtwh    prtw 'sex="M"' - hi-lited dataset subset printed
    sumh     statistics on hi-lited column of numbers
    sumv     statistics on hi-lited variable last dataset
    unv      proc univariate on variable in last dataset
    vu       viewtable last dataset
    vuh      viewtable hi-lited dataset
   *xlsh     view and edit hi-lited dataset in excel (may need a sleep w slow systems)
   *xplo     xplo SUBaSUM put exploded chars in past buffer


 24. SAS provided commands

    ?          - previous command history IMPORTANT - asked SAS many years ago

    subtop     - submit top line of editor
    bounds 1 64 -
    icon
    rchange    - change on function key hit
    rfind      - find on function key hit
    save  prg       /# save program in your profile  ie pgm.source #/
    copy  prg       /# recalls program from your profile #/
    change     - c today yesterday ic all   ( ignore case all)
    cols
    reset
    keys
    top
    bot
    n           - go to line n
    left  n
    right  n
    spell all - check spelling of all words in editor
    autoadd   - add aline at a time to editor ( usewith mask and bounds )
    vscroll 25 - set scroll amounts for forward and backward
    hscroll 10
    backward max n
    forward max  n
    bounds
    mask
    copy
    paste
    find - f 'data' first last next prev prefix suffix word
    find 'Mac' prefix
    change - c todat yesterday ic all
    rchange - change on function key hit
    rfind   - find on function key hit
    mark - highlight string, lines for submit or edit
    mark block - highlight rectangle within editor
                 does not have to be full lines
    store    * disabled in all future editors (load and store are critical instructions)
    zoom z
    up 2
    down 4
    CAPS on/off
    home
    cursor
    curpos
    nums on/off
    %let
    vt
    pmenu off /# functon key #/
    pmenu on
    end
    print
    submit
    unmark unmark all
    tabs
    redo
    undo cntrl z
    nums on/off
    keys
    fse
    fsv sashelp.class
    fsb

    libn
    filen
    dir
    vt
    print

    copy profile.it.source profile.it1.source

    %input              dlgsave               wdockviewresize
    %window             dlgsmail              wdockviewrestore
    window              file                  wedit
    proc pmenu          fileopen              wemailfmt
    proc fslist         fill                  wexitsave
    proc fsprowse       gsubmit               wfile
    proc fsletter       home                  whidecursor
    proc fsedit         icon                  whsbar
    autoscroll          include               winsert
    awsmaximize         pmenu                 wmenupop
    awsminimize         store                 wmru
    awsrestore          subtop                wnavkeyunmark
    caps                toolclose             wnewtitle
    color               tooledit              wnextedit
    command             toollarge             wpaste
    cut                 toolload              wpgm
    dlgabout            toolswitch            wpopup
    dlgcdir             tooltips              wrtfsave
    dlgcolumnsize       wattach               wscreentips
    dlgcolumnsort       wattention            wstatusln
    dlgconvert          wautosave             wundo
    dlgendr             wbrowse               wvsbar
    dlgfind             wcopy                 wwindowbar
    dlgfont             wcut                  zoom
    dlglib              wdockview
    dlglinks            wdockviewminimize
    dlgopen
    dlgpagesetup
    dlgpref
    dlgprt
    dlgprtpreview
    dlgprtsetup
    dlgreplace
    dlgrun


 PREFIX EDITING COMMANDS

  The prefix area  Many of these commands can be put on function keys using a ':', ie :ts.
  SAS is slowly removing some of these functions from theclassic editor?

  D        Delete current line
  I        Insert a line here
  C        Copy current line
  D99----  Delete next 99 lines (also could cut with mouse)
  I999---  Insert 999 blank lines useful when autoadd is set
  IB55---  Insert 55 lines before
  C3-----  Copy next three lines to some target
  A000102  Target for line copy or include file (copy after)
  B000102  Target for line copy or include file (copy before)
  M------  Move this line somewhere
  M3-----  Move next 3 lines somewhere
  O3-----  Move source lines over these lines
  R3-----  Replicate the next 3 lines

  DD00103  Block delete   CC00103  Block Copy    MM00103  Block Move
  0000104                 0000104                0000104
  DD-----                 CC-----                MM-----

  OO00103  Target Over    RR3----  Block Replicate
  0000104                 0000104
  OO-----                 RR-----

  (4-----  Shift left first 4 columns into bit bucket (distructive shift)
  )4-----  Shift right first 4 columns (distructive shift)
  >5-----  Nondistructive shift right
  <5-----  Nondistructive shift left
  >>5----  Non distructive shift right of a block of commands
  <<,)),(( Similar to single character versions
  UC----- Upper case line  - more useful on function key as :UC
  UC26--- Upper case next 26 lines
  LC----- Lower case line
  LC26    Lower case next 26 lines
  LLC---- Block of lines -lower caSE
  UUC
  TF----- Text flow lines until blank line
  TS----- Text split at cursor better on function key as :tf
  JR-----  Justify right a single line
  JL-----  Justify left a single line
  JJR----  Justify right a block of lines
  JJL----  Justify left a block of lines

scripting

   store    * disabled in all future editors (load and store are critical instructions)
   zoom z
   up 2
   down 4
   CAPS on/off
   home
   cursor
   curpos
   nums on/off
   %let
   vt
   pmenu off /# functon key #/
   pmenu on
   end
   print
   submit
   unmark unmark all
   tabs
   redo
   undo cntrl z
   nums on/off
   keys
   fse
   fsv sashelp.class
   fsb

   libn
   filen
   dir
   vt
   print
   copy profile.it.source profile.it1.source

  Classic SAS Integrated Development Environmemt

  5 Button MOUSE($29) (All mouse keys can also be executed using the command line)

  4. RMB - Right Mouse Button
     a. RMB Submit program window or automatically submit highlighted code
     b. SHF RMB put print of 40 obs from LAST dataset into clipboard
     c. CTL RMB Print 40 obs from HIGHLIGHTED dataset

  5. MMB - Middle Mouse Button
     a. MMB Versioning
     b. SHF MMB print vertically middle ob of LAST dataset
     c. CTL MMB Print vertically middle ob  HIGHLIGHTED dataset
     d. ALT MMB SAS data view of highlighted dataset

  6. MMB2- Middle Mouse Button
     a. MMB2 Proc means HIGHLIGHTED dataset
     b. SHF  MMB2 Put print ALL obs from LAST dataset into clipboard
     c. CTL  MMB2 Print ALL from HIGHLIGHTED dataset
     d. ALT  MMB2 Data view HILITED dataset

  6. LSB- Left Sde Button
     a. LSB Debug highlighted macro
     b. SHF LSB Contents last dataset
     c. CTL LSB Contents HIGHLIGHTED dataset
     d. ALT LSB HIGHLIGHTED dataset to excel

  6. RSB- Left Sde Button
     a. RSB Magic string
     b. SHF RSB Freq all variables last dataset
     c. CTL RSB Distinct levels last dataset
     d. ALT RSB Univariate last dataset


      **************************************
     *                                       *
    *                                         *
   *                                           *
   *   LMB                    RMB              *
   *                                           *
   *   FOCUS & POINTING       SUBMIT           *
   *   BLOCH SUBMIT          SHF RMB ls40a     *
   *                         CTL RMB ls40ha    *
   *        MMB                                *
   *                                           *
   *        MMB(F1) Verson                     *
   *        SHF MMB(F1) dmpa                   *
   *        CTL MMB(F1) dmpha                  *
   *        ALT RMB(F1) vuh                    *
   *                                           *
   *        MMB2                               *
   *                                           *
   *        MMB2 avgha                         *
   *        SHF F2 lsala                       *
   *        CTL F2 lsalha                      *
   *        ALT F2 vua                         *
   *                                           *
   *                                           *
   *   LEFT SIDE BUTTON     RIGHT SIDE BUTON   *
   *                                           *
   *   RSB(F11)             RSB(F12)           *
   *   LSB debugha          F12 magic string   *
   *   SHF F11 cona         SHF F12 frqva      *
   *   CTL F11 conha        CTL F12 cntva      *
   *   ALT F11 xlsha        ALT F12 unva       *
   *                                           *
    *                                          *
     *                                        *
      ***************************************;


EG FUNCTIONALITY VERSUS POWER WORKSTATION


EG is an excellent platform for non-programmers but is anthema
for programmers and program development.

EG is useful for grid processing of big data(single table > 1TB)
and big computation(64 cores with 10% cpu utilization for over 8hrs) and as a data
server for power worstations.

COMPARISON
===========

Process flow and long complex batch runs are
not the domain of SAS they are the domain of operating
system or Perl scripts.

Classic SAS on a Power workstation versus EG on a large server

EG functionality versus Ppower workstation
(I am biased)


                     *************
                 ****CLASSIC SAS  ****
              ***    ===========      ***
            **   Command line  more ram  **

          **  Command macros  cores/user   **

         *         Notepad editors           *

        *    Xcmd       Proc R  Perl   IML/R  *

      **  sas code in clear text               **

      *  Proc python      Stop running program  *

     *    Task manager  Single click versioning  *

    ** Streaming log     ***    Fewer freezes     **

    * Command pipes   **     ** Multiple cursors   *

    * Less downtime ***        **    Function keys  *

    * No lockdown  **           ** No code loss Upg *

    * Window       **            *  Libname excel   *

    * %Window      *     EG       *More screen avail*

    * Magic String *     ==      *  Passthru excel   *

    * download/ftp  *           **                  *

    ** Email interfa **        ** No code wrapper  **

     *   Pmenu        **     ** No hidden mac vars *

      *Fse/fsv.fsbroese  *** editor prefix area   *

      ** Easy and freqent upgrade and hotfix   **

        * Fast column and table dictionaries  *

         * No lousy EG generated code(SQL)   *

          **  Programmable mouse           **

            ** Capture editor text      **

              ***  Editor scripts     ***

                ****             ****
                    *************

*                     __
 _ __ __ _ ___ _ __  / _|___
| '__/ _` / __| '_ \| |_/ __|
| | | (_| \__ \ |_) |  _\__ \
|_|  \__,_|___/ .__/|_| |___/
              |_|
;

Server and/or local power workstation

How to detemine if a SAS local power workstation would benefit you
as a SAS programmer over an EG server.

The first question to ask is how often do you need to access a database schema where one
or more tables are over 1TB. I define big data as computing problems where most
of a users programming involves tables over 1TB. The other place for larger serves is
massive simulations or parallelism over 64 concurrent jobs. Workstations are available
with 64 cores.

Should I use just the server or a sever plus workstation(or power laptop) for my SAS programming.
Systems like Tableau, Oracle, Teradata, Midas and the IDR do not run well on a workstation.

This is how IBM used to measure overall mainframe usability.

  1. Reliability - Do you get the answer you expect.
  2. Availability.
  3. Serviciability
  4. Performance
  5. Functionality
  6. Security

I use either excel or SAS running on both platforms for comparisons.

  1. Reliability.
      There was a bug in SAS 9.3 where 'proc distinct' gave the wrong answer for very high
      carinality.
         Workstation: I downloaded the fix from SAS and installed it on my workstation in 30 minutes
         Server:      Reported it a couple of months ago and it is still not fixed

  2. Availability.
      Workstation: 99.9%
      Server:      75% (Mostly due to the fact that you need an internet connection and scheduled
      and non scheduled availability

  3. Serviceability:
      Workstation: I added a second esata III SSD to my laptop in 2 minutes
      Server: Generally mot possible

  4. Performance
      Workstation: Much more ram,RAID 0 SSD drives and 100% of the XEONs. Very fast response time
                   not like a server dial-up connection
      Server: Little Ram, SAN spinning raid 5 drives

  5. Functionality
      Workstation: You have an operating system, R, Python, Ghostscript, Perl, C, Java...
                   ODBC(excel access...), more disk space(Try getting 5TB ob the server)...
      Server:      Generally locked down most of the above not available.

  6.  Security
       Workstation: Only have a subset of data. Local and disk encryption.
       Server: Has the jewels so obviously a better targer for hackes.

 *_
| | _____ _   _ ___
| |/ / _ \ | | / __|
|   <  __/ |_| \__ \
|_|\_\___|\__, |___/
          |___/
;


MY FUNCTION KEY SETUP (REQUIRES a Programable Mouse)

Suggest
$29 Logitech G203 Prodigy Gamming Mouse
Driver: SetPoint6.67.83_smartw10  (also in my dropbox)

Note macro variable 'pgm' has the name of the program

Top of all my programs

%let pgm=dna_100getDem;

Versionaing using PF1 which is mapped to the both PF1 and the MMB.

Often the same action can be executed by

    1. Hitting a mouse button
    2. Hitting a Function key
    3. Typing the key abreviation (command macro) on the clean command line.

Obs    KEY        LEN    VAL

  1    F1          71    pgm;file &pgm..sas;file c:\ver\&pgm.&_q..sas;%let _q=%eval(0&_q +1);
  2    F2          30    store;note;notesubmit '%avgha'
  3    F3           6    left 3
  4    F4           7    rht 3
  5    F5          30    store;note;notesubmit '%dmpa;'
  6    F6          31    store;note;notesubmit '%dmpha;'
  7    F7          67    log;file "./&pgm..log";note zx;notesubmit "%utl_logcurchk(./&pgm);"
  8    F8           5    rfind
  9    F9           7    rchange
 10    F11         33    store;note;notesubmit '%debugha;'
 11    F12         73    ~;;;;/*'*/ *);*};*];*/;/*"*/;%mend;run;quit;%end;end;run;endcomp;;
 12    SHF F1      24    note;notesubmit '%dmpa;'
 13    SHF F2      25    note;notesubmit '%lsala;'
 14    SHF F6      67    ~n ? "hil";n=*"PFil Mason";n gt:"Phil";n le:"Phim"; sql - eqt    */
 15    SHF F7      67    ~libname x excel ".xls";proc sql;update x;set y=2;where n="Roger"*/
 16    SHF F8      12    :a;copy box;
 17    SHF F9      12    :a:copy hdr;
 18    SHF F10     70    ~options minoperator;%macro t(x=a)/minoperator;%if &x in (a b c) %then
 19    SHF F11     24    note;notesubmit '%cona;'
 20    SHF F12     31    store;note;notesubmit '%frqva;'
 21    CTL F1      31    store;note;notesubmit '%dmpha;'
 22    CTL F2      32    store;note;notesubmit '%lsalha;'
 23    CTL F3      10    ~available
 24    CTL F11     31    store;note;notesubmit '%conha;'
 25    CTL F12     31    store;note;notesubmit '%cntva;'
 26    ALT F1      30    store;note;notesubmit '%vuha;'
 27    ALT F2      28    vt _last_ colheading=names;"
 28    ALT F3      64    ~proc report data=c nowd named list wrap;columns _all_;run;quit;
 29    ALT F11     31    store;note;notesubmit '%xlsha;'
 30    ALT F12     30    store;note;notesubmit '%unva;'
 31    CTL B        3    :tf
 32    CTL D       10    ~available
 33    CTL E       10    ~available
 34    CTL G        8    note g.g
 35    CTL H        8    note h.h
 36    CTL I        3    :lc
 37    CTL J        3    :uc
 38    CTL K        4    :mcu
 39    CTL L        4    :mcl
 40    CTL M       79    ~proc format;value $a;proc catalog cat=work.formats;modify a.formatc(desc=dea);
 41    CTL Q        9    ~aailable
 42    CTL R       11    wattention;
 43    CTL T       73    ~proc tabulate data=class;class sex age;table age,sex*(n pctn<age>)/rts=8
 44    CTL U       80    ~do until(last.s);set c;by s;a+ag;end;do until(last.s);set c;by s;output;end;a=0
 45    CTL W       10    ~available
 46    CTL Y       34    ~where name like "B_B" "%B%" "B%B"
 47    RMB         53    log;clear;out;clear;pgm;submit;home;rec;home;log;z;z;
 48    SHF RMB     25    note;notesubmit '%ls40a;'
 49    CTL RMB     32    store;note;notesubmit '%ls40ha;'
 50    MMB         13    ~mapped to F1
 51    SHF MMB     17    ~mapped to shf F1
 52    CTL MMB     17    ~mapped to ctl F1



*_           _
| | _____  _(_) ___ ___  _ __
| |/ _ \ \/ / |/ __/ _ \| '_ \
| |  __/>  <| | (_| (_) | | | |
|_|\___/_/\_\_|\___\___/|_| |_|

;

Lexicon is your personal dicttionary, here is one I try to use.
The distionary is based on TLAs (Triple letter acronyms)


Power of TLAs hierarchies
-------------------------

Consider Table bps_BloodPressure

TLAs

Bpd  Diastolic Blood Pressure
Bps  Systolic Blood Pressure

Lay - Supine Bllod Pressure
Sit - Sitting Blood Pressure
Stn - Standing Blood Pressure

Firast Row

  Variables  Values
  Pat          1   Patient
  Time         8   8Am

  BpdLay1     84   Diastolic Supine
  BpdSit1    140   Diastolic Sitting
  BpdStn1    130   Diastolic Standing

  BpsLay1     68   Systolic Supine
  BpsSit1     87   Systolic Sitting
  BpsStn1     96   Systolic Standing


Now suppose I want the folowing averages

 Avg all 6 readings       = mean(of Bp:    );

 Avg 3 Diastolic          = mean(of Bpd:   );
 Avg 3 Systolic           = mean(of Bps:   );

It is common to average Sitting and Standing Readings

 Avg 2 Diastolic Sit & Stand   = mean(of BpdS:);
 Avg 2 Systolic Sit & Stand    = mean(of BpsS:);


Use of TLAs in table names

Table Names
Variable Names

proc transpose data=have out=havXpo
proc sort data=hav       out=havSrt;

Even
proc transpose data=havSrt out=havSrtXpo

*    _ _      _   _
  __| (_) ___| |_(_) ___  _ __   __ _ _ __ _   _
 / _` | |/ __| __| |/ _ \| '_ \ / _` | '__| | | |
| (_| | | (__| |_| | (_) | | | | (_| | |  | |_| |
 \__,_|_|\___|\__|_|\___/|_| |_|\__,_|_|   \__, |
                                           |___/
;


There are letters in english that sound the same. These are useful for
building unique TLAs

y and i
d and e, t, z, v and p

zero with zro

There are many combinations of letters
that can be replaced with one letter zro and zero

Three letter variable names

Pat Patient
Sty Study
Cnr Center

Itt Intend to Treat
Saf Safety Set

Xpo Transpose
Srt Sort
Nrm Normalize (make long and skinny)
Fat Denormalize

Hgt Height
Wgt Weight

Syt Site
Tym Time
Nyn Nine

Die Died or Death

Zro Zero

Beg Begin or Start
End Stop or End

Bas Base AgeBas for baseline age

Min Minimum
Max Maximum
Ave
Sum
Std
Sde Standard Error
Q02 Q3
Q03 Q4
P95
P05

1st First (almost allways a suffix )
2nd
3rd
4th
5th

one
two
tre
for
fiv
six
sev
egt
nyn

Dte Date (Not DT)
Bf4 Before
Aft After

Exp - Exposure
Lab - Laboratory
Eos - End of Studt
Eot - End of Treatment
Dem - Demographics


Current Use          Sugested             Definition

FIFTH                5th                  Fifth
ABSOLUTE             Abs                  Absolute Value
AGE                  Age                  Age
AMOUNT               Amt                  Amount
ANC                  Anc                  Anc Neutrophil Count Lab
ANNOTATE             Ano                  Annotate
ANS                  Ans                  Answer
AUC                  Auc                  Area Under Curve
MEAN                 Ave                  Mean
START                Beg                  Start or Begin
BMI                  Bmi                  Body Mass Index
CPR                  Cpr                  CPR  Cardio Pulmonary Resusitation
CRE                  Cre                  Creatinine Lab Test
CRT                  Crt                  Case Report Tabulation - Analysis Dataset
CSR                  Csr                  Clinical Study Report
CYCLE                Cyc                  Study Cycle
DEGREE               Deg                  Death Date
DELETE               Del                  Delete
DEM                  Dem                  Demographics
STOP                 End                  End
EPT                  Ept                  Ept Lab Test
ERR                  Err                  Error
EXAM                 Xam                  Exam
.....
TEMP                 Tmp                  Temporary
TOP                  Top                  Top
TOX                  Tox                  Toxin or Toxicity
TSH                  Tsh                  Serum Thyroid Stimulating Hormone
TTF                  Ttf                  Free Testosterone
TTT                  Ttt                  Total Testosterone
USED                 Use                  Zero or One Flag to indicate use of drug
WBC                  Wbc                  White Blood Count
WIDTH                Wdt                  Width
CROSSOVR             Xvr                  Cross Over


COMPOUND TLAs
==============


ADULTFEMALE    FemAdu  === Should put Sex first, especially if you suspect Seniors and Children
CHILDFEMALE    FemChi
SENIORFEMALE   FemSen

RANGEINAGE     AgeRngYrs  /* Reverse this one and add units  */
AGESRCE        AgeSrc     /* Source */

DRGSTDT        DrgBegDte
DRGSTOP        DrgEndDte

HGBWEEK        HgbWekAve  /* I think it is very important to add Ave or Tot or Cum on the end */

CTRFEM         CnrFemCnt  /* Cnr is Center --  add Cnt if that is what it is */
CTRMALE        CnrMalCnt

DIAGNOSIS      Dgn
DIAGDT         DgnDte
DIAGDUR        DgnDur
DIAGHIST       DgnHst
DIAGTIME       DgnTme

ANEMIA         Ane
ANEMICMED      AneMed
ANESTRDT       AneBegDte

ADVERSE        Aev        /* Adverse Event */
ADVERSEAE      AevSae     /* ADV and AE    */
....
LABVISNO       LabVisNum

PHYSICAL       Phy
PHYSMAX        PhyDteMax
PHYSMIN        PhyDteMin
PHYSPRE        PhyDtePre
PHYSTYPE       PhyTyp


EXTENDED DISCTIONARY
====================

Current Use          Sugested             Definition

ADVTEXTFIRST         AevTxt1st            First
FIFTH                5th                  Fifth
ABNCOUNT             AbnCnt               Abnormal
ABSOLUTE             Abs                  Absolute Value
ACHE                 Ach                  Ache
CTEVENT              ActEvt               Actual
DATEADDED            AddDte               Add
EXECUTE              Xeq                  Execute
....
EXDD                 XitDay               Exit
EXCEL                Xls                  Excel
EXAMPLE              Xmp                  Example
TRANSPOSEDOUTPUT     Xpo                  Proc transposed output
ACROSS               Xrs                  Across
XRAY                 Xry                  XRay
CROSSOVR             Xvr                  Cross Over
AEENDY               AevEndYer            Year
ABYES                AbnYes               Yes
AGEYRS               AgeYrs               Years
PREYTD               PreYtd               Year to Date
ZEMPLAR              Zmp                  Zemplar
DAYZERO              DayZro               Zero


*         _
 ___  ___| |__   ___ _ __ ___   __ _
/ __|/ __| '_ \ / _ \ '_ ` _ \ / _` |
\__ \ (__| | | |  __/ | | | | | (_| |
|___/\___|_| |_|\___|_| |_| |_|\__,_|

;

Hi Team

 I only use underlines where they have meaning ie Dem_RaceCde.xlsx.

 If I have the good fortune to build my our 'relational' database schema I like to create tables? with names

Table dem_demographics

 Variables
   dem_pid
   dem_age
   dem_sex
   dem_race   * no easy TLA for race so use the entire word;
   dem_dob
   dem_die    or dem_doa

lab_laboratory

 Variables
  lab_prikey
  lab_nam
  lab_dem_pid    * foreign key only use second _ for foriegn keys
  lab_dte
  lab_age
  lab_sex
  lab_agecat
  lab_val

This leads to clean sql code, no collisions
* Tmp tables have mixed names

  No collisions
  proc sql;
      create
         table Ldm_DemJynLab as
      select
         l.*
        ,r.*
      from
         de_Demographics left join lab_laboratory
      on
         dem_pid = lab_dem_pid
  ;quit;


  proc sql;
      create
         table Ldm_DemJynLab as
      select
         lab_dem_pid
        ,lab_nam
        ,lab_dte
        ,dem_die
      from
         de_Demographics left join lab_laboratory
      on
         dem_pid = lab_dem_pid
  ;quit;
















