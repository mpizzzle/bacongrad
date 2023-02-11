#⟨Value⟩ ← •Import "value.bqn"
⟨V, Val, Add, Mul, Exp, Pow, Tanh, Neg, Sub, Div, Backward⟩ ← •Import "value.bqn"

#TanhF ← ⊑ •math.Tanh
#AddF ← +´
#MulF ← ×´
#PowF ← ⋆´
#ExpF ← ⊑ ⋆
#
#TanhB ← {
#  o‿c ← 𝕨
#  g ← (⊢×1-2⋆˜⊣)´ 2 ↑ o ⊏ 𝕩
#  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
#}
#
#AddB ← {
#  o‿c ← 𝕨
#  g ← 1 ⊑ o ⊏ 𝕩
#  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
#}
#
#MulB ← {
#  o‿c ← 𝕨
#  g ← 1 ⊑ o ⊏ 𝕩
#  gs ← +⟜(⌽ g⊸×)´ <˘ ⍉ 1‿0⊸⊏˘ c ⊏ 𝕩
#  gs⌾(1⊸⊏˘c⊸⊏) 𝕩 # needs further refactoring
#}
#
#PowB ← {
#  o‿c ← 𝕨
#  g ← 1 ⊑ o ⊏ 𝕩
#  d‿i ← ⊑˘ c ⊏ 𝕩
#  { 𝕩 + g × i × d ⋆ 1 -˜ i }⌾(1⊸⊏·0⊸⊏ c⊸⊏) 𝕩
#}
#
#ExpB ← {
#  o‿c ← 𝕨
#  g ← ×´ 2 ↑ o ⊏ 𝕩
#  g⊸+⌾(1⊸⊏˘c⊸⊏) 𝕩
#}
#
#ops ← ⊢‿AddF‿MulF‿PowF‿ExpF‿TanhF
#bops ← ⊢‿AddB‿MulB‿PowB‿ExpB‿TanhB
#
#_a ← {
#  ch ← ⥊𝕩
#  vv ← 𝔽 ⊑˘ ch ⊏ 𝕨
#  op ← ⊑ / 𝕗 = ops
#  𝕨 ∾ ≍ vv‿0‿op‿ch
#}
#
#Add‿Mul‿Exp‿Pow‿Tanh ← (AddF _a)‿(MulF _a)‿(ExpF _a)‿(PowF _a)‿(TanhF _a)
#
#V ← { ≍ 𝕩‿0‿0‿⟨⟩ }
#Val ← ∾⟜V
#
#Neg ← {
#  (𝕨 Val ¯1) Mul 𝕩⋈≠𝕨
#}
#
#Sub ← {
#  a‿b ← 𝕩
#  (𝕨 Neg b) Add a⋈1+≠𝕨
#}
#
#Div ← {
#  a‿b ← 𝕩
#  ((𝕨 Val ¯1) Pow b⋈≠𝕨) Mul a⋈1+≠𝕨
#}
#
#Topo ← {
#  𝕩 ∾ ∾ 𝕨 Topo⚇2‿0 ¯1 ⊑ 𝕩 ⊏ 𝕨
#}
#
#BackProp ← {
#  vv ← 𝕨 ⊏ 𝕩
#  back ← bops ⊑˜ 2 ⊑ vv
#  𝕩 Back˜ 𝕨 ⋈ 3 ⊑ vv
#}
#
#Backward ← {
#  t ← 𝕨 Topo 𝕩
#  i ← ⊑ t
#  w ← 1⌾(1⊸⊑ i⊸⊏) 𝕨
#
#  w BackProp´ ⌽ t
#}

mat ← V 2
mat Val↩ 0
mat Val↩ ¯3
mat Val↩ 1
mat Mul↩ 0‿2
mat Mul↩ 1‿3
mat Add↩ 4‿5
mat Val↩ 6.8813735870195432
mat Add↩ 6‿7

#mat Tanh↩ 8
#mat Backward 9

mat Val↩ 2
mat Mul↩ 8‿9
mat Exp↩ 10
mat Val↩ 1
mat Sub↩ 11‿12
mat Val↩ 1
mat Add↩ 11‿16
mat Div↩ 15‿17
mat Backward 20

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
