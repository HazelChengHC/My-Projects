data sum;
set '/home/u59457793/EDUC 768/adh.sas7bdat' end=end nobs=nobs;
array orig(24)

v9in v42in v50in v59in v63in v74in v85in 
v5as v19as v24as v30as v39as v46as v76as v90as v98as v113as v114as 
v12hy v55hy v65hy v80hy v82hy v83hy;

drop level;
array sums(24) sum1-sum24;
do i = 1 to 24;
sums(i) + orig(i);
end;
if end then do;
do j = 1 to 24;
Item = vname(orig(j));
ItemDifficultyIndex = sums(j)/nobs;
sum=sums(j);
output;
end;
end;
drop i j sum1-sum24;
data sum;
set sum;

if ItemDifficultyIndex ge .49 then Level='+';
if ItemDifficultyIndex lt .01 then Level='-';

title "Item Difficulty (Easiness/Popularity/Prevalence) Indexes";
title3 "Analysis for All Items";
title5 "+ = Easy Item - = Difficult Item";
proc print;
var Item ItemDifficultyIndex Level;
run;
title;
proc means Data = sum n mean std min max maxdec=2 fw=5;
title "Analysis for All Items";
var ItemDifficultyIndex;
run;
data sum;
set sum;
if Level = ' ';
title "Item Difficulty (Easiness/Popularity/Prevalence) Indexes";
title3 "Analysis for Retained Items";
proc print;
var Item ItemDifficultyIndex;
run;
title;
proc means Data = sum n mean std min max maxdec=2 fw=5;
title3 "Analvsis for Retained Items";
var ItemDifficultyIndex;
run;
title;