cd "C:\Users\廖金升\Desktop\毕业论文重开\data\input"

import delimited "reg_fundamental.csv", clear

*reg xret on BR_Report and BR_Beta
reghdfe xret_cumulative rank_br rank_beta ch4mkt_beta_avg ch4smb_beta_avg ch4vmg_beta_avg ch4pmo_beta_avg, absorb(asset date) vce(cluster asset)
reghdfe xret_cumulative rank_br ch4mkt_beta_avg ch4smb_beta_avg ch4vmg_beta_avg ch4pmo_beta_avg, absorb(asset date) vce(cluster asset)
reghdfe xret_cumulative rank_beta ch4mkt_beta_avg ch4smb_beta_avg ch4vmg_beta_avg ch4pmo_beta_avg, absorb(asset date) vce(cluster asset)

*reg xret on earning measure
*reghdfe ep_value rank_br rank_beta bm_avg size roe_avg cost_growth, absorb(asset date) vce(cluster asset)
*reghdfe ep_value rank_br orr oc_growth lntl, absorb(asset date) vce(cluster asset)
*reghdfe ep_value rank_beta orr oc_growth lntl, absorb(asset date) vce(cluster asset)

*reg xret on debt measure
reghdfe tl_growth rank_br rank_beta orr toc_growth lntl, absorb(asset date) vce(cluster asset)
reghdfe tl_growth rank_br orr toc_growth lntl, absorb(asset date) vce(cluster asset)
reghdfe tl_growth rank_beta orr toc_growth lntl, absorb(asset date) vce(cluster asset)
*earning
reghdfe ep_value rank_br rank_beta bm_avg log_me_avg roe_avg oc_growth, absorb(asset date) vce(cluster asset)
reghdfe ep_value rank_br bm_avg log_me_avg roe_avg oc_growth, absorb(asset date) vce(cluster asset)
reghdfe ep_value rank_beta bm_avg log_me_avg roe_avg oc_growth, absorb(asset date) vce(cluster asset)