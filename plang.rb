#!/usr/bin/ruby

class Plang
  def initialize(program)
    orders_hash = get_orders_hash
    orders = define_orders(orders_hash)
    tokens = program.scan(/(#{orders})/).flatten
    @bf_tokens = []
    tokens.each do |token|
      @bf_tokens << orders_hash[token]
    end
  end

  def define_orders(orders_hash)
    orders_hash.keys.join('|')
  end

  def get_orders_hash
    {
      'なぎ' => '+',
      'ブラック' => '+',
      'でも' => '+',
      'ほの' => '-',
      'ホワイト' => '-',
      'だって' => '-',
      'メポ' => '>',
      'ミポ' => '<',
      'ふたりはプリキュア' => '.',
      '遊園地' => ',',
      '闇の力の下僕たちよ' => '[',
      'とっととお家に帰りなさい' => ']',
    }
  end

  def exec
    memory = Array.new(256, 0)
    pointer = 0
    jump = []
    index = 0
    while @bf_tokens.length >= index
      case @bf_tokens[index]
      when '+'
        memory[pointer] += 1
      when '-'
        memory[pointer] -= 1
      when '>'
        if pointer < 255
          pointer += 1
        else
          puts "\nNullPointerException +"
          exit
        end
      when '<'
        if pointer > 0
          pointer -= 1
        else
          puts "\nNullPointerException -"
          exit
        end
      when ','
        memory[pointer] = $stdin.getc.ord
      when '.'
        print memory[pointer].chr
      when '['
        if memory[pointer] != 0
          jump << index+1
        else
          while @bf_tokens[index] != ']'
            index += 1
            if index > @bf_tokens.length
              puts "\nsyntax error"
              exit
            end
          end
        end
      when ']'
        if jump.length == 0
          puts "\nsyntax error"
          exit
        end
        if memory[pointer] != 0
          index = jump[-1]
          next
        else
          jump.pop
        end
      end
      index += 1
    end
    puts
  end
end


if __FILE__ == $0
  begin
    program = ARGF.read
  rescue
    puts "ファイルを指定してください"
    exit
  end

  plang = Plang.new(program)
  plang.exec
end

