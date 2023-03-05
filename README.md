# bacongrad
A naïve implementation of [micrograd](https://github.com/karpathy/micrograd), written in BQN.

the test/ classify examples mirror the problems solved in Andrej's video [building micrograd](https://www.youtube.com/watch?v=VMj-3S1tku0).

```
time bqn ./classify.bqn
ground truth:
⟨ 1 ¯1 ¯1 1 ⟩
initial classification:
⟨ ¯0.7309298247891788 0.8239359951358876 0.5854469018641865 ¯0.2549002098043399 ⟩
after training:
⟨ 0.9812373917883948 ¯0.9785829090277328 ¯0.9717893108816725 0.9848284534238435 ⟩
bqn classify.bqn  0.08s user 0.02s system 99% cpu 0.101 total
```

TODO:
* add index utility functions to retrieve offsets
* better support for higher rank arrays instead of just scalar values
* fix backward pass performance (⌾ for each row is a no no)

## dependencies:
* [BQN](https://mlochbaum.github.io/BQN/)

## license
* MIT
* © 2023 Michael Percival <m@michaelpercival.xyz>
* See LICENSE file for copyright and license details.
