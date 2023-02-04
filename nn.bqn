⟨Gnuplot⟩ ← •Import "Gnuplot.bqn"
⟨Value⟩ ← •Import "value.bqn"

F ← { (3 × 𝕩 ⋆ 2) + (¯4 × 𝕩) + 5 }

h ← 0.000001
#x ← 2 ÷ 3

#((F x + h) - F x) ÷ h

xs ← 5-˜4÷˜↕40
ys ← F xs

#plt ← Gnuplot ""
#plt.Plot (⍉xs≍ys)‿"lw 2 lc rgb 'black'"
#plt.Show @

#a ← 2
#b ← ¯3
#c ← 10
#d1 ← c + a × b
#
##a ↩ a + h
##d2 ← c + a × b
##h ÷˜ d2 - d1
#
#b ↩ b + h
#d3 ← c + a × b
#h ÷˜ d3 - d1

#Value ← {
#  O ← ⊢
#  B ← ⊢
#  c ← ⟨⟩
#  d ← 𝕩
#  g ← 0
#  this ← 𝕤
#
#  Back ⇐ {
#    𝕤 ⋄ B@
#  }
#
#  Show ⇐ {𝕤
#    lab ← "operation"‿"children"‿"data"‿"gradient"
#    ⍉> lab ⋈ o‿c‿d‿g
#  }
#
#  Repr ⇐ {
#    𝕤 ⋄ d
#  }
#
#  Grad ⇐ {
#    𝕤 ⋄ g
#  }
#
#  Chil ⇐ {
#    𝕤 ⋄ c
#  }
#
#  Oper ⇐ {
#    𝕤 ⋄ o
#  }
#
#  Ba ⇐ {
#    B ↩ 𝕏
#  }
#
#  Op ⇐ {
#    O ↩ 𝕏
#  }
#
#  Ch ⇐ {
#    c ↩ 𝕩
#  }
#
#  Gr ⇐ {
#    g ↩ 𝕩
#  }
#
#  Da ⇐ {
#    d ↩ 𝕩
#  }
#
#  Apply ← {
#    temp ← Value 𝕎´ 𝕩
#    temp.Op 𝕨
#    temp.Ch this⋈𝕩
#    temp
#  }
#
#  Tanh ⇐ {𝕤
#    F ← •math.Tanh
#    temp ← Value F d
#    temp.Op f
#    temp.Ch d
#
#    Backwards ← {𝕤
#      g ↩ 1 - 2 ⋆˜ temp.Repr@
#    }
#
#    temp.Ba backwards
#    temp
#  }
#
#  Add ⇐ {
#    F ← +
#
#    i ← 𝕩
#    out ← f Apply d ⋈ 𝕩.Repr@
#
#    Backwards ← {𝕤
#      i.Gr 1 × out.Grad@
#      g ↩ 1 × out.Grad@
#    }
#
#    out.Ba backwards
#    out
#  }
#
#  Mul ⇐ {
#    F ← ×
#
#    i ← 𝕩
#    out ← f Apply d ⋈ 𝕩.Repr@
#
#    Backwards ← {𝕤
#      i.Gr d × out.Grad@
#      g ↩ (i.Repr@) × out.Grad@
#    }
#
#    out.Ba backwards
#    out
#  }
#}


Lol ← {𝕤
  h ← 0.0001
  aa ← Value 2.0
  bb ← Value ¯3.0
  cc ← Value 10
  ee ← (aa.Mul bb)
  dd ← (ee.Add cc)
  ff ← Value ¯2.0
  l1 ← (dd.Mul ff).Repr@

  aa ↩ Value 2.0
  bb ↩ Value ¯3.0
  cc ↩ Value 10
  ee ↩ (aa.Mul bb)
  dd ↩ (ee.Add cc)
  dd.Da h + dd.Repr@
  ff ↩ Value ¯2.0
  l2 ← (dd.Mul ff).Repr@

  (l2 - l1) ÷ h
}

Lol@

aa ← Value 2
#aa.Gr ¯3 × ¯2
aa.Show@

bb ← Value ¯3
#bb.Gr 2 × ¯2
bb.Show@

cc ← Value 10
#cc.Gr ¯2 × 1
cc.Show@

ee ← (aa.Mul bb)
#ee.Gr ¯2 × 1
ee.Show@

dd ← (ee.Add cc)
#dd.Gr ¯2
dd.Show@

ff ← Value ¯2
#ff.Gr 4
ff.Show@

l ← dd.Mul ff
l.Gr 1
l.Show@

l.Back@
ff.Show@
dd.Show@
dd.Back@
ee.Show@
cc.Show@
ee.Back@
aa.Show@
bb.Show@

#th ← •math.Tanh 5 -˜ 5 ÷˜ ↕50
#plt ← Gnuplot ""
#plt.Plot th‿"lw 2 lc rgb 'black'"
#plt.Show @

x1 ← Value 2.0
#x1.Gr ¯3.0 × 0.5
x1.Show@

x2 ← Value 0.0
#x2.Gr 1.0 × 0.5
x2.Show@

w1 ← Value ¯3.0
#w1.Gr 2.0 × 0.5
w1.Show@

w2 ← Value 1.0
#w2.Gr 0.0 × 0.5
w2.Show@

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
#b.Gr 0.5
b.Show@

n ← x1w1x2w2.Add b
#n.Gr 1 - 2 ⋆˜ (n.Tanh@).Repr@
n.Show@

o ← n.Tanh@
o.Gr 1
o.Show@
o.Back@
n.Show@
n.Back@
x1w1x2w2.Show@
b.Show@

x1w1x2w2.Back@
x1w1.Show@
x2w2.Show@
qwer ← ⊑ x2w2.Chil@
(Qwer@).Show@

x1w1.Back@
x2w2.Back@

x1.Show@
x2.Show@
w1.Show@
w2.Show@
