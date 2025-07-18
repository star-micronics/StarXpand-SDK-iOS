# 診断情報の収集および送信について

StarIO10フレームワーク（StarIO10.xcframework）が提供する一部のAPIは、実行時にユーザー端末および接続されたプリンターの情報を収集し、スター精密株式会社が管理するクラウドサーバーへ診断情報として送信します。

## 収集される情報および診断情報の取扱いについて

- 本フレームワークが収集・送信する情報には、個人情報は含まれません。
- 収集および送信される情報は、お客様へのサービス向上およびスター精密製品の改善を目的として利用され、第三者に提供されることはありません。詳細については[こちら](https://www.star-m.jp/prjump/000192.html)をご参照ください。

## 対象API

フレームワーク バージョン V2.10.0において、情報の収集および送信を行うAPIは以下のとおりです。  
**これらのAPIを利用する場合、アプリ配信プラットフォームにおけるプライバシーポリシーに、適切な記載を行ってください。**

- [StarPrinterSetting](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-printer-setting-firmware/index.html)
  - [update()](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-printer-setting-firmware/update-async.html)


## 機能の無効化について

以下のAPIを利用することで、情報の収集および送信機能を無効化することが可能です。初期設定（デフォルト）では有効となっています。

- [StarIO10DiagInfoUpload](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-io10-diag-info-upload/index.html)
  - [isEnabled](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-io10-diag-info-upload/is-enabled.html)
