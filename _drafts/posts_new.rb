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
end

[  111,   222,   333,   444,   555,   666,   777,   888,   999,
  1111,  2222,  3333,  4444,  5555,  6666,  7777,  8888,  9999,
 11111, 22222, 33333, 44444, 55555, 66666, 77777, 88888, 99999].each do |i|
  if dayN == i
    kiri_str += "#{i}日目のキリ番ゲット!!  \n"
    break
  end
end

[100,1000,10000,100000].each do |i|
  if dayN % i == 0
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

