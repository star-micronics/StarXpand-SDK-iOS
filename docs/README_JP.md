
<div style="text-align: center;">
  <img
    src="logo.png"
    width="600"
    style="margin-top: 20px; margin-bottom: 20px;"
  />
</div>

- [English](../README.md)

# StarXpand SDK for iOS

`StarXpand SDK for iOS`はスター精密デバイス向けアプリケーション開発をサポートするソフトウェア開発キットです。

本ソフトウェア開発キットでは、スター精密デバイスを制御するためのフレームワークとして、StarIO10フレームワーク(StarIO10.xcframework)を提供しています。

Apple社の指針に従い、StarIO10 V2.6.1以降はプライバシーマニフェストファイルを含みます。Manifest fileについては[こちら](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files)をご参照ください。ただし、StarIO10では過去バージョンを含め、Required Reason APIは使用しておりません。（2024年1月29日現在）

## ドキュメント

StarXpand SDKのドキュメントは[こちら](https://www.star-m.jp/starxpandsdk-oml.html)を参照ください。

ドキュメントにはSDKの概要、サンプルアプリのビルド方法、APIの使用方法、APIリファレンスなどが含まれます。

## 動作環境

| Language | Language Version | Platform | OS Version | Arch | Test Environment[*](#TestEnvironment) |
| --- | --- | --- | --- | --- | --- |
| Swift | 5 |iOS | iOS 14.0 以降 | 実機: arm64<br> シミュレータ: arm64, x86_64 | Xcode 16.3 |

<a id="TestEnvironment"></a>*SDK同梱のサンプルアプリをビルドして動作することを確認しています。

## 導入

### 1. StarIO10フレームワークをプロジェクトへ追加する

StarIO10フレームワークをiOSアプリケーションに組み込むには、Swift Package Managerを使用します。

1. Xcodeの`File`メニュー > `Add Packages...` を選択します。
2. URL入力欄に `https://github.com/star-micronics/StarXpand-SDK-iOS` と入力します。
3. `StarXpand-SDK-iOS` を選択し、`Add Package`ボタンを押します。

Swift Packageを組み込む手順の詳細については下記URLをご覧ください。

https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app

### 2. 事前手順

プリンターのインターフェースによって、必要な対応があります。  
下記表を確認し対応をしてください。

| プリンターのインターフェース  | 必要な対応                                                                                |
|--------------------------|-----------------------------------------------------------------------------------------|
| Bluetooth                | [2.1.](#SupportedEAProtocols) & [2.2.](#BluetoothAlwaysUsageDescription) & [2.4.](#MFi) |
| Bluetooth Low Energy     | [2.2.](#BluetoothAlwaysUsageDescription)                                                |
| Ethernet                 | [2.3.](#LocalNetworkUsageDescription)                                                   |
| Lightning USB           | [2.1.](#SupportedEAProtocols) & [2.4.](#MFi)                                            |

<a id="SupportedEAProtocols"></a>
#### 2.1. `Supported external accessory protocols` 項目の設定

1. Information Property List（デフォルトでは"Info.plist"）を選択します。
2. Keyに `Supported external accessory protocols` を追加します。
3. 項目名左側の▽をクリックして表示される"Item 0"の[Value]に `jp.star-m.starpro` を設定します。

> :warning: 該当するプリンターを使用しない場合は、この設定を行わないでください。

<a id="BluetoothAlwaysUsageDescription"></a>
#### 2.2. `Bluetooth Always Usage Description` 項目の設定

1. Information Property List（デフォルトでは"Info.plist"）を選択します。
2. Keyに `Privacy - Bluetooth Always Usage Description` を追加します。
3. Value に Bluetoothの利用目的（例: `Use Bluetooth for communication with the printer.`）を設定します。
4. Bluetoothにてプリンターと通信するとき、Bluetoothへのアクセス許可を求めるダイアログが表示されます。その際、Valueに設定した文字列がBluetoothを利用する理由として表示されます。

より詳しくは、下記URLを参照してください。

https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothperipheralusagedescription

<a id="LocalNetworkUsageDescription"></a>
#### 2.3. `Local Network Usage Description` 項目の設定

1. Information Property List（デフォルトでは"Info.plist"）を選択します。
2. Keyに `Privacy - Local Network Usage Description` を追加します。
3. Value に Local Networkの利用目的（例: `Use Local Network for communication with the printer or discovery the printers.`）を設定します。
4. Ethernetプリンターと通信するとき、Local Networkへのアクセス許可を求めるダイアログが表示されます。その際、Valueに設定した文字列がLocal Networkを利用する理由として表示されます。

<a id="MFi"></a>
#### 2.4. MFi対応プリンター向けアプリ認証を取得

MFi認証プリンターに対応したiOSアプリケーションを設計・開発し、 Apple iTunes App Storeにアプリケーション登録を行う場合、下記のURLに記載の手順によりアプリ認証を取得してください。Appleによるアプリ審査前に完了しておく必要があります。

https://star-m.jp/products/s_print/apple_app_mfi/index.html

> :warning: Bluetooth Low Energyプリンターを使用する場合は、このアプリ認証を行う必要はありません。

## サンプル

StarXpand SDKにはプリンターと組み合わせて動作を確認できる[サンプルアプリ](../example) が含まれています。リンク先の各機能の解説と合わせてご利用ください。

#### 1. [プリンターの検索](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/searchPrinter.html)

#### 2. [印刷データの生成](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/basic-step1.html)

[こちら](../example/StarXpandSDK/PrintingSamples/README.md)のサンプルコードと印刷結果画像もご活用ください。

- 各業態のレシートやラベル用の印刷レイアウトを作成するサンプル
- テキストデータからレシート画像を生成するサンプル

> :warning: プリンターのモデルによっては印刷できないサンプルがあります。また、ご利用の際は適宜レイアウトを調節してください。

#### 3. [テンプレート印刷機能を利用した印刷データの生成](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/template-step1.html)

#### 4. [印刷データの送信](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/basic-step2.html)

#### 5. [スプーラー機能を利用した印刷データの送信](https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/spooler.html)

#### 6. [プリンターステータスの取得](#GetPrinterStatus)

#### 7. [プリンターステータスの監視](#MonitorPrinter)

<a id="GetPrinterStatus"></a>
### Get printer status
```swift
func getStatus() {
    // Specify your printer connection settings.
    let starConnectionSettings = StarConnectionSettings(interfaceType: .lan,
                                                        identifier: "00:11:62:00:00:00")
    
    let printer = StarPrinter(starConnectionSettings)
    
    Task {
        do {
            // Connect to the printer.
            try await printer.open()
            defer {
                Task {
                    // Disconnect from the printer.
                    await printer.close()
                }
            }

            // Get printer status.
            let status = try await printer.getStatus()
            print(status)
        } catch let error {
            // Error.
            print(error)
        }
    }
}
```

<a id="MonitorPrinter"></a>
### Monitor printer
```swift
var printer: StarPrinter?

func monitor() async {
    // Specify your printer connection settings.
    let settings = StarConnectionSettings(interfaceType: .lan,
                                          identifier: "00:11:62:00:00:00")
    printer = StarPrinter(settings)
    
    guard let printer = printer else {
        return
    }
    
    printer.printerDelegate = self
    printer.drawerDelegate = self
    printer.inputDeviceDelegate = self
    printer.displayDelegate = self
    
    Task {
        do {
            // Connect to the printer.
            try await printer.open()
        } catch let error {
            // Error.
            print(error)
        }
    }
}

// Callback for printer state changed.

func printerIsReady(_ printer: StarPrinter) {
    print("Printer: Ready")
}

func drawer(printer: StarPrinter, didSwitch openCloseSignal: Bool) {
    print("Drawer: Open Close Signal Switched: \(openCloseSignal)")
}

func inputDevice(printer: StarPrinter, didReceive data: Data) {
    print("Input Device: DataReceived \(NSData(data: data))")
}

func displayDidConnect(printer: StarPrinter) {
    print("Display: Connected")
}

// ...
// Please refer to document for other callback.
```

## Copyright

Copyright 2022 Star Micronics Co., Ltd. All rights reserved.
