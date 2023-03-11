⟨Init, Val, Add, Mul, Tanh⟩ ← •Import "value.bqn"
⟨Rand, Group, Last, _l⟩ ← •Import "util.bqn"

Ranges ← ×´˘ 1‿0 +⎉1 2⊸↕

Layer ← {
  in ← (m ← 𝕨) Last 1 -˜ ≠ ⊑ out ← 𝕩
  weights‿biases ← in ≠⊸(∾¨ ↑¨ ⋈ ¯1⊸↑¨) out

  m Mul _l↩ weights ≍¨˜ ∾ out ≠⊸/ ⋈ in
  m Add _l↩ biases ∾¨ in (⊣ Group m Last ×)○≠ out
  m Tanh _l m Last ≠out
}

MLP ⇐ { ∾ Init∘Rand¨ ↕ +´ Ranges 𝕩 }
Address ⇐ Ranges Group¨⟜(↕¨++`⊸-)˜ 1 + ¯1⊸↓
_bindCall ⇐ { (Val _l Layer _l 𝔽) _l }
