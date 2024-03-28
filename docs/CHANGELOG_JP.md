- [English](../CHANGELOG.md)

# 変更点

## 2.6.1 (2024/03/27)

* 不具合修正
  * Apple社のApp Review に従い、StarIO10のプライバシーマニフェストファイルを修正（Required Reason APIは使用していません）

## 2.6.0 (2024/02/09)

* POP10CBI に対応
* テンプレート印刷APIを追加
* サンプルアプリにテンプレート印刷画面を追加
* 文字数指定APIを追加
* Unicodeあいまい文字全半角設定APIを追加
* インターフェイス自動切り替え機能をデフォルト有効に変更
* インターフェイス自動切り替え機能の切り替え速度を改善
* テンプレート印刷APIを使った印刷パターンのサンプルを複数追加
* Apple社の指針に従い、StarIO10にプライバシーマニフェストファイルを追加（Required Reason APIは使用していません）

## 2.5.0 (2023/10/27)

* MCP31CI/CBI に対応
* テキストデータからレシート画像を生成するサンプルを追加

* 不具合修正
  * 異なるセグメントのネットワークのプリンターにIPアドレス指定で印刷できるよう修正 [#14](https://github.com/star-micronics/StarXpand-SDK-iOS/issues/14)
  * `DocumentBuilder.addPrinter()`で設定した装飾（styleで始まるメソッド）が、メソッド終了時に解除されない問題を修正

## 2.4.0 (2023/09/08)

* TSP100IV SK に対応
* 最低サポートOSバージョンを12から13に変更
  * StarPrinterクラスのiOS 12用のメソッドは非推奨になります。下記メソッドはiOS 12をサポートするアプリケーションの互換性のためだけに提供され、将来的に本SDKの最低サポートOSバージョンをiOS 15に引き上げるときに削除される予定です。
    - open(completion: @escaping (Error?) -> Void) 　　
    - print(command: String, completion: @escaping (Error?) -> Void) 　　
    - print(command: String, starSpoolJobSettings: StarSpoolJobSettings, completion: @escaping (Int?, Error?) -> Void) 　　
    - print(raw: Data, completion: @escaping (Error?) -> Void) 　　
    - getStatus(completion: @escaping (StarIO10.StarPrinterStatus?, Error?) -> Void) 　　
    - getSpoolJobStatus(jobId: Int, completion: @escaping (StarSpoolJobStatus?, Error?) -> Void) 　　
    - getSpoolJobStatusList(size: Int, completion: @escaping ([StarSpoolJobStatus]?, Error?) -> Void) 　　
    - getStarConfiguration(completion: @escaping (String?, Error?) -> Void) 　　
    - getDefaultStarConfiguration(completion: @escaping (String?, Error?) -> Void) 　　
    - setStarConfiguration(starConfiguration: String, completion: @escaping (Error?) -> Void) 　　
    - close(completion: @escaping () -> Void)

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
