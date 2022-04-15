<p align="center">
  <img
    src="logo.png"
    width="600"
    style="margin-top: 20px; margin-bottom: 20px;"
  />
</p>

- [English](../README.md)

# StarXpand SDK for iOS

`StarXpand SDK for iOS`はスター精密デバイス向けアプリケーション開発をサポートするソフトウェア開発キットです。

本ソフトウェア開発キットでは、スター精密デバイスを制御するためのフレームワークとして、StarIO10フレームワーク(StarIO10.xcframework)を提供しています。

## 動作環境

| Platform | OS Version | Arch |
| --- | --- | --- |
| iOS | iOS 12.0 以降 | 実機: arm64<br> シミュレータ: arm64, x86_64 |

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
| Ethernet (iOS14以上)      | [2.3.](#LocalNetworkUsageDescription)                                                   |
| Lightning USB           | [2.1.](#SupportedEAProtocols) & [2.4.](#MFi)                                            |

<a id="SupportedEAProtocols"></a>
#### 2.1. `Supported external accessory protocols` 項目の設定

1. Information Property List（デフォルトでは"Info.plist"）を選択します。
2. Keyに `Supported external accessory protocols` を追加します。
3. 項目名左側の▽をクリックして表示される"Item 0"の[Value]に `jp.star-m.starpro` を設定します。

> :warning: 該当するプリンターを使用しない場合は、この設定を行わないでください。

<a id="BluetoothAlwaysUsageDescription"></a>
#### 2.2. `Bluetooth Always Usage Description` 項目および `Bluetooth Peripheral Usage Description` 項目の設定

1. Information Property List（デフォルトでは"Info.plist"）を選択します。
2. Keyに `Privacy – Bluetooth Always Usage Description` を追加します。
3. `Deployment Target` をiOS12に設定する場合、Keyに `Privacy – Bluetooth Peripheral Usage Description` を追加します。
3. それぞれのValue に Bluetoothの利用目的（例: `Use Bluetooth for communication with the printer.`）を設定します。
4. Bluetoothにてプリンターと通信するとき、Bluetoothへのアクセス許可を求めるダイアログが表示されます。その際、Valueに設定した文字列がBluetoothを利用する理由として表示されます。

より詳しくは、下記URLを参照してください。

https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothperipheralusagedescription

<a id="LocalNetworkUsageDescription"></a>
#### 2.3. `Local Network Usage Description` 項目の設定

1. Information Property List（デフォルトでは"Info.plist"）を選択します。
2. Keyに `Privacy - Local Network Usage Description` を追加します。
3. Value に Local Networkの利用目的（例: `Use Local Network for communication with the printer or discovery the printers.`）を設定します。
4. iOS14以上でEthernetプリンターと通信するとき、Local Networkへのアクセス許可を求めるダイアログが表示されます。その際、Valueに設定した文字列がLocal Networkを利用する理由として表示されます。

<a id="MFi"></a>
#### 2.4. MFi対応プリンター向けアプリ認証を取得

MFi認証プリンターに対応したiOSアプリケーションを設計・開発し、 Apple iTunes App Storeにアプリケーション登録を行う場合、下記のURLに記載の手順によりアプリ認証を取得してください。Appleによるアプリ審査前に完了しておく必要があります。

https://star-m.jp/products/s_print/apple_app_mfi/index.html

> :warning: Bluetooth Low Energyプリンターを使用する場合は、このアプリ認証を行う必要はありません。

## ドキュメント

[ここを参照ください。](https://www.star-m.jp/starxpandsdk-oml.html)

## サンプル

### Discover devices
```swift
class DiscoveryViewController: UIViewController, StarDeviceDiscoveryManagerDelegate {
    var manager: StarDeviceDiscoveryManager? = nil
    
    func discovery() async {
        do {
            // Specify your printer interface types.
            manager = try StarDeviceDiscoveryManagerFactory.create(interfaceTypes: [
                InterfaceType.lan,
                InterfaceType.bluetooth,
                InterfaceType.bluetoothLE,
                InterfaceType.usb
            ])
            guard let manager = manager else {
                return
            }

            manager.delegate = self

            // Set discovery time. (option)
            manager.discoveryTime = 10000
            
            // Start discovery.
            try manager.startDiscovery()
            
            // Stop discovery.
            // manager.stopDiscovery()
        } catch let error {
            // Error.
            print(error)
        }
    }
    
    func manager(_ manager: StarDeviceDiscoveryManager, didFind printer: StarPrinter) {
        // Callback for printer found.
        print(printer)
    }
    
    func managerDidFinishDiscovery(_ manager: StarDeviceDiscoveryManager) {
        // Callback for discovery finished. (option)
        print("Discovery finished.")
    }

    // ...
```

### Print
```swift
func print() {
    // Specify your printer connection settings.
    let starConnectionSettings = StarConnectionSettings(interfaceType: .lan,
                                                        identifier: "00:11:62:00:00:00")
    
    let printer = StarPrinter(starConnectionSettings)
    
    // Use the different methods of StarPrinter class depending on the OS version.
    // Please refer to the following URL for details.
    // https://www.star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift/api-reference/star-printer/index.html
    if #available(iOS 13.0, *) {
        Task {
            do {
                // Connect to the printer.
                try await printer.open()
                defer {
                    // Disconnect from the printer.
                    Task {
                        await printer.close()
                    }
                }
    
                // Print.
                try await printer.print(command: command)
                print("Success")
            } catch let error {
                // Error.
                print(error)
            }
        }
    } else {
        // Connect to the printer.
        printer.open(completion: { error in
            if let error = error {
                // Error.
                print(error)
                // Disconnect from the printer.
                printer.close { }
                return
            }
            
            // Print.
            printer.print(command: command, completion: {error in
                if let error = error {
                    // Error.
                    print(error)
                    // Disconnect from the printer.
                    printer.close { }
                    return
                }
                
                print("Success")

                // Disconnect from the printer.
                printer.close { }
            })
        })
    }
}
```

### Create printing data
```swift
// Create printing data using StarXpandCommandBuilder object.
let builder = StarXpandCommand.StarXpandCommandBuilder()
_ = builder.addDocument(StarXpandCommand.DocumentBuilder.init()
    .addPrinter(StarXpandCommand.PrinterBuilder()
        .actionPrintImage(StarXpandCommand.Printer.ImageParamete(image: logo, width: 406))
        .styleInternationalCharacter(.usa)
        .styleCharacterSpace(0)
        .styleAlignment(.center)
        .actionPrintText("Star Clothing Boutique\n" +
                         "123 Star Road\n" +
                         "City, State 12345\n" +
                         "\n")
        .styleAlignment(.left)
        .actionPrintText("Date:MM/DD/YYYY    Time:HH:MM PM\n" +
                         "--------------------------------\n" +
                         "\n")
        .add(
            StarXpandCommand.PrinterBuilder()
                .styleBold(true)
                .actionPrintText("SALE \n")
        )
        .actionPrintText("SKU         Description    Total\n" +
                         "300678566   PLAIN T-SHIRT  10.99\n" +
                         "300692003   BLACK DENIM    29.99\n" +
                         "300651148   BLUE DENIM     29.99\n" +
                         "300642980   STRIPED DRESS  49.99\n" +
                         "300638471   BLACK BOOTS    35.99\n" +
                         "\n" +
                         "Subtotal                  156.95\n" +
                         "Tax                         0.00\n" +
                         "--------------------------------\n")
        .actionPrintText("Total     ")
        .add(
            StarXpandCommand.PrinterBuilder()
                .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                .actionPrintText("   $156.95\n")
        )
        .actionPrintText("--------------------------------\n" +
                         "\n" +
                         "Charge\n" +
                         "156.95\n" +
                         "Visa XXXX-XXXX-XXXX-0123\n" +
                         "\n")
        .add(
            StarXpandCommand.PrinterBuilder()
                .styleInvert(true)
                .actionPrintText("Refunds and Exchanges\n")
        )
        .actionPrintText("Within ")
        .add(
            StarXpandCommand.PrinterBuilder()
                .styleUnderLine(true)
                .actionPrintText("30 days")
        )
        .actionPrintText(" with receipt\n" +
                         "And tags attached\n" +
                         "\n")
        .styleAlignment(.center)
        .actionPrintBarcode(StarXpandCommand.Printer.BarcodeParamete(content: "0123456", symbology: .jan8)
                                .setBarDots(3)
                                .setHeight(5)
                                .setPrintHRI(true))
        .actionFeedLine(1)
        .actionPrintQRCode(StarXpandCommand.Printer.QRCodeParamete(content: "Hello World.\n")
                            .setLevel(.l)
                            .setCellSize(8))
        .actionCut(StarXpandCommand.Printer.CutType.partial)))

// Get printing data from StarXpandCommandBuilder object.
let command = builder.getCommands()
```

### Get printer status
```swift
func getStatus() {
    // Specify your printer connection settings.
    let starConnectionSettings = StarConnectionSettings(interfaceType: .lan,
                                                        identifier: "00:11:62:00:00:00")
    
    let printer = StarPrinter(starConnectionSettings)
    
    // Use the different methods of StarPrinter class depending on the OS version.
    // Please refer to the following URL for details.
    // https://www.star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift/api-reference/star-printer/index.html
    if #available(iOS 13.0, *) {
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
    } else {
        // Connect to the printer.
        printer.open(completion: { error in
            if let error = error {
                // Error.
                print(error)
    
                // Disconnect from the printer.
                printer.close { }
                return
            }
    
            // Get printer status.
            printer.getStatus(completion: {status, error in
                if let error = error {
                    // Error.
                    print(error)
    
                    // Disconnect from the printer.
                    printer.close { }
                    return
                }
                
                if let status = status {
                    print(status)
                }
    
                // Disconnect from the printer.
                printer.close { }
            })
        })
    }
}
```
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
    
    // Use the different methods of StarPrinter class depending on the OS version.
    // Please refer to the following URL for details.
    // https://www.star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift/api-reference/star-printer/index.html
    if #available(iOS 13.0, *) {
        Task {
            do {
                // Connect to the printer.
                try await printer.open()
            } catch let error {
                // Error.
                print(error)
            }
        }
    } else {
        // Connect to the printer.
        self.printer.open(completion: { error in
            if let error = error {
                // Error.
                print(error)
            }
        })
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

- [`example`プロジェクトはここを参照ください。](../example) 

## Copyright

Copyright 2022 Star Micronics Co., Ltd. All rights reserved.
