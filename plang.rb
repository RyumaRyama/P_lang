#!/usr/bin/ruby

begin
  src = ARGF.read
rescue
  puts "ファイルを指定してください"
  exit
end

memory = Array.new(256, 0)
pointer = 0
# orders = ['でも',
#           'だって',
#           'ブラック',
#           'ホワイト',
#           'レインボーストーム',
#           'マーブルスクリュー',
#           '闇の力の下僕たちよ',
#           'とっととお家に帰りなさい'].join('|')
orders = '\+|-|>|<|,|\.|\[|\]'
token = src.scan(/(#{orders})/).flatten

token.each do |c|
  case c
  when '+'
    memory[pointer] += 1
  when '-'
    memory[pointer] -= 1
  when '>'
    if pointer < 255
      pointer += 1
    else
      puts "NullPointerException +"
      exit
    end
  when '<'
    if pointer > 0
      pointer -= 1
    else
      puts "NullPointerException -"
      exit
    end
  when ','
    puts "入力"
  when '.'
    print memory[pointer].chr
  when '['
    puts "ループ始め"
  when ']'
    puts "ループ終わり"
  end
end
puts
