Init ⇐ { ≍ 𝕩‿0‿0‿⟨⟩ }
Val ⇐ ∾⟜Init
TopoSort ⇐ ⍷ { 𝕩 ∾˜ ∾𝕨 𝕊⚇2‿0 ¯1 ⊑ 𝕩 ⊏ 𝕨 }

_apply ← {
  children ← ⥊𝕩
  value ← 𝔽 ⊑˘ children ⊏ 𝕨
  op ← ⊑ / 𝕗 = f_ops
  𝕨 ∾ ≍ value‿0‿op‿children
}

_compose_ ← { (𝕨 𝔽 1⊑𝕩) 𝔾 (⊑𝕩) ⋈ 1 + ≠𝕨 }

Add ⇐ (AddF ← +´)_apply
Mul ⇐ (MulF ← ×´)_apply
Pow ⇐ (PowF ← ⋆´)_apply
Exp ⇐ (ExpF ← ⊑ ⋆)_apply
Tanh ⇐ (TanhF ← ⊑ •math.Tanh)_apply

Neg ⇐ Val⟜¯1 Mul ⋈⟜≠˜
Rec ⇐ Val⟜¯1 Pow ⋈⟜≠˜
Sub ⇐ Neg _compose_ Add
Div ⇐ Rec _compose_ Mul

_monad ← { 𝔽´ 2 ↑ 𝕩 }
_dyad ← { (𝔽 𝕨) × 1 ⊑ 𝕩 }
_derive ← {
  out‿children ← 𝕨
  grads ← children 𝔽○(⊏⟜𝕩) out
  grads⊸+⌾(1⊸⊏˘children⊸⊏) 𝕩
}

ExpB ← ×_monad _derive
TanhB ← (⊢×1-2⋆˜⊣)_monad _derive
AddB ← 1˙_dyad _derive
MulB ← (⌽⊑˘)_dyad _derive
PowB ← ((⊢×⊣⋆1-˜⊢)´⊑˘)_dyad _derive # with respect to base only

f_ops ← ⊢‿AddF‿MulF‿PowF‿ExpF‿TanhF
b_ops ← ⊢‿AddB‿MulB‿PowB‿ExpB‿TanhB

Propagate ← {
  op‿ch ← 2‿3 ⊏ 𝕨 ⊏ 𝕩
  𝕨 ⋈⟜ch⊸(op ◶ b_ops) 𝕩
}

InitGrad ← { 1⌾(1⊸⊑ 𝕩⊸⊏) 𝕨 }
Backward ⇐ ⊣ (InitGrad⟜(¯1⊸⊑) Propagate´ ⊢) TopoSort
