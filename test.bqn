⟨Value⟩ ← •Import "value.bqn"

x1 ← Value 2.0
x1.La "x1"

x2 ← Value 0.0
x2.La "x2"

w1 ← Value ¯3.0
w1.La "w1"

w2 ← Value 1.0
w2.La "w2"

x1w1 ← x1.Mul w1
x2w2 ← x2.Mul w2
x1w1x2w2 ← x1w1.Add x2w2

b ← Value 6.8813735870195432
b.La "b"

n ← x1w1x2w2.Add b

#o ← n.Tanh@
e ← (n.Mul Value 2).Exp@
o ← (e.Sub Value 1).Div (e.Add Value 1)

o.Backward@

!1 ≡ w1.Grad@
!0 ≡ w2.Grad@
!¯1.5 ≡ x1.Grad@
!0.5 ≡ x2.Grad@
