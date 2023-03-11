⟨Init, Val, Add, Sub, Mul, Pow, Tanh, Backward⟩ ← •Import "value.bqn"
⟨Rand, Group, Last, _l⟩ ← •Import "util.bqn"

Layer ← {
  in ← (m ← 𝕨) Last 1 -˜ ≠ ⊑ out ← 𝕩
  weights‿biases ← in ≠⊸(∾¨ ↑¨ ⋈ ¯1⊸↑¨) out

  m Mul _l↩ weights ≍¨˜ ∾ out ≠⊸/ ⋈ in
  m Add _l↩ biases ∾¨ in (⊣ Group m Last ×)○≠ out
  m Tanh _l m Last ≠out
}

shape ← 3‿4‿4‿1
input ← ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
truth ← 1‿¯1‿¯1‿1
ranges ← ×´˘ 1‿0 +⎉1 2⊸↕ shape
params ← ranges Group¨⟜(↕¨++`⊸-)˜ 1 + ¯1 ↓ shape
mlp ← ∾ Init∘Rand¨ ↕ p ← +´ ranges
offsets ← 93‿146‿199‿252 #???

Call ← Val _l Layer _l params˙

Loss ← {
  m ← 𝕩 Val _l truth
  m Sub _l↩ offsets ⋈¨ m Last si ← ≠input
  m Val _l↩ si/≍2
  m Pow _l↩ (si -˜ 2‿5‿8‿11 ⊏ m Last 3 × si) ⋈¨ m Last si #???
  m Add ⌽ m Last si
}

Descent ← {
  m ← (p↑𝕩) Call _l input
  m ↩ Loss m
  m ↩ 0˘⌾(1⊸⊏˘) m
  m Backward↩ 1 -˜ ≠m
  (⊢⋈˜⊣+¯0.2⊸×)´˘⌾(2⊸↑˘p⊸↑) m
}

•Out "ground truth:"
•Show truth
•Out "initial classification:"
•Show ⊑˘ offsets ⊏ mlp Call _l input
•Out "after training:"
•Show ⊑˘ offsets ⊏ Descent⍟20 mlp
