htmlfile = "./yaocai/danggui.htm"

split_syntax = []
split_syntax.push("<p align=center><b><font size=3>(.*)</font></b>.*")
split_syntax.push("<p><b>别名</b>(.+?)</p><p>.*")
split_syntax.push("<p><b>别名</b>(.+?)</p><p>.*")

filter_zucheng_regexp = Regexp.new( split_syntax.join)

file=File.open("/home/dq/project/parse_yao/down/yaocai/danggui.htm","r:UTF-8")
file.each { |line|
  line.scan(filter_zucheng_regexp) do |name, bieming |
    puts name
    puts bieming
  end
}
file.close
