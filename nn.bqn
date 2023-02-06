⟨Value⟩ ← •Import "value.bqn"

Rand ← {𝕤
  (1 -˜ 2 × •rand.Range⊸÷) 1 -˜ 2 ⋆ 32
}

Neuron ⇐ {
  weights ← Value∘Rand¨ ↕𝕩
  bias ← Value Rand@

  Call ⇐ {
    act ← bias { 𝕨.Add 𝕩 }´ weights { 𝕨.Mul 𝕩 }¨ 𝕩
    act.Tanh@
  }

  Params ⇐ {𝕤
    weights ∾ bias
  }
}

Layer ⇐ {
  shape‿count ← 𝕩
  neurons ← Neuron⟜shape¨ ↕count

  Call ⇐ {
    (1=≠) ◶ ⊢‿⊑ 𝕩⊸{ 𝕩.Call 𝕨 }¨ neurons
  }

  Params ⇐ {𝕤
    ∾ { 𝕩.Params@ }¨ neurons
  }
}

MLP ⇐ {
  layers ← Layer˘ 2 ↕ 𝕩

  Call ⇐ {
    𝕩 { 𝕨.Call 𝕩 }´ ⌽ layers
  }

  Params ⇐ {𝕤
    ∾ { 𝕩.Params@ }¨ layers
  }
}
