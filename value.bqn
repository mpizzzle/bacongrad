Value ⇐ {
  obj ← {
    this⇐@
    SetThis ⇐ { !this≡@ ⋄ this↩𝕩 }

    O ← ⊢
    B ← ⊢
    c ← ⟨⟩
    d ← 0
    g ← 0
    l ← ""

    Show ⇐ {𝕤
      lab ← "label"‿"operation"‿"children"‿"data"‿"gradient"
      ⍉> lab ⋈ l‿o‿c‿d‿g
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

    Label ⇐ {
      𝕤 ⋄ l
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

    La ⇐ {
      l ↩ 𝕩
    }


    Back ⇐ {
      𝕤 ⋄ B@
    }

    Backward ⇐ {𝕤
      v ← ⟨⟩

      TopoSort ← {
        oldV ← v
        TopoSort¨ oldV (¬∘∊/⊣)˜ ∾ { 𝕩.Chil@ }¨ 𝕩
        v ↩ ⍷ 𝕩 ∾ v
        v
      }

      { 𝕩.Back@ }¨ TopoSort this
      v
    }

    Apply ← {
      temp ← Value 𝕎´ { 𝕩.Repr@ }¨ 𝕩
      temp.Op 𝕨
      temp.Ch 𝕩
      temp
    }

    Tanh ⇐ {𝕤
      F ← •math.Tanh
      temp ← Value F d
      temp.Op f
      temp.Ch ⋈this

      BB ← {𝕤
        g ↩ g + 1 - 2 ⋆˜ temp.Repr@
      }

      temp.Ba bb
      temp
    }

    Add ⇐ {
      F ← +

      i ← 𝕩
      out ← f Apply this ⋈ 𝕩

      BB ← {𝕤
        i.Gr (i.Grad@) + 1 × out.Grad@
        g ↩ g + 1 × out.Grad@
      }

      out.Ba bb
      out

    }

    Mul ⇐ {
      F ← ×

      i ← 𝕩
      out ← f Apply this ⋈ 𝕩

      BB ← {𝕤
        i.Gr (i.Grad@) + d × out.Grad@
        g ↩ g + (i.Repr@) × out.Grad@
      }

      out.Ba bb
      out
    }

  }

  obj.SetThis obj
  obj.Da 𝕩
  obj
}
