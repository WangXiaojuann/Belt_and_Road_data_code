* 设置工作目录
cd "C:/Users/廖金升/Desktop/毕业论文重开/data/output"

* 导入数据
import delimited "merge_br_beta_year_2015_7_2016_6_0210w_industry_cross.csv", clear

*主回归
di "==== 主回归开始 ===="
reghdfe compounded_xret rank_br, absorb(industry year) vce(cluster asset)
reghdfe compounded_xret rank_beta, absorb(industry year) vce(cluster asset)
reghdfe compounded_xret rank_br rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta, absorb(industry year) vce(cluster asset)
di "==== 主回归结束 ===="

*加入choice变量
di "==== 加入choice回归开始 ===="
reghdfe compounded_xret rank_br choice, absorb(industry year) vce(cluster asset)
reghdfe compounded_xret rank_beta choice, absorb(industry year) vce(cluster asset)
reghdfe compounded_xret rank_br rank_beta ch4mkt_beta ch4smb_beta ch4vmg_beta ch4pmo_beta choice, absorb(industry year) vce(cluster asset)
di "==== 加入choice回归结束 ===="



