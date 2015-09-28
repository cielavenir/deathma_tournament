#coding:utf-8
class PrinterIntermidiate
	def self.print(data,handle)
		handle.puts '## エントリー者数'
		handle.puts 'エントリー者数は現在'+data.size.to_s+'名です。'
		handle.puts '(正解した最後の答案をエントリーに使うので、不正解者数のカウントは致しておりません)'
		handle.puts

		data_by_lang=Hash.new{|h,k|h[k]=[]}
		data.each{|e|
			data_by_lang[e[:lang]]<<e
		}
		result=data_by_lang.map{|k,v|
			[
				k,
				v.size,
				(-10*(v.size-1)).to_s+' point',
				v.map{|e|e[:grade]}.min,
				(v.map{|e|e[:grade]}.reduce(:+)+v.size/2)/v.size,
				v.map{|e|e[:grade]}.min+10*(v.size-1),
			]
		}

		handle.puts '## 空き言語'
		handle.puts '人数が0の言語は以下のとおりです。'
		handle.puts
		handle.puts '~~~'
		langs=result.map{|e|e[0]}
		puts LANGS-langs
		handle.puts '~~~'
		handle.puts

		handle.puts '## 挑戦状況'
		handle.puts '現在の挑戦状況です(ペナルティ順にソート)。'
		handle.puts
		handle.puts '|言語名|人数|言語ペナルティ|最小Byte数|平均Byte数|ペナルティ|'
		handle.puts '|:--|:--|:--|:--|:--|:--|'
		result.sort_by{|e|e[5]}.each{|e|
			handle.puts '|'+e.join('|')+'|'
		}
	end
end

class PrinterFinal
	def self.print(data,handle)
		handle.puts '## エントリー者数'
		handle.puts 'エントリー者数は'+data.size.to_s+'名です。'
		handle.puts '(正解した最後の答案をエントリーに使うので、不正解者数のカウントは致しておりません)'
		handle.puts

		data_by_lang=Hash.new{|h,k|h[k]=[]}
		data.each{|e|
			data_by_lang[e[:lang]]<<e
		}
		result=[]
		shortest=[]
		penalty={}
		data_by_lang.each{|k,v|
			result<<[
				k,
				v.size,
				(-10*(v.size-1)).to_s+' point',
				v.map{|e|e[:grade]}.min,
				(v.map{|e|e[:grade]}.reduce(:+)+v.size/2)/v.size,
				v.map{|e|e[:grade]}.min+10*(v.size-1),
			]
			shortest<<[k,v.map{|e|e[:grade]}.min,v.min_by{|e|e[:grade]}[:nickname]]
			penalty[k]=10*(v.size-1)
		}

		handle.puts '## 言語内訳(言語順)'
		handle.puts
		handle.puts '|言語名|人数|言語ペナルティ|最小Byte数|平均Byte数|ペナルティ|'
		handle.puts '|:--|:--|:--|:--|:--|:--|'
		result.sort.each{|e|
			handle.puts '|'+e.join('|')+'|'
		}
		handle.puts

		handle.puts '## 最小Byte数'
		handle.puts '最小Byte数達成者にはチャンピオンバッジを付与します。'
		handle.puts '※付与するバッジは一番上位のものを1つだけです。'
		handle.puts '※以下のリストは敬称略'
		handle.puts
		handle.puts '|言語|文字数|名前|'
		handle.puts '|:--|:--|:--|'
		[shortest.min_by{|e|e[1].to_i}].each{|e|
			handle.puts '|'+e.join('|')+'|'
		}
		handle.puts

		handle.puts '## 言語別最小Byte数'
		handle.puts '言語別最小Byte数達成者には強豪バッジを付与します。'
		handle.puts '※付与するバッジは一番上位のものを1つだけです。'
		handle.puts '※以下のリストは敬称略'
		handle.puts
		handle.puts '|言語|文字数|名前|'
		handle.puts '|:--|:--|:--|'
		shortest.sort.each{|e|
			handle.puts '|'+e.join('|')+'|'
		}
		handle.puts

		penalty
	end
end
