⟨Value⟩ ← •Import "value_old.bqn"
⟨Init, Val, Add, Sub, Mul, Pow, Tanh, Backward⟩ ← •Import "value.bqn"
⟨MLP⟩ ← •Import "nn_old.bqn"

Rand ← (1 -˜ 2 × •rand.Range⊸÷) 1 -˜ 2 ⋆ 32˙

Neuron ← ⊢ (⊢ Val Rand)´ ·↕ 1 + ⊣
Layer ← ⊢ Neuron´ ·/⟜⋈´∘⌽ ⊣
MLPP ← 1⊸↓ (Init @) Layer´ ·<˘∘⌽ 2⊸↕

Group ← ⌊∘÷˜⟜(↕≠)⊔⊢
Offset ← ¯1 ↓ +´¨∘↑
Ranges ← 1‿0 +⎉1 2⊸↕
#Params ← +´ ·×´˘ Ranges

Ind ← ≠⊸+⟜↕-⊢

CallLayer ← {
  mat ← 𝕨
  in‿out ← 𝕩
  sin‿sout ← in ⋈○≠ out
  weights‿biases ← sin (∾¨ ↑¨ ⋈ ¯1⊸↑¨) out

  mat Mul˜´↩ ⌽ weights ≍¨˜ ∾ sout / ⋈ in
  mat Add˜´↩ ⌽ biases ∾¨ sin Group mat Ind sin × sout
  mat Tanh˜´↩ ⌽ mat Ind sout
}

Expand ← {
  o‿r‿g ← 𝕩
  o + g Group ↕ r
}

Call ← {
  sha‿ord ← 𝕨
  𝕩 CallLayer (𝕩 Ind sha) ⋈ ∾¨ <˘ Expand ord
}

shape ← 3‿4‿4‿1
input ← ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
truth ← 1‿¯1‿¯1‿1

order ← ⍉ (¯1⊸↓ (Offset⊸≍ ×´˘) ∾ ⍉) Ranges shape
so ← <˘ (¯1 ↓ shape) ⊑⊸⋈˘ order

CallEach ← {
  mat ← 𝕩
  mat Val˜´↩ ⌽ 𝕨
  mat Call´ ⌽ so
}

F ← {
  d‿g‿o‿c ← 𝕩
  (d + ¯0.2×g)‿g‿o‿c
}

ZG ← 0¨⌾(1⊸⊏˘)

mm ← MLPP shape
offsets ← 1 -˜ 41 + (1+↕4) × 4 ÷˜ 41 -˜ 253
p ← ≠ mm

Desc ←{ 𝕤
  mm ↩ F˘ p⊸↑ mm

  mm CallEach´↩ ⌽ input

  •Show ⊑˘ offsets ⊏ mm

  mm Val˜´↩ ⌽ truth
  mm Sub˜´↩ ⌽ offsets ⋈¨ mm Ind 4

  subs ← (/0=3|1+↕12) ⊏ mm Ind 12

  mm Val˜´↩ 4/≍2
  mm Pow˜´↩ ⌽ subs ⋈¨ mm Ind 4
  mm Add↩ ⌽ mm Ind 4

  mm ↩ ZG mm
  mm Backward↩ 1 -˜ ≠mm
}

Desc⍟20 @

#m ← MLP shape
#xs ← Value⚇0 input
#ys ← Value¨ truth
#yp ← m.Call¨ xs
#loss ← @
#
#Descent ← {𝕤
#  yp ↩ m.Call¨ xs
#  loss ↩ { 𝕨.Add 𝕩 }´ yp { (𝕨.Sub 𝕩).Pow 2 }¨ ys
#
#  { 𝕩.Gr 0 }¨ m.Params@
#  loss.Backward@
#
#  { 𝕩.Da (𝕩.Data@) + ¯0.2 × 𝕩.Grad@ }¨ m.Params@
#}
#
#•Out "ground truth:"
#•Show { 𝕩.Data@ }¨ ys
#•Out "initial classification:"
#•Show { 𝕩.Data@ }¨ yp
#Descent⍟20 @
#•Out "after training:"
#•Show { 𝕩.Data@ }¨ yp
