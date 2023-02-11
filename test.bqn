#⟨Value⟩ ← •Import "value.bqn"

Tanh ← ⊑ •math.Tanh
Add ← +´
Mul ← ×´
Pow ← ⊑ ⋆

TanhB ← {
  o‿c ← 𝕨
  g ← (⊢×1-2⋆˜⊣)´ 2 ↑ o ⊏ 𝕩
  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
}

AddB ← {
  o‿c ← 𝕨
  g ← 1 ⊑ o ⊏ 𝕩
  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
}

MulB ← {
  o‿c ← 𝕨
  g ← 1 ⊑ o ⊏ 𝕩
  gs ← +⟜(⌽ g⊸×)´ <˘ ⍉ 1‿0⊸⊏˘ c ⊏ 𝕩
  gs⌾(1⊸⊏˘c⊸⊏) 𝕩 # needs further refactoring
}

PowB ← ⊢

ops ← ⊢‿Add‿Mul‿Pow‿Tanh
bops ← ⊢‿AddB‿MulB‿PowB‿TanhB

_apply ← {
  ch ← ⥊𝕩
  val ← 𝔽 ⊑˘ ch ⊏ 𝕨
  op ← ⊑ / 𝕗 = ops
  𝕨 ∾ ≍ val‿0‿op‿ch
}

Val ← {
  ≍ 𝕩‿0‿0‿⟨⟩
}

Neg ← {
  (𝕨 ∾ Val ¯1) Mul _apply 𝕩⋈≠𝕨
}

Sub ← {
  a‿b ← 𝕩
  (𝕨 Neg b) Add _apply a⋈1+≠𝕨
}

Topo ← {
  𝕩 ∾ ∾ 𝕨 Topo⚇2‿0 ¯1 ⊑ 𝕩 ⊏ 𝕨
}

BackProp ← {
  val ← 𝕨 ⊏ 𝕩
  back ← bops ⊑˜ 2 ⊑ val
  𝕩 Back˜ 𝕨 ⋈ 3 ⊑ val
}

Backward ← {
  t ← 𝕨 Topo 𝕩
  i ← ⊑ t
  w ← 1⌾(1⊸⊑ i⊸⊏) 𝕨

  w BackProp´ ⌽ t
}

mat ← Val 2
mat ∾↩ Val 0
mat ∾↩ Val ¯3
mat ∾↩ Val 1
mat Mul _apply↩ 0‿2
mat Mul _apply↩ 1‿3
mat Add _apply↩ 4‿5
mat ∾↩ Val 6.8813735870195432
mat Add _apply↩ 6‿7
mat Tanh _apply↩ 8
mat Neg↩ 9
mat Sub↩ 7‿8

mat Backward 9

#x1 ← Value 2.0
#x2 ← Value 0.0
#w1 ← Value ¯3.0
#w2 ← Value 1.0
#
#x1w1 ← x1.Mul w1
#x2w2 ← x2.Mul w2
#
#x1w1x2w2 ← x1w1.Add x2w2
#
#b ← Value 6.8813735870195432
#
#n ← x1w1x2w2.Add b
#
##o ← n.Tanh@
#e ← (n.Mul Value 2).Exp@
#o ← (e.Sub Value 1).Div (e.Add Value 1)
#
#o.Backward@
#
#!¯1.5 ≡ x1.Grad@
#!0.5 ≡ x2.Grad@
#!1 ≡ w1.Grad@
#!0 ≡ w2.Grad@
