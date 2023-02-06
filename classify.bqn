⟨Value⟩ ← •Import "value.bqn"
⟨MLP⟩ ← •Import "nn.bqn"

#debug ← •BQN ⊑ •FLines "debug_weights.txt"

m ← MLP 3‿4‿4‿1
#debug { 𝕩.Da 𝕨 }¨ m.Params@

xs ← Value⚇0 ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
ys ← Value¨ 1‿¯1‿¯1‿1
yp ← @
loss ← @

Descent ← {𝕤
  yp ↩ m.Call¨ xs
  loss ↩ { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys

  { 𝕩.Gr 0 }¨ m.Params@
  loss.Backward@

  { 𝕩.Da (𝕩.Data@) + ¯0.01 × 𝕩.Grad@ }¨ m.Params@
  •Show loss.Data@
}

Descent⍟10 @
