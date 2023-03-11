⟨Val, Add, Sub, Pow, Backward⟩ ← •Import "value.bqn"
⟨Last, _l⟩ ← •Import "util.bqn"
⟨MLP, Address, _bindCall⟩ ← •Import "mlp.bqn"

shape ← 3‿4‿4‿1
input ← ⟨2,3,¯1⟩‿⟨3,¯1,0.5⟩‿⟨0.5,1,1⟩‿⟨1,1,¯1⟩
truth ← 1‿¯1‿¯1‿1

nn ← MLP shape
offsets ← 93‿146‿199‿252 #???

Call ← (Address shape) _bindCall

Loss ← {
  m ← 𝕩 Val _l truth
  m Sub _l↩ offsets ⋈¨ m Last si ← ≠input
  m Val _l↩ si/≍2
  m Pow _l↩ (si -˜ 2‿5‿8‿11 ⊏ m Last 3 × si) ⋈¨ m Last si #???
  m Add m Last si
}

Descent ← (≠nn)⊸{
  m ← (𝕨↑𝕩) Call input
  m ↩ 0˘⌾(1⊸⊏˘) Loss m
  m Backward↩ 1 -˜ ≠m
  (⊢⋈˜⊣+¯0.2⊸×)´˘⌾(2⊸↑˘𝕨⊸↑) m
}

•Out "ground truth:"
•Show truth
•Out "initial classification:"
•Show ⊑˘ offsets ⊏ nn Call input
•Out "after training:"
•Show ⊑˘ offsets ⊏ Descent⍟20 nn
