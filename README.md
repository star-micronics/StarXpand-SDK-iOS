<div style="text-align: center;">
  <img
    src="docs/logo.png"
    width="600"
    style="margin-top: 20px; margin-bottom: 20px;"
  />
</div>

- [日本語はこちら](docs/README_JP.md)

# StarXpand SDK for iOS

`StarXpand SDK for iOS` is a software development kit for supporting application development for Star Micronics devices.

This software development kit provides the StarIO10 framework (StarIO10.xcframework) as a framework to control the Star Micronics devices.

In accordance with Apple's guidelines, StarIO10 V2.6.1 or later includes a privacy manifest file. Please see [here](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files) for the Manifest file.
However, StarIO10 does not use the Required Reason API from the first release. (As of January 29, 2024)

## Documentation

Please refer [here](https://www.star-m.jp/starxpandsdk-oml.html) for StarXpand SDK documentation.

Documentation includes an overview of the SDK, how to build a sample application, how to use the API, and a API reference.

## Requirements

| Language | Language Version | Platform | OS Version | Arch |
| --- | --- | --- | --- | --- |
| Swift | 5 | iOS | iOS 13.0 or later | Device: arm64<br> Simulator: arm64, x86_64 |

## Installation

### 1. Add the StarIO10 framework to your project

In order to integrate the StarIO10 framework into your iOS application, Use Swift Package Manager.

1. In Xcode, select `File` menu > `Add Packages...`.
2. Enter `https://github.com/star-micronics/StarXpand-SDK-iOS` in the URL input field.
3. Select `StarXpand-SDK-iOS` and press `Add Package` button.

For more information on how to integrate Swift Package, please refer to the following URL.

https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app

### 2. Preliminary Procedures

Some settings and approvals are required depending on the printer interface.  
Please check the table below and take action.

| Interface of the printer  | Necessary actions                                                                       |
|---------------------------|-----------------------------------------------------------------------------------------|
| Bluetooth                 | [2.1.](#SupportedEAProtocols) & [2.2.](#BluetoothAlwaysUsageDescription) & [2.4.](#MFi) |
| Bluetooth Low Energy      | [2.2.](#BluetoothAlwaysUsageDescription)                                                |
| Ethernet (iOS14 or later) | [2.3.](#LocalNetworkUsageDescription)                                                   |
| Lightning USB             | [2.1.](#SupportedEAProtocols) & [2.4.](#MFi)                                            |

<a id="SupportedEAProtocols"></a>
#### 2.1. Set `Supported external accessory protocols` 

1. Click on the information property list file (default : “Info.plist").
2. Add the `Supported external accessory protocols` Key.
3. Click the triangle of this key and set the value for the “Item 0" to `jp.star-m.starpro`.

> :warning: If you do not use the printer concerned, do not configure this setting.

<a id="BluetoothAlwaysUsageDescription"></a>
#### 2.2. Set `Bluetooth Always Usage Description` and `Bluetooth Peripheral Usage Description`

1. Click on the information property list file (default : “Info.plist").
2. Add the `Privacy - Bluetooth Always Usage Description` Key.
3. If you set `Deployment Target` to iOS12, add the `Privacy - Bluetooth Peripheral Usage Description` Key.
4. Set the reason for using Bluetooth in Value (e.g. `Use Bluetooth for communication with the printer.`)
5. When communicating with the Bluetooth printer on iOS 13 or later, an alert requesting permission to access Bluetooth is displayed. The string set in Value is displayed in the alert as the reason for using Bluetooth.

For more information, please refer to the following URL.

https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothperipheralusagedescription

<a id="LocalNetworkUsageDescription"></a>
#### 2.3. Set `Local Network Usage Description`

1. Click on the information property list file (default : “Info.plist").
2. Add the `Privacy - Local Network Usage Description` Key.
3. Set the reason for using Local Network in Value (e.g. `Use Local Network for communication with the printer or discovery the printers.`)
4. When communicating with the Ethernet printer on iOS 14 or later, an alert requesting permission to access Local Network is displayed. The string set in Value is displayed in the alert as the reason for using Local Network.

<a id="MFi"></a>
#### 2.4. Apple Approval Process for STAR MFi Applications

In order to offer your application that communicates a MFi certified printer on the Apple iTunes App Store, your application needs to be approved by the Apple MFi program before you submit it to the Apple iTunes App Store. Please follow the steps described in the URL below to obtain the app approval. This procedure must be completed before the app is reviewed by Apple.

https://star-m.jp/eng/products/s_print/apple_app_mfi.html

> :warning: In case of a Bluetooth Low Energy printer, you do not need to obtain this app approval.

## Examples

StarXpand SDK includes an [example](example) application that can be used in combination with the printer to check its operation. Please use it in conjunction with the explanations of each function in the linked pages.

#### 1. [Discover printers](https://star-m.jp/products/s_print/sdk/starxpand/manual/en/searchPrinter.html)

#### 2. [Create printing data](https://star-m.jp/products/s_print/sdk/starxpand/manual/en/basic-step1.html)

The sample code and printed result images are also [available here](example/StarXpandSDK/PrintingSamples/README.md).

- Sample to create print layouts for receipts and labels for each type of business
- Sample to generate receipt images from text data

> :warning: Some printer models may not be able to print some samples. Please adjust the layout accordingly when using this samples.

#### 3. [Create printing data using template printing function](https://star-m.jp/products/s_print/sdk/starxpand/manual/en/template-step1.html)

#### 4. [Send printing data](https://star-m.jp/products/s_print/sdk/starxpand/manual/en/basic-step2.html)

#### 5. [Send printing data using spooler function](https://star-m.jp/products/s_print/sdk/starxpand/manual/en/spooler.html)

#### 6. [Get printer status](#GetPrinterStatus)

#### 7. [Monitor printer](#MonitorPrinter)

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
