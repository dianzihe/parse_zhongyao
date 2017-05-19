
file=File.open("/tmp/a","r")
i=0
file.each { |line|
  puts "#{line}"
  `wget http://zy.yaozh.com/yaocai/changjian/#{line.downcase.chomp}.htm -O /home/dq/project/parse_yao/down/yaocai/#{line.downcase.chomp}.htm`
}

file.close
