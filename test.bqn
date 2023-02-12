#⟨Value⟩ ← •Import "value_old.bqn"
⟨V, Val, Add, Mul, Exp, Pow, Tanh, Neg, Sub, Div, Backward⟩ ← •Import "value.bqn"

m ← V 2
m Val↩ 0
m Val↩ ¯3
m Val↩ 1
m Mul↩ 0‿2
m Mul↩ 1‿3
m Add↩ 4‿5
m Val↩ 6.8813735870195432
m Add↩ 6‿7

#m Tanh↩ 8
#m Backward 9

m Val↩ 2
m Mul↩ 8‿9
m Exp↩ 10
m Val↩ 1
m Sub↩ 11‿12
m Val↩ 1
m Add↩ 11‿16
m Div↩ 15‿17

m Backward↩ 20
!¯1.5‿0.5‿1‿0 ≡ (4↑ 1⊸⊏˘ m)

#x1 ← Value 2.0
#x2 ← Value 0.0
#w1 ← Value ¯3.0
#w2 ← Value 1.0
#
#x1w1 ← x1.Mul w1
#x2w2 ← x2.Mul w2
#
#x1w1x2w2 ← x1w1.Add x2w2
#
#b ← Value 6.8813735870195432
#
#n ← x1w1x2w2.Add b
#
##o ← n.Tanh@
#e ← (n.Mul Value 2).Exp@
#o ← (e.Sub Value 1).Div (e.Add Value 1)
#
#o.Backward@
#
#!¯1.5 ≡ x1.Grad@
#!0.5 ≡ x2.Grad@
#!1 ≡ w1.Grad@
#!0 ≡ w2.Grad@
