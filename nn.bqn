⟨Value⟩ ← •Import "value.bqn"

#debug ← •BQN ⊑ •FLines "debug_weights.txt"

Rand ← {𝕤
  (1 -˜ 2 × •rand.Range⊸÷) 1 -˜ 2 ⋆ 32
}

Neuron ← {
  weights ← Value∘Rand¨ ↕𝕩
  bias ← Value Rand@

  Call ⇐ {
    act ← bias { 𝕨.Add 𝕩 }´ weights { 𝕨.Mul 𝕩 }¨ 𝕩
    act.Tanh@
  }

  Params ⇐ {𝕤
    weights ∾ bias
  }
}

Layer ← {
  shape‿count ← 𝕩
  neurons ← Neuron⟜shape¨ ↕count

  Call ⇐ {
    (1=≠) ◶ ⊢‿⊑ 𝕩⊸{ 𝕩.Call 𝕨 }¨ neurons
  }

  Params ⇐ {𝕤
    ∾ { 𝕩.Params@ }¨ neurons
  }
}

MLP ← {
  layers ← Layer˘ 2 ↕ 𝕩

  Call ⇐ {
    𝕩 { 𝕨.Call 𝕩 }´ ⌽ layers
  }

  Params ⇐ {𝕤
    ∾ { 𝕩.Params@ }¨ layers
  }
}

m ← MLP 3‿4‿4‿1
#debug { 𝕩.Da 𝕨 }¨ m.Params@

xs ← Value⚇0 ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
ys ← Value¨ 1‿¯1‿¯1‿1
yp ← m.Call¨ xs
loss ← { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys

loss.Backward@

{ 𝕩.Da (𝕩.Data@) + ¯0.01 × 𝕩.Grad@ }¨ m.Params@
•Show loss.Data@

DoThing ← {𝕤
  yp ↩ m.Call¨ xs
  loss ↩ { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys

  { 𝕩.Gr 0 }¨ m.Params@
  loss.Backward@

  { 𝕩.Da (𝕩.Data@) + ¯0.01 × 𝕩.Grad@ }¨ m.Params@
  •Show loss.Data@
}

DoThing⍟10 @
