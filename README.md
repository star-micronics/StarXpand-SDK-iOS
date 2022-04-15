<p align="center">
  <img
    src="docs/logo.png"
    width="600"
    style="margin-top: 20px; margin-bottom: 20px;"
  />
</p>

- [日本語はこちら](docs/README_JP.md)

# StarXpand SDK for iOS

`StarXpand SDK for iOS` is a software development kit for supporting application development for Star Micronics devices.

This software development kit provides the StarIO10 framework (StarIO10.xcframework) as a framework to control the Star Micronics devices.

## Requirements

| Platform | Version | Arch |
| --- | --- | --- |
| iOS | iOS 12.0 or later | Device: arm64<br> Simulator: arm64, x86_64 |

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

1. Click on the information property list file (default : “Info.plist”).
2. Add the `Supported external accessory protocols` Key.
3. Click the triangle of this key and set the value for the “Item 0” to `jp.star-m.starpro`.

> :warning: If you do not use the printer concerned, do not configure this setting.

<a id="BluetoothAlwaysUsageDescription"></a>
#### 2.2. Set `Bluetooth Always Usage Description` and `Bluetooth Peripheral Usage Description`

1. Click on the information property list file (default : “Info.plist”).
2. Add the `Privacy – Bluetooth Always Usage Description` Key.
3. If you set `Deployment Target` to iOS12, add the `Privacy – Bluetooth Peripheral Usage Description` Key.
4. Set the reason for using Bluetooth in Value (e.g. `Use Bluetooth for communication with the printer.`)
5. When communicating with the Bluetooth printer on iOS 13 or later, an alert requesting permission to access Bluetooth is displayed. The string set in Value is displayed in the alert as the reason for using Bluetooth.

For more information, please refer to the following URL.

https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothperipheralusagedescription

<a id="LocalNetworkUsageDescription"></a>
#### 2.3. Set `Local Network Usage Description`

1. Click on the information property list file (default : “Info.plist”).
2. Add the `Privacy - Local Network Usage Description` Key.
3. Set the reason for using Local Network in Value (e.g. `Use Local Network for communication with the printer or discovery the printers.`)
4. When communicating with the Ethernet printer on iOS 14 or later, an alert requesting permission to access Local Network is displayed. The string set in Value is displayed in the alert as the reason for using Local Network.

<a id="MFi"></a>
#### 2.4. Apple Approval Process for STAR MFi Applications

In order to offer your application that communicates a MFi certified printer on the Apple iTunes App Store, your application needs to be approved by the Apple MFi program before you submit it to the Apple iTunes App Store. Please follow the steps described in the URL below to obtain the app approval. This procedure must be completed before the app is reviewed by Apple.

https://star-m.jp/eng/products/s_print/apple_app_mfi.html

> :warning: In case of a Bluetooth Low Energy printer, you do not need to obtain this app approval.

## Documentation

[Please refer here.](https://www.star-m.jp/starxpandsdk-oml.html)

## Examples

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

- [`example` project is located in this directory.](example)

## Copyright

Copyright 2022 Star Micronics Co., Ltd. All rights reserved.
