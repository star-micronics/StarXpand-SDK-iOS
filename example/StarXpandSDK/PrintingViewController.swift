//
//  PrintingViewController.swift
//  StarXpandSDK
//
//  Copyright © 2021 Star Micronics. All rights reserved.
//

import UIKit
import StarIO10

class PrintingViewController: UIViewController {
    
    @IBOutlet weak var interfaceSelector: UISegmentedControl!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var printButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpPrintButton(_ sender: Any) {
        
        let identifier = identifierTextField.text ?? ""
        
        var selectedInterface: InterfaceType = InterfaceType.unknown
        switch interfaceSelector.selectedSegmentIndex {
        case 0:
            selectedInterface = InterfaceType.lan
        case 1:
            selectedInterface = InterfaceType.bluetooth
        case 2:
            selectedInterface = InterfaceType.bluetoothLE
        case 3:
            selectedInterface = InterfaceType.usb
        default:
            return
        }
        
        let starConnectionSettings = StarConnectionSettings(interfaceType: selectedInterface,
                                                            identifier: identifier)
        
        let printer = StarPrinter(starConnectionSettings)
        
        guard let logo = UIImage(named: "logo_01") else {
            print("Failed to load \"logo_01.png\".")
            return
        }
        
        // TSP100III series does not support actionPrintText because these products are graphics-only printers.
        // Please use the actionPrintImage method to create printing data for these products.
        // For other available methods, please also refer to "Supported Model" of each method.
        // https://star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift-api-reference/star-xpand-command/printer-builder/action-print-image.html
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // To open a cash drawer, comment out the following code.
//          .addDrawer(StarXpandCommand.DrawerBuilder()
//              .actionOpen(StarXpandCommand.Drawer.OpenParameter())
//          )
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logo, width: 406))
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
                .actionPrintBarcode(
                    StarXpandCommand.Printer.BarcodeParameter(content: "0123456", symbology: .jan8)
                        .setBarDots(3)
                        .setHeight(5)
                        .setPrintHRI(true)
                )
                .actionFeedLine(1)
                .actionPrintQRCode(
                    StarXpandCommand.Printer.QRCodeParameter(content: "Hello World.\n")
                        .setLevel(.l)
                        .setCellSize(8)
                )
                .actionCut(StarXpandCommand.Printer.CutType.partial)
            )
        )
        
        let command = builder.getCommands()
        
        Task {
            do {
                try await printer.open()
                defer {
                    Task {
                        await printer.close()
                    }
                }
                
                try await printer.print(command: command)
                
                print("Success")
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
}
