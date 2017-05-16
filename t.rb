#!/usr/bin/ruby -w
## -*- coding: UTF-8 -*- 
re = Regexp.new("[\u4e00-\u9fa5]")
puts "豆"

puts "段" # 段
puts "\xE6\xAE\xB5" # 段
puts "\u6BB5" # 段
puts "\u3010" # 段


str_utf8 = "豆"
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
