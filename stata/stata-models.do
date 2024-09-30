ssc install outreg2
ssc install schemepack, replace
set scheme gg_tableau

* Load the dataset, Facebook ads data from EP elections 2019, and EES 2014 data
cd "Z:\targeting\"
use "analyze_data.dta", clear

sort fb gender age parlgov_id

encode country, gen(country_enc)
encode fb, gen(fb_enc)
* encode parlgov_id, gen(parlgov_id_enc)

lab var vote "Vote share"


cap drop niche
gen niche = 0
replace niche = 1 if party_type == "niche"

* ##########################
* PARTY SIZE
* ##########################

cap drop parlgov_id_enc
encode parlgov_id, gen(parlgov_id_enc)

reg target_spend c.vote_diff##c.party_size c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg1

margins, at(vote_diff = (-10 (1) 20) party_size = (40 5)) post // ca. 5-95% quantiles
marginsplot, title("",size(vlarge)) plot1opts(lcolor(gs8)) ciopt(color(black%20) msize(large)) xlabel(,labsize(large)) ylabel(,labsize(large)) recast(line)  plotopts(msize(large)) ytitle( "P(Relative target group spend)", size(vlarge)) xtitle("Target group support", size(vlarge))  recastci(rarea)
graph export "marginsplot_party-size.pdf", replace



* ##########################
* NICHE
* ##########################



reg target_spend c.vote_diff##niche c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using new-reg.xls, replace label excel tex alpha(0.001, 0.01, 0.05)

margins, at(vote_diff = (-10 (1) 20) niche = (0 1)) post // ca. 5-95% quantiles

marginsplot, title("",size(vlarge)) plot1opts(lcolor(gs8)) ciopt(color(black%20) msize(large)) xlabel(,labsize(large)) ylabel(,labsize(large)) recast(line)  plotopts(msize(large)) ytitle( "P(Relative target group spend)", size(vlarge)) xtitle("Target group support", size(vlarge))  recastci(rarea)
graph export "marginsplot_niche.pdf", replace


* ##########################
* Robustness
* ##########################


* ##########################
* Main models with vote share (without substraction of party mean)
* ##########################

* Party size
reg target_spend c.vote##c.party_size c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg1

margins, at(vote = (0 (1) 30) party_size = (40 5)) post // ca. 5-95% quantiles
marginsplot, title("",size(vlarge)) plot1opts(lcolor(gs8)) ciopt(color(black%20) msize(large)) xlabel(,labsize(large)) ylabel(,labsize(large)) recast(line)  plotopts(msize(large)) ytitle( "P(Relative target group spend)", size(vlarge)) xtitle("Target group support (absolute)", size(vlarge))  recastci(rarea)
graph export "marginsplot_party-size_absolute.pdf", replace


reg target_spend c.vote##niche c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-abs.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)

margins, at(vote = (0 (1) 30) niche = (0 1)) post // ca. 5-95% quantiles

marginsplot, title("",size(vlarge)) plot1opts(lcolor(gs8)) ciopt(color(black%20) msize(large)) xlabel(,labsize(large)) ylabel(,labsize(large)) recast(line)  plotopts(msize(large)) ytitle( "P(Relative target group spend)", size(vlarge)) xtitle("Target group support (absolute)", size(vlarge))  recastci(rarea)
graph export "marginsplot_niche_absolute.pdf", replace


* ##########################
* Main models without analytical weights.
* ##########################

* Party size
reg target_spend c.vote_diff##c.vote_party  c.population, cluster(parlgov_id)
est store reg1

* Niche
reg target_spend c.vote_diff##niche  c.population, cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-no-aweight.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)


* ##########################
* Main models without France, Portugal, Bulgaria.
* ##########################

* Party size
reg target_spend c.vote_diff##c.vote_party  c.population [aweight = obs_targets] if !inlist(country, "FR", "PT", "BG"), cluster(parlgov_id)
est store reg1

