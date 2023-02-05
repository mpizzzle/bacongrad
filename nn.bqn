⟨Value⟩ ← •Import "value.bqn"

R ← {𝕤
  (1 -˜ 2 × •rand.Range ÷ ⊢) 1 -˜ 2 ⋆ 32
}

Neuron ← {
  w ← (Value R)¨ ↕𝕩
  b ← Value R@
  b.La 'b'

  Call ⇐ {
    act ← b { 𝕨.Add 𝕩 }´ (w { 𝕨.Mul 𝕩 }¨ 𝕩)
    act.Tanh@
  }

  Params ⇐ {𝕤
   w ∾ b
  }
}

Layer ← {
  d‿c ← 𝕩
  n ← (Neuron d˙)¨ ↕c

  Call ⇐ {
    𝕩⊸{ 𝕩.Call 𝕨 }¨ n
  }

  Params ⇐ {𝕤
    ∾ { 𝕩.Params@ }¨ n
  }
}

MLP ← {
  layers ← { Layer 𝕩 }˘ 2 ↕ 𝕩

  Call ⇐ {
    o ← 𝕩 { 𝕨.Call 𝕩 }´ ⌽ layers
    (1=≠) ◶ ⊢‿⊑ o
  }

  Params ⇐ {𝕤
    ∾ { 𝕩.Params@ }¨ layers
  }
}

#asdf ← (Neuron 2).Call x
#asdf.Gr 1
#> { 𝕩.Show@ }¨  asdf.Backward@

#l ← Layer 2‿3
#ns ← > { 𝕩.Show@ } ¨ l.Call Value¨ 2‿3
#> { 𝕩.Backward@ }¨ ns

m ← MLP 3‿4‿4‿1

#out ← m.Call Value¨ 1‿2‿3
#out.Gr 1
#out.Backward@

xs ← Value⚇0 ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
ys ← Value¨ 1‿¯1‿¯1‿1

yp ← m.Call¨ xs
loss ← { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys
•Show { 𝕩.Repr@ }¨ yp
•Show loss.Repr@

{ 𝕩.Gr 0 }¨ m.Params@
loss.Backward@
{ 𝕩.Da (𝕩.Repr@) + ¯0.01 × 𝕩.Grad@ }¨ m.Params@

yp ↩ m.Call¨ xs
loss ↩ { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys
•Show { 𝕩.Repr@ }¨ yp
•Show loss.Repr@

{ 𝕩.Gr 0 }¨ m.Params@
loss.Backward@
{ 𝕩.Da (𝕩.Repr@) + ¯0.01 × 𝕩.Grad@ }¨ m.Params@

yp ↩ m.Call¨ xs
loss ↩ { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys
•Show { 𝕩.Repr@ }¨ yp
loss.Repr@

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

#o ← n.Tanh@
en ← (n.Mul Value 2).Exp@
oo ← (en.Sub Value 1).Div (en.Add Value 1)

oo.Gr 1
> { 𝕩.Show@ }¨ oo.Backward@

