Value ⇐ {
  O ← ⊢
  B ← ⊢
  c ← ⟨⟩
  d ← 𝕩
  g ← 0
  this ← 𝕤

  Back ⇐ {
    𝕤 ⋄ B@
  }

  Show ⇐ {𝕤
    lab ← "operation"‿"children"‿"data"‿"gradient"
    ⍉> lab ⋈ o‿c‿d‿g
  }

  Repr ⇐ {
    𝕤 ⋄ d
  }

  Grad ⇐ {
    𝕤 ⋄ g
  }

  Chil ⇐ {
    𝕤 ⋄ c
  }

  Oper ⇐ {
    𝕤 ⋄ o
  }

  Ba ⇐ {
    B ↩ 𝕏
  }

  Op ⇐ {
    O ↩ 𝕏
  }

  Ch ⇐ {
    c ↩ 𝕩
  }

  Gr ⇐ {
    g ↩ 𝕩
  }

  Da ⇐ {
    d ↩ 𝕩
  }

  Apply ← {
    temp ← Value 𝕎´ 𝕩
    temp.Op 𝕨
    temp.Ch this⋈𝕩
    temp
  }

  Tanh ⇐ {𝕤
    F ← •math.Tanh
    temp ← Value F d
    temp.Op f
    temp.Ch d

    Backwards ← {𝕤
      g ↩ 1 - 2 ⋆˜ temp.Repr@
    }

    temp.Ba backwards
    temp
  }

  Add ⇐ {
    F ← +

    i ← 𝕩
    out ← f Apply d ⋈ 𝕩.Repr@

    Backwards ← {𝕤
      i.Gr 1 × out.Grad@
      g ↩ 1 × out.Grad@
    }

    out.Ba backwards
    out
  }

  Mul ⇐ {
    F ← ×

    i ← 𝕩
    out ← f Apply d ⋈ 𝕩.Repr@

    Backwards ← {𝕤
      i.Gr d × out.Grad@
      g ↩ (i.Repr@) × out.Grad@
    }

    out.Ba backwards
    out
  }
}
