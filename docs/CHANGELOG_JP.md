- [English](../CHANGELOG.md)

# 変更点

## 2.10.0 (2025/7/14)

* プリンターファームウェアの更新を行うAPIを追加
* 以下のプリンター機種をメンテナンスサポートとして対応
  * TSP100LAN
  * TSP650II (LAN : IFBD-HE05)
  * SP700 (LAN : IFBD-HE06)
* 詳細ステータス取得API (StarPrinterStatusDetail)にプロパティを追加
* PrinterBuilder actionSeparatorFeed()メソッドの対応機種を追加
* 不具合修正
  * StarXpandCommandBuilder APIのパラメータの指定によっては、StarPrinter.print()メソッドでクラッシュする
  * Bluetooth, USBインターフェース通信に関する不具合を修正

## 2.9.0 (2025/05/19)

* mC-Label2 に対応
* ブラックマークやダイカットラベル紙等のギャップ単位で用紙送りを実行するactionSeparatorFeedメソッドを追加
* 基本印字サイズを設定するstyleBaseMagnificationメソッドを追加
* mC-Label2（300dpiモデル）用の[Printing Samples](../example/StarXpandSDK/PrintingSamples/README.md)を追加
* 最低サポートOSバージョンを13から14に変更
* 不具合修正
  * TSP650II、TSP700II、TSP800II、SP700のLAN I/Fでオンライン復帰直後（PrinterDelegateのonReady()が呼ばれた時）のStarPrinter.print()の実行がまれに失敗する問題を修正

## 2.8.0 (2024/10/18)

* TSP100IV-UEWB およびTSP100IV-UEWB SK に対応
* プリンターの詳細情報を取得するAPIを追加
* エラーの詳細情報を取得するAPIを追加
* Swift6へのアップデート準備（サンプルアプリをSwift6でビルド可能となるよう改修）
* 不具合修正  
  * xCode16とiOS18の組み合わせで、LAN経由でプリンターの検索・通信に失敗する問題を修正 [#31](https://github.com/star-micronics/StarXpand-SDK-iOS/issues/31)

## 2.7.0 (2024/06/24)

* BSC10II に対応
* CutTypeのenumにtearOff（ティアバーまで用紙送り）を追加
* Printer.InternationalCharacterTypeのenumにindiaを追加
* autoSwitchInterfaceがfalseの場合、既に他端末がopen済みのLANプリンターに対してStarPrinter.open()を実行したとき、すぐにStarIO10Error.inUseをスローするよう変更
* 不具合修正
  * 複数台のプリンターに対して同時に印刷処理を実行した場合に、まれにクラッシュする問題を修正
  * 実際にはiOS端末がネットワークに接続されていても、まれにStarIO10Error.illegalDeviceState(message: "Network Unavailable.")がスローされることがある問題を修正

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
