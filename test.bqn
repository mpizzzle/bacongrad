⟨Init, Val, Add, Mul, Exp, Pow, Tanh, Neg, Sub, Div, Backward⟩ ← •Import "value.bqn"

m ← Init 2
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
