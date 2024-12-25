require 'date'
require 'fileutils'

# 今日の日付
today = Date.today
today_str = today.strftime('%Y-%m-%d')

# 基準日から今日までの日数
base_date = Date.new(2024, 7, 6)
dayN = (today - base_date).to_i

# キリ番的な表示
kiri_str = ''
if dayN % 365 == 0
  kiri_str += "ちょうど#{dayN / 365}年が経った#{'!'*(dayN / 365)}  \n"
elsif (dayN % 365) in 182..183
  kiri_str += "だいたい#{dayN / 365}年と半年が経った#{'.'*(dayN / 365)}  \n"
end

[100,111,1000,1111,10000,11111,100000,111111].each do |i|
  if dayN % i == 0 # 余りを見てるので200,300... も対応する
    kiri_str += "#{dayN}日目のキリ番ゲット!!  \n"
    break
  end
end

# ファイル名と中身
filename = "#{today_str}-day-#{dayN}.md"
content = <<~MARKDOWN
---
layout: post
title: (new post)
category: diary
---

あれから#{dayN}日目。
#{kiri_str}

MARKDOWN

# 出力先ディレクトリ
output_dir = File.expand_path('~/projects/blog-jekyll/_posts/')
FileUtils.mkdir_p(output_dir) unless Dir.exist?(output_dir)
file_path = File.join(output_dir, filename)

# ファイルが存在する場合は終了
if File.exist?(file_path)
  puts "ファイルが既に存在します: #{file_path}"
  exit
end

# ファイル作成
File.write(file_path, content)
puts "ファイル生成完了: #{file_path}"

