# Split ⊢ into groups of length ⊣, plus a shorter one at the end if needed
Group ⇐ ⌊∘÷˜⟜(↕≠)⊔⊢

# Left fold
_l ⇐ { 𝕨 𝔽˜´ ⌽ 𝕩 }

# Get indices of last ⊢ elements of ⊣
Last ⇐ ≠⊸+⟜↕-⊢

# Random value between 1 and ¯1
Rand ⇐ (1-˜2×•rand.Range⊸÷) 1-˜2⋆32˙