* Niche
reg target_spend c.vote_diff##niche  c.population [aweight = obs_targets] if !inlist(country, "FR", "PT", "BG"), cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-no-fr-pt-bg.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)

* ##########################
* Main models without UK.
* ##########################

* Party size
reg target_spend c.vote_diff##c.vote_party  c.population [aweight = obs_targets] if !inlist(country, "UK"), cluster(parlgov_id)
est store reg1

* Niche
reg target_spend c.vote_diff##niche  c.population [aweight = obs_targets] if !inlist(country, "UK"), cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-no-uk.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)


* ##########################
* Main models with national party pages only
* ##########################

* Party size
reg target_spend_nat c.vote_diff##c.vote_party  c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg1

* Niche
reg target_spend_nat c.vote_diff##niche  c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-national.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)


* ##########################
* Main models as mixed model with parties nested in countries
* ##########################

* Party size
mixed target_spend c.vote_diff##c.vote_party  c.population || country: || parlgov_id: 
est store reg1

* Niche
mixed target_spend c.vote_diff##niche  c.population || country: || parlgov_id: 
est store reg2
outreg2 [reg1 reg2] using reg-mixed.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)


* ##########################
* Main models using impressions instead of spending
* ##########################

* Party size
reg target_impr c.vote_diff##c.vote_party  c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg1

* Niche
reg target_impr c.vote_diff##niche  c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-impressions.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)


* ##########################
* Main models with controls for demographic variables (population size, gender, age)
* ##########################

* Party size
reg target_spend c.vote_diff##c.vote_party c.population i.gender i.age [aweight = obs_targets], cluster(parlgov_id)
est store reg1

* Niche
reg target_spend c.vote_diff##niche c.population i.gender i.age [aweight = obs_targets], cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-demo-controls.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)


* ##########################
* Main models using vote propensity instead of vote share
* ##########################

* Party size
reg target_spend c.prop_diff##c.party_size  c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg1

sum prop_diff, detail

margins, at(prop_diff = (-1.5 (0.5) 2) party_size = (40 5)) post // ca. 5-95% quantiles
marginsplot, title("",size(vlarge)) plot1opts(lcolor(gs8)) ciopt(color(black%20) msize(large)) xlabel(,labsize(large)) ylabel(,labsize(large)) recast(line)  plotopts(msize(large)) ytitle( "P(Relative target group spend)", size(vlarge)) xtitle("Target group support (vote propensity)", size(vlarge))  recastci(rarea)
graph export "marginsplot_party-size_prop.pdf", replace

* Niche
reg target_spend c.prop_diff##niche c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-prop.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)

margins, at(prop_diff = (-1.5 (0.5) 2) niche = (0 1)) post // ca. 5-95% quantiles

marginsplot, title("",size(vlarge)) plot1opts(lcolor(gs8)) ciopt(color(black%20) msize(large)) xlabel(,labsize(large)) ylabel(,labsize(large)) recast(line)  plotopts(msize(large)) ytitle( "P(Relative target group spend)", size(vlarge)) xtitle("Target group support (vote propensity)", size(vlarge))  recastci(rarea)
graph export "marginsplot_niche_prop.pdf", replace




* ##########################
* Main models with EES 2019 instead of 2014 data
* ##########################



use "analyze_data_ees19.dta", clear


sort fb gender age parlgov_id

encode country, gen(country_enc)
encode fb, gen(fb_enc)

cap drop niche
gen niche = 0
replace niche = 1 if party_type == "niche"

gen population = pop_count / pop_count_mean * 100

sum vote_party, detail

* Party size
reg target_spend c.vote_diff##c.vote_party c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg1

* Niche
reg target_spend c.vote_diff##niche c.population [aweight = obs_targets], cluster(parlgov_id)
est store reg2
outreg2 [reg1 reg2] using reg-ees2019.xls, replace label excel tex  alpha(0.001, 0.01, 0.05)
