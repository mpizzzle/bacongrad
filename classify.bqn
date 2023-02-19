⟨Init, Val, Add, Sub, Mul, Pow, Tanh, Backward⟩ ← •Import "value.bqn"

Rand ← (1 -˜ 2 × •rand.Range⊸÷) 1 -˜ 2 ⋆ 32˙
Ranges ← 1‿0 +⎉1 2⊸↕
Group ← ⌊∘÷˜⟜(↕≠)⊔⊢
Ind ← ≠⊸+⟜↕-⊢
Offset ← ¯1 ↓ +´¨∘↑
Thing ← ¯1⊸↓ (Offset⊸≍ ×´˘) ∾ ⍉
MLP ← { ∾ Init∘Rand¨ ↕ +´ ×´˘ Ranges 𝕩 }

Layer ← {
  matty ← 𝕨
  in‿out ← 𝕩
  sin‿sout ← in ⋈○≠ out
  weights‿biases ← sin (∾¨ ↑¨ ⋈ ¯1⊸↑¨) out

  matty Mul˜´↩ ⌽ weights ≍¨˜ ∾ sout / ⋈ in
  matty Add˜´↩ ⌽ biases ∾¨ sin Group matty Ind sin × sout
  matty Tanh˜´↩ ⌽ matty Ind sout
}

Expand ← { # wtf is this
  o‿r‿g ← 𝕩
  o + g Group ↕ r
}

Address ← {
  sha‿ord ← 𝕨
  (𝕩 Ind sha) ⋈ ∾¨ <˘ Expand ord
}

shape ← 3‿4‿4‿1
input ← ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
truth ← 1‿¯1‿¯1‿1

order ← ⍉ Thing Ranges shape
so ← <˘ (¯1 ↓ shape) ⊑⊸⋈˘ order

Call ← { #should be a function of mat + shape
  matty ← 𝕩
  matty Val˜´↩ ⌽ 𝕨
  matty (⊢ Layer Address)´ ⌽ so
}

m ← MLP shape
shapeParams ← ≠m #???
offsets ← 1 -˜ shapeParams + (1+↕4) × 4 ÷˜ shapeParams -˜ 253 #???

Loss ← { #truth, offsets, matty
  matty ← 𝕩
  matty Val˜´↩ ⌽ truth
  matty Sub˜´↩ ⌽ offsets ⋈¨ matty Ind 4
  subs ← 2‿5‿8‿11 ⊏ matty Ind 12
  matty Val˜´↩ 4/≍2
  matty Pow˜´↩ ⌽ subs ⋈¨ matty Ind 4
  matty Add ⌽ matty Ind 4
}

Desc ← {
  matty ← 𝕩
  matty ↩ (⊢⋈˜⊣+¯0.2⊸×)´˘⌾(2⊸↑˘) shapeParams⊸↑ matty
  matty Call´↩ ⌽ input
  matty ↩ Loss matty
  matty ↩ 0˘⌾(1⊸⊏˘) matty
  matty Backward↩ 1 -˜ ≠matty
}

initial ← ⊑˘ offsets ⊏ m Call´ ⌽ input
m ↩ Desc⍟20 m

•Out "ground truth:"
•Show truth
•Out "initial classification:"
•Show initial
•Out "after training:"
•Show ⊑˘ offsets ⊏ m
