* 设置工作目录
cd "C:/Users/廖金升/Desktop/毕业论文重开/data/output"

* 大公司回归
import delimited "large_companies.csv", clear
reghdfe compounded_xret rank_br rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_beta, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br rank_beta, absorb(asset year) vce(cluster asset)
* 小公司回归
import delimited "small_companies.csv", clear
reghdfe compounded_xret rank_br rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_beta, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br rank_beta, absorb(asset year) vce(cluster asset)





