Value ⇐ {
  obj ← {
    this ⇐ @
    SetThis ⇐ { !this≡@ ⋄ this↩𝕩 }

    #O ← ⊢
    B ← ⊢
    c ← ⟨⟩
    d ← 0
    g ← 0
    l ← ""

    Show ⇐ {𝕤
      #lab ← "label"‿"operation"‿"children"‿"data"‿"gradient"
      #⍉> lab ⋈ l‿o‿c‿d‿g
      lab ← "label"‿"children"‿"data"‿"gradient"
      ⍉> lab ⋈ l‿c‿d‿g
    }

    Data ⇐ {
      𝕤 ⋄ d
    }

    Grad ⇐ {
      𝕤 ⋄ g
    }

    Child ⇐ {
      𝕤 ⋄ c
    }

    #Oper ⇐ {
    #  𝕤 ⋄ o
    #}

    Label ⇐ {
      𝕤 ⋄ l
    }

    Ba ⇐ {
      B ↩ 𝕏
    }

    #Op ⇐ {
    #  O ↩ 𝕏
    #}

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
        TopoSort¨ oldV (¬∘∊/⊣)˜ ∾ { 𝕩.Child@ }¨ 𝕩
        v ↩ ⍷ 𝕩 ∾ v
        v
      }

      this.Gr 1
      { 𝕩.Back@ }¨ TopoSort this
      v
    }

    Apply ← {
      out ← Value 𝕎´ { 𝕩.Data@ }¨ 𝕩
      #out.Op 𝕨
      out.Ch 𝕩
      out
    }

    Tanh ⇐ {𝕤
      F ← •math.Tanh
      out ← Value F d
      #out.Op f
      out.Ch ⋈this

      BB ← {𝕤
        g ↩ g + (1 - 2 ⋆˜ out.Data@) × out.Grad@
      }

      out.Ba bb
      out
    }

    Add ⇐ {
      F ← +

      i ← 𝕩
      out ← f Apply this‿𝕩

      BB ← {𝕤
        i.Gr (i.Grad@) + out.Grad@
        g ↩ g + out.Grad@
      }

      out.Ba bb
      out
    }

    Mul ⇐ {
      F ← ×

      i ← 𝕩
      out ← f Apply this‿𝕩

      BB ← {𝕤
        i.Gr (i.Grad@) + d × out.Grad@
        g ↩ g + (i.Data@) × out.Grad@
      }

      out.Ba bb
      out
    }

    Exp ⇐ {𝕤
      F ← ⋆

      out ← Value F d
      #out.Op f
      out.Ch ⋈this

      BB ← {𝕤
        g ↩ g + (out.Data@) × out.Grad@
      }

      out.Ba bb
      out
    }

    Pow ⇐ {
      F ← ⋆⟜𝕩
      i ← 𝕩
      out ← Value F d
      #out.Op f
      out.Ch ⋈this


      BB ← {𝕤
        g ↩ g + (i × d ⋆ 1 -˜ i) × out.Grad@
      }

      out.Ba bb
      out
    }

    Neg ⇐ {𝕤
      this.Mul Value ¯1
    }

    Sub ⇐ {
      this.Add 𝕩.Neg@
    }

    Div ⇐ {
      this.Mul 𝕩.Pow ¯1
    }
  }

  obj.SetThis obj
  obj.Da 𝕩
  obj
}

TanhF ← ⊑ •math.Tanh
AddF ← +´
MulF ← ×´
PowF ← ⋆´
ExpF ← ⊑ ⋆

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

ops ← ⊢‿AddF‿MulF‿PowF‿ExpF‿TanhF
bops ← ⊢‿AddB‿MulB‿PowB‿ExpB‿TanhB

_a ← {
  ch ← ⥊𝕩
  vv ← 𝔽 ⊑˘ ch ⊏ 𝕨
  op ← ⊑ / 𝕗 = ops
  𝕨 ∾ ≍ vv‿0‿op‿ch
}

Add‿Mul‿Exp‿Pow‿Tanh ⇐ (AddF _a)‿(MulF _a)‿(ExpF _a)‿(PowF _a)‿(TanhF _a)

V ⇐ { ≍ 𝕩‿0‿0‿⟨⟩ }
Val ⇐ ∾⟜V

Neg ⇐ {
  (𝕨 Val ¯1) Mul 𝕩⋈≠𝕨
}

Sub ⇐ {
  a‿b ← 𝕩
  (𝕨 Neg b) Add a⋈1+≠𝕨
}

Div ⇐ {
  a‿b ← 𝕩
  ((𝕨 Val ¯1) Pow b⋈≠𝕨) Mul a⋈1+≠𝕨
}

Topo ← {
  𝕩 ∾ ∾ 𝕨 Topo⚇2‿0 ¯1 ⊑ 𝕩 ⊏ 𝕨
}

BackProp ← {
  vv ← 𝕨 ⊏ 𝕩
  back ← bops ⊑˜ 2 ⊑ vv
  𝕩 Back˜ 𝕨 ⋈ 3 ⊑ vv
}

Backward ⇐ {
  t ← 𝕨 Topo 𝕩
  i ← ⊑ t
  w ← 1⌾(1⊸⊑ i⊸⊏) 𝕨

  w BackProp´ ⌽ t
}
