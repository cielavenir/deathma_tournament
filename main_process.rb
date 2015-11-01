#!/usr/bin/ruby
#coding:utf-8
raise 'Ruby 1.9+ required' if RUBY_VERSION<'1.9'
Encoding.default_external='UTF-8'

require 'json'

require_relative 'const'
require_relative 'graders'
require_relative 'printers'
require_relative 'tournament'

if __FILE__==$0
	if ARGV.size<1 && STDIN.tty?
		STDERR.puts 'main_process.rb data.json >output.md'
		exit
	end

	grader=GraderBytesize.new
	data=JSON.parse($<.read,symbolize_names:true).map!{|e|
		e[:grade]=grader.grade(e[:code])
		e
	}

	if false
		PrinterIntermidiate.print(data,STDOUT)
	else
		badge={}
		data.each{|e|badge[e[:nickname]]=0}
		penalty=PrinterFinal.print(data,STDOUT,badge)
		Tournament.do_tournament(data,penalty,STDOUT,badge)
		#badge.each{|k,v|puts k+','+BADGE_NAME[v]}
	end
end

__END__
【相違点】
・1回でも正解すれば、正解した最後の答案をエントリーに使うので、不正解者数は計上しない
・グラフは省略

・JSONは、
{"log_id":Int,"nickname":String,"try_no":Int,"time":Time,"comment":String,"lang":String,"code":String}
の配列
・データが降順かつユニークになっていることはread側(非公開)が担保する
