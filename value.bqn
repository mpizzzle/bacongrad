AddF ← +´
MulF ← ×´
PowF ← ⋆´
ExpF ← ⊑ ⋆
TanhF ← ⊑ •math.Tanh

AddB ← {
  o‿c ← 𝕨
  g ← 1 ⊑ o ⊏ 𝕩
  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
}

MulB ← {
  o‿c ← 𝕨
  g ← 1 ⊑ o ⊏ 𝕩
  gs ← +⟜(⌽ g⊸×)´ <˘ ⍉ 1‿0⊸⊏˘ c ⊏ 𝕩
  { gs }⌾(1⊸⊏˘c⊸⊏) 𝕩 # needs further refactoring
}

PowB ← {
  o‿c ← 𝕨
  g ← 1 ⊑ o ⊏ 𝕩
  d‿i ← ⊑˘ c ⊏ 𝕩
  { 𝕩 + g × i × d ⋆ 1 -˜ i }⌾(1⊸⊏·0⊸⊏ c⊸⊏) 𝕩
}

ExpB ← {
  o‿c ← 𝕨
  g ← ×´ 2 ↑ o ⊏ 𝕩
  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
}

TanhB ← {
  o‿c ← 𝕨
  g ← (⊢×1-2⋆˜⊣)´ 2 ↑ o ⊏ 𝕩
  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
}

f_ops ← ⊢‿AddF‿MulF‿PowF‿ExpF‿TanhF
b_ops ← ⊢‿AddB‿MulB‿PowB‿ExpB‿TanhB

_a ← {
  c ← ⥊𝕩
  v ← 𝔽 ⊑˘ c ⊏ 𝕨
  o ← ⊑ / 𝕗 = f_ops
  𝕨 ∾ ≍ v‿0‿o‿c
}

_x_ ← {
  a‿b ← 𝕩
  (𝕨 𝔽 b) 𝔾 a ⋈ 1 + ≠𝕨
}

Propagate ← {
  op‿ch ← 2‿3 ⊏ 𝕨 ⊏ 𝕩
  𝕨 ⋈⟜ch⊸(op ◶ b_ops) 𝕩
}

InitGrad ← { 1⌾(1⊸⊑ 𝕩⊸⊏) 𝕨 }

V ⇐ { ≍ 𝕩‿0‿0‿⟨⟩ }
Val ⇐ ∾⟜V
Add‿Mul‿Exp‿Pow‿Tanh ⇐ (AddF _a)‿(MulF _a)‿(ExpF _a)‿(PowF _a)‿(TanhF _a)
Neg ⇐ Val⟜¯1 Mul ⋈⟜≠˜
Rec ⇐ Val⟜¯1 Pow ⋈⟜≠˜
Sub ⇐ Neg _x_ Add
Div ⇐ Rec _x_ Mul
TopoSort ⇐ ⍷ { 𝕩 ∾˜ ∾𝕨 𝕊⚇2‿0 ¯1 ⊑ 𝕩 ⊏ 𝕨 }
Backward ⇐ ⊣ (InitGrad⟜(¯1⊸⊑) Propagate´ ⊢) TopoSort
