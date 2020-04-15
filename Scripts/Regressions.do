clear all

* Set up script sctructure, load dataset, and set up working space;

#delimit ;
set more off;

use "/Users/renatomolina/Box Sync/GitHub/catch_shares_panel/Data/WDB.dta";

cd "/Users/renatomolina/Box Sync/GitHub/catch_shares_panel/Tables";

destring, replace;

encode stock_cs_id, gen(id);

drop if year < 1990;

* Set up panel structure;

xtset id year;

encode fao, gen(space);

encode cat, gen(cate);

gen clust = space;

* Set up variables;

global x TURF;

* Regressions on catch;

gen y = log(catch);

eststo:quietly xtreg y $x
	i.year, fe vce(cluster clust);

eststo:quietly xtreg y $x
	i.space, fe vce(cluster clust);	
	
eststo:quietly xtreg y $x
	i.space##i.year, fe vce(cluster clust);

eststo:quietly xtreg y $x i.cate
	i.space##i.year, fe vce(cluster clust);	

	
eststo:quietly xtreg y $x i.cate max age
	i.space##i.year, fe vce(cluster clust);

esttab, keep($x)
	se;

eststo clear;	
	
* Regressions on b/bmsy;

replace y = status_bio;

eststo:quietly xtreg y $x
	i.year, fe vce(cluster clust);

eststo:quietly xtreg y $x
	i.space, fe vce(cluster clust);	
	
eststo:quietly xtreg y $x
	i.space##i.year, fe vce(cluster clust);

eststo:quietly xtreg y $x i.cate
	i.space##i.year, fe vce(cluster clust);	

	
eststo:quietly xtreg y $x i.cate max age
	i.space##i.year, fe vce(cluster clust);	
	
esttab, keep($x)
	se;

eststo clear;	
	
* Regressions on f/fmsy;

replace y = status_f;

eststo:quietly xtreg y $x
	i.year, fe vce(cluster clust);

eststo:quietly xtreg y $x
	i.space, fe vce(cluster clust);	
	
eststo:quietly xtreg y $x
	i.space##i.year, fe vce(cluster clust);

eststo:quietly xtreg y $x i.cate
	i.space##i.year, fe vce(cluster clust);	

	
eststo:quietly xtreg y $x i.cate max age
	i.space##i.year, fe vce(cluster clust);	
	
esttab, keep($x)
	se;

eststo clear;	
		

