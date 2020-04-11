clear all

* Set up script sctructure, load dataset, and set up working space;

#delimit ;
set more off;

use "/Users/renatomolina/Box Sync/GitHub/catch_shares_panel/Data/WDB.dta";

cd "/Users/renatomolina/Box Sync/GitHub/catch_shares_panel/Tables";

destring, replace;

encode stock_cs_id, gen(id);

drop if year <1990;

* Set up panel structure;

xtset id year;

encode fao, gen(space);

encode cat, gen(cate);

gen clust = space;

* Set up variables;

gen y = status_bio;

global x TURF;

* Regressions;

eststo:quietly xtreg y $x
	i.year, vce(cluster clust);

eststo:quietly xtreg y $x
	i.space, vce(cluster clust);	
	
eststo:quietly xtreg y $x
	i.space##i.year, vce(cluster clust);

eststo:quietly xtreg y $x i.cate
	i.space##i.year, vce(cluster clust);	

	
eststo:quietly xtreg y $x i.cate max age
	i.space##i.year, vce(cluster clust);	
	
	
esttab, keep($x)
	se;
