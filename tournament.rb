#coding:utf-8
class Tournament
	def self.match_name(n)
		if n==2
			'決勝'
		elsif n==4
			'準決勝'
		else
			'ベスト'+n.to_s
		end
	end
	def self.do_tournament(data,penalty,handle)
		num=1
		num*=2 while num<data.size
		first=num!=data.size
		handle.puts '## トーナメント結果発表'
		handle.puts 'お待たせ致しました！'
		handle.puts 'トーナメント結果の発表です。'
		handle.puts '結果はベスト'+(num/(first ? 2 : 1)).to_s+'から発表致します。'

		#participants=data(降順)、いない人を適当数加え、1回リフルシャッフルする。
		#dataをシャッフルしないのは、早く出した人は優先的に「予選通過」とするためである(tails氏の案)。
		#data=data.shuffle(random:RNG)
		nil_size=num-data.size
		#participants=(data+[nil]*nil_size).each_slice(num/2).to_a.transpose.flat_map{|e|e}
		participants=data[0..-nil_size-1]+(nil_size==0 ? [] : (data[-nil_size..-1]+[nil]*nil_size).each_slice(nil_size).to_a.transpose.flat_map{|e|e})
		while participants.size>1
			handle.puts '### '+match_name(participants.size) if !first
			handle.puts if !first
			handle.puts '|勝敗|名前|言語|言語ペナルティ|Byte数ペナルティ|結果ポイント|引分ランダム決着|' if !first
			handle.puts '|:--|:--|:--|:--|:--|:--|:--|' if !first
			participants_next=[]
			participants.each_slice(2).with_index{|(x,y),idx|
				if y
					x_result=-x[:grade]-penalty[x[:lang]]
					y_result=-y[:grade]-penalty[y[:lang]]
					random=false
					win=x_result>y_result ? 0 : x_result<y_result ? 1 : nil
					if !win
						random=true
						win=[0,1].sample(random:RNG)
					end
					result_str="|%s|%s|%s|%d|%d|%d|%s|\n|%s|%s|%s|%d|%d|%d|%s|\n"%[
						win==0 ? '○' : '×',x[:nickname],x[:lang],-penalty[x[:lang]],-x[:grade],x_result,random ? '○' : '×',
						win==1 ? '○' : '×',y[:nickname],y[:lang],-penalty[y[:lang]],-y[:grade],y_result,random ? '○' : '×',
					]
					handle.puts '|-|||||||' if !first&&idx>0
					handle.puts result_str if !first
					participants_next<<[x,y][win]
				else
					participants_next<<x
				end
			}
			handle.puts if !first
			participants_prev=participants
			participants=participants_next
			first=false
		end
		handle.puts 'デスマコロシアムのチャンピオンは '+participants[0][:nickname]+' 様になりました！！'
		handle.puts 'おめでとうございます！'
		handle.puts 'CodeIQオリジナルグッズ一式をプレゼントします。'
		handle.puts '後日 CodeIQ 運営担当より連絡させていただきます。'
		handle.puts (participants_prev-participants)[0][:nickname]+' 様も準優勝おめでとうございます。'
		handle.puts 'お二人にはデスマコロシアム チャンピオンバッジを付与致します。'
	end
end
