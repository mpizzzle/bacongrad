⟨Gnuplot⟩ ← •Import "Gnuplot.bqn"
⟨Value⟩ ← •Import "value.bqn"

F ← { (3 × 𝕩 ⋆ 2) + (¯4 × 𝕩) + 5 }

h ← 0.000001

xs ← 5-˜4÷˜↕40
ys ← F xs

#plt ← Gnuplot ""
#plt.Plot (⍉xs≍ys)‿"lw 2 lc rgb 'black'"
#plt.Show @

aa ← Value 2
#aa.Gr ¯3 × ¯2

bb ← Value ¯3
#bb.Gr 2 × ¯2

cc ← Value 10
#cc.Gr ¯2 × 1

ee ← (aa.Mul bb)
#ee.Gr ¯2 × 1

dd ← (ee.Add cc)
#dd.Gr ¯2

ff ← Value ¯2
#ff.Gr 4

l ← dd.Mul ff
l.Gr 1

l.Backward@

#th ← •math.Tanh 5 -˜ 5 ÷˜ ↕50
#plt ← Gnuplot ""
#plt.Plot th‿"lw 2 lc rgb 'black'"
#plt.Show @

x1 ← Value 2.0
x1.La "x1"
#x1.Gr ¯3.0 × 0.5

x2 ← Value 0.0
x2.La "x2"
#x2.Gr 1.0 × 0.5

w1 ← Value ¯3.0
w1.La "w1"
#w1.Gr 2.0 × 0.5

w2 ← Value 1.0
w2.La "w2"
#w2.Gr 0.0 × 0.5

x1w1 ← x1.Mul w1
#x1w1.Gr 0.5
x1w1.Show@

x2w2 ← x2.Mul w2
#x2w2.Gr 0.5
x2w2.Show@

x1w1x2w2 ← x1w1.Add x2w2
#x1w1x2w2.Gr 0.5
x1w1x2w2.Show@

b ← Value 6.8813735870195432
b.La "b"
#b.Gr 0.5
b.Show@

n ← x1w1x2w2.Add b
#n.Gr 1 - 2 ⋆˜ (n.Tanh@).Repr@
n.Show@

o ← n.Tanh@
o.Gr 1
o.Show@

> { 𝕩.Show@ }¨ o.Backward@

aaa ← Value 7
bbb ← aaa.Add aaa
bbb.Gr 1.0
> { 𝕩.Show@ }¨ bbb.Backward@

