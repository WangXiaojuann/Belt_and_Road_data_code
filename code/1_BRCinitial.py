# -*- coding: utf-8 -*-
"""
Created on Tue Jan  2 09:52:56 2024

@author: 廖金升
"""

import os
import re
import jieba
import pandas as pd
from tqdm import tqdm
from multiprocessing import Pool

# 设置文件夹路径
folder_path = "E:\\毕业论文文本"

# 设置要统计的unigrams（更新为你的BR词汇）
unigrams_to_count = ["一带一路", "丝绸之路经济带", "21世纪海上丝绸之路", "新丝绸之路", 
                     "国际合作", "亚洲基础设施投资银行", "丝路基金", "平等协商", 
                     "能源合作", "区域能源绿色低碳发展", "多边合作", "多边主义"]

# 将特定词语加入到jieba词库
for term in unigrams_to_count:
    jieba.add_word(term)

# 初始化结果字典
results = {unigram: {} for unigram in unigrams_to_count}

def process_file(file_path):
    year_folder = os.path.basename(os.path.dirname(file_path))
    company_id = os.path.basename(file_path)[:-4]  # 移除.txt后缀
    file_results = {unigram: {} for unigram in unigrams_to_count}
    total_words = 0

    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
        content = re.sub(r'[^\w\s\u4e00-\u9fff]', '', content)  # 移除非文字和非空白字符
        words = list(jieba.cut(content))
        total_words = len(words)
        
        # 初始化所有unigram的计数为0
        for unigram in unigrams_to_count:
            file_results[unigram].setdefault(company_id, {}).setdefault(year_folder, 0)

        for word in words:
            for unigram in unigrams_to_count:
                if word == unigram:
                    file_results[unigram][company_id][year_folder] += 1

    # 计算频率
    for unigram in unigrams_to_count:
        for company_id in file_results[unigram]:
            for year_folder in file_results[unigram][company_id]:
                count = file_results[unigram][company_id][year_folder]
                frequency = count / total_words if total_words > 0 else 0
                file_results[unigram][company_id][year_folder] = frequency

    return file_results

def merge_results(main_results, new_results):
    for unigram in unigrams_to_count:
        for company_id in new_results[unigram]:
            for year_folder in new_results[unigram][company_id]:
                frequency = new_results[unigram][company_id][year_folder]
                if year_folder not in main_results[unigram]:
                    main_results[unigram][year_folder] = {}
                main_results[unigram][year_folder].setdefault(company_id, 0)
                main_results[unigram][year_folder][company_id] += frequency

if __name__ == '__main__':
    # 获取所有txt文件的路径
    all_files = []
    for year_folder in os.listdir(folder_path):
        year_path = os.path.join(folder_path, year_folder)
        if os.path.isdir(year_path):
            for file in os.listdir(year_path):
                if file.endswith('.txt'):
                    all_files.append(os.path.join(year_path, file))

    pool = Pool()
    for file_results in tqdm(pool.imap_unordered(process_file, all_files), total=len(all_files), desc="处理进度"):
        merge_results(results, file_results)
    pool.close()
    pool.join()

    # 创建Excel文件并保存结果
    excel_path = "C:\\Users\\廖金升\\Desktop\\毕业论文重开\\data\\input\\BRC.xlsx"
    with pd.ExcelWriter(excel_path) as writer:
        for unigram, data in results.items():
            df = pd.DataFrame(data)  # 转置DataFrame           
            df.to_excel(writer, sheet_name=str(unigram))

    print("统计完成，结果已保存到", excel_path)


