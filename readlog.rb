#!/usr/bin/ruby -w
## -*- coding: UTF-8 -*-
require 'open3'
require 'pg'
#require 'SecureRandom'

comment  = ';#'
comment = comment.to_s.empty? ? "\\z" : "\\s*(?:[#{comment}].*)?\\z"

process_fatal_regexp 		= %r/^fatal.*/
property_regexp 		= %r/\A(.*?)(?<!\\)\z/

#yaofang_regexp  	= %r/.*\t.*\t.*/
yaofang_regexp 		= %r/.*\t.*\t.*/
yao_item = "[\u4e00-\u9fa5\uff08-\uff09\\(\\)\\{\\}\\-\\sa-zA-Z\u3014-\u3015\u3010-\u3011\u3000\u0020\xee\x92\x8b]*"
yao_weight = "[\\d\\.]*g"

#zucheng_regexp = %r/[\u4e00-\u9fa5\uff08-\uff09\(\)\{\}\-\sa-zA-Z\u3014-\u3015\u3010-\u3011]*[\d\.]*g/
#zucheng_regexp = Regexp.new("[\u4e00-\u9fa5\uff08-\uff09\\(\\)\\{\\}\\-\\sa-zA-Z\u3014-\u3015\u3010-\u3011]*[\\d\\.]*g")
zucheng_regexp = Regexp.new(yao_item + yao_weight)
#filter_zucheng_regexp = %r/([\u4e00-\u9fa5\uff08-\uff09\(\)\{\}a-zA-z\-\u3014-\u3015\u3010-\u3011]*)([\d\.]*g)/
#filter_zucheng_regexp = Regexp.new("([\u4e00-\u9fa5\uff08-\uff09\\(\\)\\{\\}\\-\\sa-zA-Z\u3014-\u3015\u3010-\u3011]*)([\\d\\.]*g)")
filter_zucheng_regexp = Regexp.new("(" + yao_item + ")" + "(" + yao_weight + ")")

dbhost="127.0.0.1"
dbname="nineteen_wu_development"
dbuser="postgres"
dbpassword="postgres"
tableName="yaofangs"

conn=PGconn.connect(dbhost,5432,'','',dbname,dbuser,dbpassword)
#conn.exec("create table rtest ( number integer default 0 );")
#conn.exec("insert into rtest values ( 99 )")
#res = conn.query("select * from rtest")

#res = conn.query("select * from yaofangs;")
#res.each do |row|
#  puts row
#end
#return 1
file=File.open("/home/dq/project/parse_yao/tt.txt","r:UTF-8")
file.each { |line| 
  line.scan(/(.*)\t(.*)\t(.*)\t(.*)/) do |yaofang, chuchu, yema, zucheng| 
    #items = zucheng.scan(/[\u4e00-\u9fa5\uff08-\uff09\(\)\{\}\-\sa-zA-Z\u3014-\u3015\u3010-\u3011]*[\d\.]*g/)
    items = zucheng.scan(zucheng_regexp)
    items.each do |item|
      #item.scan(/([\u4e00-\u9fa5\uff08-\uff09\(\)\{\}a-zA-z\-\u3014-\u3015\u3010-\u3011]*)([\d\.]*g)/) do |name, weight|
      item.scan(filter_zucheng_regexp) do |name, weight|
        if name.nil? || name.empty? || weight.nil? || weight.empty? then
          puts zucheng
          return
        end
        puts "--"
        puts "#{name}"
        puts "#{weight}"
      end
    end
    puts "--------------------"
    #db.exec("insert into yaofangs values (4, 'lixingkai', '2005-12-02');")
  end
  #case line
  #when yaofang_regexp
  #  puts "---------"
  #else
  #  puts "?" 
  #end
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
