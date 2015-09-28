#coding:utf-8

class GraderSize
	def grade(s)
		s.size
	end
end
class GraderBytesize
	def grade(s)
		s.bytesize
	end
end
class GraderKinds
	def grade(s)
		h=Hash.new(0)
		s.chars{|c|h[c]+=1}
		s.size*h.size
	end
end
class GraderDuplicates
	def grade(s)
		h=Hash.new(0)
		s.chars{|c|h[c]+=1}
		s.size*(s.size-h.size+1)
	end
end
