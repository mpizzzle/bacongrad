⟨Init, Val, Add, Sub, Mul, Pow, Tanh, Backward⟩ ← •Import "value.bqn"

Rand ← (1 -˜ 2 × •rand.Range⊸÷) 1 -˜ 2 ⋆ 32˙
Ranges ← ×´˘ 1‿0 +⎉1 2⊸↕
Group ← ⌊∘÷˜⟜(↕≠)⊔⊢
Ind ← ≠⊸+⟜↕-⊢

Layer ← {
  matty ← 𝕨
  in‿out ← 𝕩
  sin‿sout ← in ⋈○≠ out
  weights‿biases ← sin (∾¨ ↑¨ ⋈ ¯1⊸↑¨) out

  matty Mul˜´↩ ⌽ weights ≍¨˜ ∾ sout / ⋈ in
  matty Add˜´↩ ⌽ biases ∾¨ sin Group matty Ind sin × sout
  matty Tanh˜´↩ ⌽ matty Ind sout
}

shape ← 3‿4‿4‿1
input ← ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
truth ← 1‿¯1‿¯1‿1
mlp ← ∾ Init∘Rand¨ ↕ +´ Ranges shape
params ← ≠mlp
offsets ← 1 -˜ params + (1+↕4) × 4 ÷˜ params -˜ 253 #???
address ← (⌽ ¯1⊸↓ (⊣ ⋈ 1⊸+⊸Group)¨⟜(↕¨++`⊸-) Ranges) shape

Call ← Val˜´⟜⌽˜ (⊢ Layer Ind⟜⊑˜ ⋈ 1⊸⊑˜)´ address˙

Loss ← { #truth, offsets, matty ???
  matty ← 𝕩
  matty Val˜´↩ ⌽ truth
  matty Sub˜´↩ ⌽ offsets ⋈¨ matty Ind 4
  subs ← 2‿5‿8‿11 ⊏ matty Ind 12 #???
  matty Val˜´↩ ⌽ 4/≍2
  matty Pow˜´↩ ⌽ subs ⋈¨ matty Ind 4
  matty Add ⌽ matty Ind 4
}

Desc ← {
  matty ← 𝕩
  matty ↩ (⊢⋈˜⊣+¯0.2⊸×)´˘⌾(2⊸↑˘) params⊸↑ matty
  matty Call´↩ ⌽ input
  matty ↩ Loss matty
  matty ↩ 0˘⌾(1⊸⊏˘) matty
  matty Backward↩ 1 -˜ ≠matty
}

•Out "ground truth:"
•Show truth
•Out "initial classification:"
•Show ⊑˘ offsets ⊏ mlp Call´ ⌽ input
•Out "after training:"
•Show ⊑˘ offsets ⊏ Desc⍟20 mlp
