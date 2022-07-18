data test1;
set '/home/u59457793/EDUC 768/test1.sas7bdat';
run;

data sum;
set test1 end=end nobs=nobs;
array orig(100) V1-V100;
array sums (100) sum1-sum100;
do i = 1 to 100;
sums(i) + orig(i);
end;
if end then do;
do j = 1 to 100;
Item=vname (orig(j));
ItemDifficultyIndex=sums(j)/nobs;
sum=sums(j);
output;
end;
end;
drop i j sum1-sum100;
data sum;
set sum;

* Difficulty indices of the items comprising the universal standards;
* 30% & 70% threshold works here;

if ItemDifficultyIndex ge .70 then Level='+';
if ItemDifficultyIndex lt .30 then Level='-';

title "Item Difficulty (Easiness/Popularity/Prevalence) Indexes";
title3 "Analysis for All Items";
title5 "+ = Easy Item - = Difficult Item";
proc print;
var Item ItemDifficultyIndex Level;
run;
title;
proc means Data=sum n mean std min max maxdec=2 fw=5;
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
proc means Data=sum n mean std min max maxdec=2 fw=5;
title3 "Analvsis for Retained Items";
var ItemDifficultyIndex;
run;
title;