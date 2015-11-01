#coding:utf-8
#実行くんとかで拾ってくる
LANGS=["Ada", "Assembler", "AWK (gawk)", "AWK (mawk)", "Bash", "bc", "Brainf**k", "C", "C#", "C++11", "C99 strict", "CLIPS", "Clojure", "COBOL", "COBOL 85", "Common Lisp (clisp)", "D", "D (dmd)", "Erlang", "F#", "Factor", "Falcon", "Forth", "Fortran", "Go", "Groovy", "Haskell", "Icon", "Intercal", "Java7", "Java8", "JavaScript (rhino)", "JavaScript (spidermonkey)", "Lua", "Nemerle", "Nice", "Node.js", "Objective-C", "Ocaml", "Octave", "Oz", "Pascal (fpc)", "Pascal (gpc)", "Perl", "Perl 6", "PHP", "Pike", "Prolog (gnu)", "Prolog (swi)", "Python", "Python 3", "R", "Ruby", "Scala", "Scheme (chicken)", "Scheme (guile)", "Smalltalk", "SQL", "Tcl", "Unlambda", "VB.NET", "Whitespace"]
#バッジ名
BADGE_NAME=['ファイター','強豪','豪傑','チャンピオン']
#preprocessやpostprocessの特殊処理があれば
DIR=File.dirname(File.expand_path(__FILE__))
#乱数
SEED=224694682261322206691635355878721737713
RNG=Random.new(SEED)
