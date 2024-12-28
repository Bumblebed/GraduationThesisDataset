xtset Symbol Year
gen lnemployee=log(employee)
egen sdexpo=std(exposure)
gen lag_sdexpo=L.sdexpo

//描述性统计
summarize lnemployee lag_sdexpo lnhigh_cog lnmid_cog lnlow_cog lnbusi_cog lnmanage_cog lnadmin_cog lntech_cog lnprod_cog lnaverwage lnpremium age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum

tabstat lnemployee lag_sdexpo lnhigh_cog lnmid_cog lnlow_cog lnbusi_cog lnmanage_cog lnadmin_cog lntech_cog lnprod_cog lnaverwage lnpremium age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, statistics(N mean sd min max) columns(statistics)

///基准回归-------雇佣规模
reghdfe lnemployee lag_sdexpo, absorb(indcode Citycode Year) cluster(indcode Citycode)
est store bench_employee_no_ctrl

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

est store bench_employee

///基准回归-------技能人数(均显著)
gen high_cog=high_cog_portion*employee
gen mid_cog=mid_cog_portion*employee
gen low_cog=low_cog_portion*employee

gen lnhigh_cog=log(high_cog)
gen lnmid_cog=log(mid_cog)
gen lnlow_cog=log(low_cog)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

est store bench_high

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

est store bench_mid

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

est store bench_low

///技能比例取对数
reghdfe lnhigh_ratio lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,replace tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_ratio lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_ratio lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

///基准回归-------专业人数
gen busi_cog=busi_portion*employee
gen manage_cog=manage_portion*employee
gen admin_cog=admin_portion*employee
gen tech_cog=tech_portion*employee
gen prod_cog=prod_portion*employee

gen lnbusi_cog=log(busi_portion*employee)
gen lnmanage_cog=log(manage_portion*employee)
gen lnadmin_cog=log(admin_portion*employee)
gen lntech_cog=log(tech_portion*employee)
gen lnprod_cog=log(prod_portion*employee)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi)

est store bench_busi

reghdfe lnmanage_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnmanage)

est store bench_manage

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin)

est store bench_admin

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lntech)

est store bench_tech

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnprod)

est store bench_prod

///基准回归-------专业结构
gen lnbusi_ratio=log(busi_portion)
gen lnmanage_ratio=log(manage_portion)
gen lnadmin_ratio=log(admin_portion)
gen lntech_ratio=log(tech_portion)
gen lnprod_ratio=log(prod_portion)

reghdfe busi_portion lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)
outreg2 using benchmark.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi)

reghdfe manage_portion lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)
outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnmanage)

reghdfe admin_portion lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)
outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin)

reghdfe tech_portion lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)
outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lntech)

reghdfe prod_portion lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)
outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnprod)

///基准回归-------平均工资(显著，正数)
reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,replace tstat bdec(3) tdec(2) ctitle(lnaverwage)

///基准回归-------技能溢价(显著，正数)
reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using benchmark.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

///导出结果
///中介效应-------替代风险(交乘项系数显著，且为负，说明调节效应是负向的)
egen sdsuspect=std(suspectibility)
gen suspect_expo=sdsuspect*sdexpo_pre
gen lnsuspect=log(suspectibility)

reghdfe suspectibility L.lnexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using mechanism.doc,replace tstat bdec(3) tdec(2) ctitle(suspectibility)

reghdfe lnsuspect lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using mechanism.doc,replace tstat bdec(3) tdec(2) ctitle(lnsuspect)

///中介效应-------规模效应
gen lnscale = log(fixedassets)
egen sdscale = std(fixed_asset_incre)

reghdfe sdscale L.lnexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using mechanism.doc,append tstat bdec(3) tdec(2) ctitle(sdscale)

///中介效应-------创造效应
///第一阶段(不显著) ，按照江艇举的例子，加入了中介变量后核心解释变量的系数下降且不再显著，而中介变量的系数显著，说明了中介效应的存在
// reghdfe tech_portion tasks_incre_rate age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)
// ///D对M的影响不显著，替换成总的任务数后显著
// gen lntasks=log(tasks_num)
// gen lntask_incre=log(tasks_incre)

reghdfe lntasks lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using mechanism.doc,append tstat bdec(3) tdec(2) ctitle(lntasks)

est store mediate_tasks

// ///M对Y的影响开始显著且为正，加入M后为负且不显著
// reghdfe lnemployee lntasks sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

// est store mediate_tasks

///稳健性检验
///替换核心解释变量1（替换为人工智能词频，年份尺度上会有）
merge 1:1 sym_year using temp_data1.dta
gen sub_expo = log(1+aitechnology)

reghdfe lnemployee L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnaverwage L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium L.sub_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

///替换核心解释变量2（替换为处理效应，1为有AI技术创新的企业，0为无）
gen is_expo = (exposure>0)

reghdfe lnemployee L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnaverwage L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium L.is_expo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

//替换回归方法（替换为泊松回归）
ppmlhdfe employee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,replace tstat bdec(3) tdec(2) ctitle(employee)

ppmlhdfe high_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,append tstat bdec(3) tdec(2) ctitle(high_cog)

