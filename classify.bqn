⟨Value⟩ ← •Import "value.bqn"
⟨MLP⟩ ← •Import "nn.bqn"

m ← MLP 3‿4‿4‿1

xs ← Value⚇0 ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
ys ← Value¨ 1‿¯1‿¯1‿1
yp ← m.Call¨ xs
loss ← @

Descent ← {𝕤
  yp ↩ m.Call¨ xs
  loss ↩ { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys

  { 𝕩.Gr 0 }¨ m.Params@
  loss.Backward@

  { 𝕩.Da (𝕩.Data@) + ¯0.2 × 𝕩.Grad@ }¨ m.Params@
}

•Out "ground truth:"
•Show { 𝕩.Data@ }¨ ys
•Out "initial classification:"
•Show { 𝕩.Data@ }¨ yp
Descent⍟20 @
•Out "after training:"
•Show { 𝕩.Data@ }¨ yp
