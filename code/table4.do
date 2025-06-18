cd "C:\Users\廖金升\Desktop\毕业论文重开\data\input"
import delimited "reg_year_data_short_long_two_ponit1118.csv", clear
reghdfe compounded_xret rank_br , absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_beta, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta, absorb(asset year) vce(cluster asset)