#!/usr/bin/ruby -w
## -*- coding: UTF-8 -*- 
re = Regexp.new("[\u4e00-\u9fa5]")
puts "豆"

puts "段" # 段
puts "\xE6\xAE\xB5" # 段
puts "\u6BB5" # 段
puts "\u3010" # 段


str_utf8 = "豆"
str_utf8 = "："
#"苦寒，归肺经。"
#"生姜：辛微温。归肺脾经。发汗解表，温中止呕，温肺止咳。（胃寒呕吐）"
str_utf8 = "，"
str_utf8 = "。"
#str_utf8 = "归"
#str_utf8 = "经"
puts str_utf8.size                                # 4
puts str_utf8.bytesize                            # 6
puts str_utf8.encoding                         # UTF-8
str_utf8.each_byte {|b| print "%02X," % [b]}      # 68,69,20,E6,AE,B5,
puts

#re = Regexp.new("[\\d]")
if re =~ "发大水"
  puts "OK"
else
  puts "fail"
end
