/*Christina Richardson*/ 
/*An extremely basic and straightforward create, merge and clean.*/

/*Generate the Demographics (DM) Dataset */
data work.DM;
    length USUBJID $12 ARM $20 SEX $1;
    input USUBJID $ AGE SEX $ ARM $ &;
    datalines;
01-701-1001 63 F High Dose
01-701-1002 74 M Placebo
01-701-1003 55 F Screen Failure
01-701-1004 68 M Low Dose
01-701-1005 71 F High Dose
;
run;

/*Generate the Adverse Events (AE) Dataset */
data work.AE;
    length USUBJID $12 AETERM $20 AESEV $10;
    input USUBJID $ AETERM $ AESEV $;
    datalines;
01-701-1001 HEADACHE   MILD
01-701-1001 NAUSEA     MODERATE
01-701-1002 DIZZINESS  MILD
01-701-1004 FATIGUE    SEVERE
01-701-1005 HEADACHE   MILD
;
run;
/*Merge the sorted datasets using 'USUBJID' as the key */
data merged_file;
    merge work.DM work.AE;
    by USUBJID;
run;

data work.safety_master;
    set merged_file;
    where ARM ne "Screen Failure"; 
run; 

/*Execute industry data transformation */
proc sql;
    create table work.SAFETY_MASTER as
    select 
        d.USUBJID, 
        d.AGE, 
        d.SEX, 
        d.ARM, 
        a.AETERM, 
        a.AESEV
    from work.DM as d
    inner join work.AE as a
    on d.USUBJID = a.USUBJID
    where d.ARM ne 'Screen Failure';
quit;

/*Print the final deliverable to verify the pipeline counts */
proc print data=work.SAFETY_MASTER; 
    title "Master Clinical Safety Deliverable: Active Population";
run;

