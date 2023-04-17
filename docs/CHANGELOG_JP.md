- [English](../CHANGELOG.md)

# 変更点

## 2.3.0 (2023/03/31)

* mC-Label3 に対応
* スプーラー機能APIを追加
* ページモードAPIを追加
* Star Configuration設定・読み込みAPIを追加
* 詳細ステータス取得APIを追加
* スプーラー機能の印刷サンプルと、ラベル用の印刷パターンのサンプルを複数追加
* Xcode 14に対応
  * Appleの指針に基づき、Bitcodeを含まないように変更

* 不具合修正
  * インスタンス生成直後のBuilderをaddすると、コマンド生成が行われない問題を修正

## 2.2.0 (2022/05/10)

* POP10CI に対応

## 2.0.0 (2022/04/07)

* Xcode13.2/13.2.1でビルドしたアプリをiOS 12の端末で実行できない問題が、Xcode13.3で解消されたことを確認 #1

* 変更
    - StarPrinterクラスで、async指定されたメソッドはiOS13以降で使用可能となりました。
* 破壊的変更
    - StarPrinterクラスで、引数にcompletionを取るメソッドはiOS12のみ対応となりました。
        - 詳細と移行手順は、「[v1.0.0からの移行手順](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift/migration/index.html)」をご参照ください。

## 1.0.0 (2022/01/31)

* 初回リリース
