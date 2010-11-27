He Tried
========

TRIE に関する勉強用のレポジトリ。

TRIE の実装
-----------

 * ハッシュ
   * 勝手にそう呼んでるけど「Python による日本語自然言語処理」(http://nltk.googlecode.com/svn/trunk/doc/book-jp/ch12.html) で使われている保存方式
 * 配列
   * 空間効率が悪いため実用的ではない
 * リスト
 * ダブル配列 (Double-Array)
   * ChaSen や MeCab で採用されている方式
   * base と check の 2 つの配列を用いて TRIE を表現する
 * Succint Data Structure
   * tx-trie (http://code.google.com/p/tx-trie/) で採用されている方式

#### TRIE の周辺

 * パトリシア木
 * AC 法 (エイホ-コラシック法、Aho-Corasick algorithm)

TRIE クラスに実装されているべきメソッド
---------------------------------------

 * 挿入
   * insert(key, value)
     * TRIE にキーを挿入する
     * ただし DoubleArray の場合には入力の順序がソート済みである必要あり
 * 検索
   * exact_match(key)
     * 引数の文字列に完全一致するキーが TRIE に含まれているかどうかを真偽値で返す
   * common_prefix_search(key)
     * 引数の文字列と共通の接頭辞を持つキーの配列を返す (共通接頭辞探索)
 * 列挙
   * each
     * 検証用、ブロックを受け取り TRIE の各ノードで yield する
 * その他
   * save
     * TRIE をファイルに出力する (gzip 圧縮のオプションとかあったほうがよい？)
   * fetch
     * 用途よく分からない、darts のソースの中にあった

メモ
----

 * Double-Array + マルチバイト文字列
   * 空間効率が悪くなるため、マルチバイト文字列も 1 バイトずつに区切って各ノードに保存する
   * 参考：http://nanika.osonae.com/DArray/build.html

Links
-----
 * [tx-trie - Project Hosting on Google Code](http://code.google.com/p/tx-trie/)
 * [エイホ-コラシック法 - Wikipedia](http://ja.wikipedia.org/wiki/%E3%82%A8%E3%82%A4%E3%83%9B-%E3%82%B3%E3%83%A9%E3%82%B7%E3%83%83%E3%82%AF%E6%B3%95)
 * [Python による日本語自然言語処理](http://nltk.googlecode.com/svn/trunk/doc/book-jp/ch12.html)
 * [Double-Array Articles](http://nanika.osonae.com/DArray/)

Copyright
---------

Copyright (c) 2010 tily. See LICENSE.txt for
further details.

