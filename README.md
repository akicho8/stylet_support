## メモ

* ベジェ曲線描画の関数が用意されていても、ベジェ曲線にそって物体を移動させることはできない
* x1, y1 = points[i % points.size] は cons に置き換えれる

## 同時押しをシミューレートする例

    # A:←A S:←B D:→A F:→B
    @axis.left  << (SDL::Key.press?(SDL::Key::A) | SDL::Key.press?(SDL::Key::S))
    @axis.right << (SDL::Key.press?(SDL::Key::D) | SDL::Key.press?(SDL::Key::F))
    @button.btA << (SDL::Key.press?(SDL::Key::A) | SDL::Key.press?(SDL::Key::D))
    @button.btB << (SDL::Key.press?(SDL::Key::S) | SDL::Key.press?(SDL::Key::F))
