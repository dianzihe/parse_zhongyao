#!/usr/bin/ruby -w
## -*- coding: UTF-8 -*-
require 'open3'
require 'pg'
require 'ruby-pinyin'
#require 'SecureRandom'
#
#
siqi = "寒热温凉"
wuwei = "辛甘酸苦咸涩平"
chengdu = "大畏淡微有小毒肝"
jing = []
jing.push("手太阴肺经")
jing.push("足阳明胃经")
jing.push("足太阴脾经")
jing.push("手少阴心经")
jing.push("手阳明大肠经")
jing.push("手太阳小肠经")
jing.push("足太阳膀胱经")
jing.push("足少阴肾经")
jing.push("手厥阴心包经")
jing.push("手少阳三焦经")
jing.push("足少阳胆经")
hz_gui = "归"
hz_jing = "经"
hz_wei = "微"
#
fh_dun = "、" 
fh_dou = "，"
fh_ju = "。"
fh_mao = "："

split_p_yaoming = "(.*)" + fh_mao
split_p_xing = "([" + wuwei + siqi + chengdu + fh_dun + fh_dou + "]*)" + "[" + fh_dou + fh_ju + fh_mao + "]*"
split_p_jing = "[" + hz_gui + "]" + "(.+?" + hz_jing + ")"
split_p_effect = "[" + fh_dou + fh_ju + "]" + "(.*)"
split_syntax = split_p_yaoming + split_p_xing + split_p_jing + split_p_effect

split_regexp = Regexp.new(split_p_yaoming + split_p_xing + split_p_jing + split_p_effect)

dbhost="127.0.0.1"
dbname="nineteen_wu_development"
dbuser="postgres"
dbpassword="postgres"
tableName="yaofangs"

conn=PGconn.connect(dbhost,5432,'','',dbname,dbuser,dbpassword)
conn.close
file=File.open("/home/dq/project/parse_yao/zhongyaocai.txt","r:UTF-8")
i=0
file.each { |line| 
  #puts "--: #{line}"
  i=i+1
  begin
    line.scan(split_regexp) do |name, xing, jing, effect | 
      #items = zucheng.scan(zucheng_regexp)
      #items.each do |item|
      #  item.scan(filter_zucheng_regexp) do |name, weight|
      #    if name.nil? || name.empty? || weight.nil? || weight.empty? then
      #      puts zucheng
      #      return
      #    end
      #    #puts "--"
      #    if name.include?"\xee\x92\x8b" then
      #      puts "[#{name}]"
      #    end
      #    if weight.include?"\xee\x92\x8b" then
      #      puts "[#{weight}]"
      #    end
      #  end
      #end
      if name.nil? || name.empty? || xing.nil? || xing.empty? || jing.nil? || jing.empty? || effect.nil? || effect.empty? then
        puts "#{i}: #{line}"
        return
      end
      puts "#{i}"
      `echo #{PinYin.of_string(name).join} >> /tmp/a`
      #puts "#{name}"
      #puts "#{xing}"
      #puts "#{jing}"
      #puts "#{effect}"
    end
  rescue
    puts "#{line}"
  end
}
file.close
return 
Open3.pipeline_r("cat /home/dq/project/tt.txt") {|o, ts|
  o.each_line {|line|
    tmp_line = line.chomp

    puts tmp_line
    case tmp_line
    when yaofang_regexp
      puts "---------"
    else
      puts "?"
    end
     
    #send task result
  }
}