ppmlhdfe mid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,append tstat bdec(3) tdec(2) ctitle(mid_cog)

ppmlhdfe low_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,append tstat bdec(3) tdec(2) ctitle(low_cog)

ppmlhdfe busi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,append tstat bdec(3) tdec(2) ctitle(busi_cog)

ppmlhdfe admin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,append tstat bdec(3) tdec(2) ctitle(admin_cog)

ppmlhdfe tech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,append tstat bdec(3) tdec(2) ctitle(tech_cog)

ppmlhdfe prod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using robutsness_check3.doc,append tstat bdec(3) tdec(2) ctitle(prod_cog)

//SYS-GMM回归（抑制内生性）
drop iv_lnemplyee
gen iv_lnemplyee=lnemployee - L.lnemployee
gen iv_sdexpo = lag_sdexpo - L.lag_sdexpo
gen iv_age = age - L.age
gen iv_size = Size - L.Size
gen iv_lev = Lev - L.Lev
gen iv_growth =Growth-L.Growth
gen iv_soe = SOE-L.SOE
gen iv_roa1 = ROA1-L.ROA1
gen iv_top3 = Top3 - L.Top3
gen iv_thirdrate = thirdrate - L.thirdrate
gen iv_popu = popu - L.popu
gen iv_gdp = gdp - L.gdp
gen iv_secondrate = secondrate - L.secondrate
gen iv_RDSpendSum = RDSpendSum-L.RDSpendSum

// xtabond2 y L.y x1 x2, gmm(L.y) iv(x1 x2) robust nolevel twostep
// iv_age iv_size iv_lev iv_growth  iv_soe iv_roa1 iv_top3 iv_thirdrate iv_popu iv_gdp iv_secondrate iv_RDSpendSum
xtabond2 lnemployee iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnhigh_cog iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnmid_cog iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnlow_cog iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnbusi_cog iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnadmin_cog iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lntech_cog iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnprod_cog iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnaverwage iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

xtabond2 lnpremium iv_lnemplyee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, gmm(iv_sdexpo) iv(iv_sdexpo) robust nolevel twostep

///异质性分析1(是否国企)
gen is_ict=inlist(indcode,39,40,61,62,63)
gen funback_ratio=funback/totalnumber

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,replace tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if SOE==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check1.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

///异质性分析3(技术出身高管>20%)
gen is_high_funback = (funback_ratio>=0.2)
reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,replace tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio>=0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if funback_ratio<0.2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check3.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

///行业异质性分析1(是否为ICT行业)
reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,replace tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_ict==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check2.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

///行业异质性分析2(资本/劳动密集型行业)
gen intensy = 0

replace intensy=1 if inlist(industrycode,"C30","C31","C32","C33","C34","C35","C36","C37")

replace intensy=1 if inlist(industrycode,"C38","C39","C40","C41","C42","J66","J67")

replace intensy=1 if inlist(industrycode,"J68","J69","K70","K71")

replace intensy=2 if inlist(industrycode,"A01","A02","A03","A04","A05","B06","B07")

replace intensy=2 if inlist(industrycode,"B08","B09","B10","B11","C13","C14","C15")

replace intensy=2 if inlist(industrycode,"C16","C17","C18","C19","C20","C21","C22")

replace intensy=2 if inlist(industrycode,"C23","C24","C25","C26","C27","C28","C29")

replace intensy=2 if inlist(industrycode,"D44","D45","D46","E47","E48","E49","E50")

replace intensy=2 if inlist(industrycode,"F51","F52","H61","H62","L71","L72","M73","M74","M75")

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,replace tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if intensy==2, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check4.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

//地区异质性分析1（是否为试点地区）
gen is_testzone=inlist(Citycode,110000,310000,340100,330100,440300,120000,370100,610100,510100,500000,440100,420100,330521,320500,430100)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==1, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if is_testzone==0, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check5.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

//地区异质性分析2（劳动保障程度高.低）
//找每年的中位数
egen labor_protect_mid = median(labor_union_num), by(Year)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,replace tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnemployee lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnemployee)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnhigh_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnhigh_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnmid_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnmid_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnlow_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnlow_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,replace tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnbusi_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnbusi_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lnadmin_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnadmin_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lntech_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lntech_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnprod_cog lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnprod_cog)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnaverwage lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnaverwage)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num>=labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

reghdfe lnpremium lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum if labor_union_num<labor_protect_mid, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using hetero_check6.doc,append tstat bdec(3) tdec(2) ctitle(lnpremium)

//进一步分析1（相对价值）
reghdfe tobinq lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,replace tstat bdec(3) tdec(2) ctitle(tobinq)

reghdfe OPM lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(OPM)

reghdfe OPM lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(OPM)

reghdfe EPS lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(EPS)

reghdfe ROE1 lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(ROE1)

reghdfe TAT lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(TAT)

reghdfe pe lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(pe)

reghdfe pb lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(pb)

reghdfe esg lag_sdexpo age Size Lev Growth SOE ROA1 Top3 thirdrate popu gdp secondrate RDSpendSum, absorb(indcode Citycode Year) cluster(indcode Citycode)

outreg2 using further.doc,append tstat bdec(3) tdec(2) ctitle(esg)

