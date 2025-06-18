* 设置工作目录
cd "C:/Users/廖金升/Desktop/毕业论文重开/data/input"

* 导入数据
import delimited "reg_year_data_short_long_two_ponit1118.csv", clear

* 国企回归
di "==== 国企回归开始 ===="
reghdfe compounded_xret rank_br if soe == 1, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_beta if soe == 1, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta if soe == 1, absorb(asset year) vce(cluster asset)
di "==== 国企回归结束 ===="

* 非国企回归
di "==== 非国企回归开始 ===="
reghdfe compounded_xret rank_br if soe == 0, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_beta if soe == 0, absorb(asset year) vce(cluster asset)
reghdfe compounded_xret rank_br rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta if soe == 0, absorb(asset year) vce(cluster asset)
di "==== 非国企回归结束 ===="
