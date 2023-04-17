//
//  SpoolerViewController.swift
//  StarXpandSDK
//
//  Copyright © 2022 Star Micronics. All rights reserved.
//

import UIKit
import StarIO10

class SpoolerViewController: UIViewController {
    
    @IBOutlet weak var interfaceSelector: UISegmentedControl!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var spoolPrintButton: UIButton!
    @IBOutlet weak var jobIdTextFIeld: UITextField!
    @IBOutlet weak var getJobStatusButton: UIButton!
    @IBOutlet weak var statusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getStarPrinter() -> StarPrinter {
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
            selectedInterface = InterfaceType.unknown
        }
        
        let starConnectionSettings = StarConnectionSettings(interfaceType: selectedInterface,
                                                            identifier: identifier)
        
        return StarPrinter(starConnectionSettings)
    }
    
    @IBAction func touchUpSpoolPrintButton(_ sender: Any) {
        let printer = getStarPrinter()
        
        guard let logo = UIImage(named: "logo_01") else {
            print("Failed to load \"logo_01.png\".")
            return
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder.init()
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
                                                    .actionPrintBarcode(StarXpandCommand.Printer.BarcodeParameter(content: "0123456", symbology: .jan8)
                                                                            .setBarDots(3)
                                                                            .setHeight(5)
                                                                            .setPrintHRI(true))
                                                    .actionFeedLine(1)
                                                    .actionPrintQRCode(StarXpandCommand.Printer.QRCodeParameter(content: "Hello World.\n")
                                                                        .setLevel(.l)
                                                                        .setCellSize(8))
                                                    .actionCut(StarXpandCommand.Printer.CutType.partial)))
        
        let command = builder.getCommands()
        
        // Use the different methods of StarPrinter class depending on the OS version.
        // Please refer to the following URL for details.
        // https://www.star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift/api-reference/star-printer/index.html
        if #available(iOS 13.0, *) {
            Task {
                do {
                    try await printer.open()
                    defer {
                        Task {
                            await printer.close()
                        }
                    }
                    
                    let jobSettings = StarSpoolJobSettings(isRetryEnabled: true, timeout: 30, note: "Print from iOS")
                    
                    let jobId = try await printer.print(command: command, starSpoolJobSettings: jobSettings)
                    print("jobId: \(jobId)")
                    
                    jobIdTextFIeld.text = String(jobId)
                    
                    print("Success")
                } catch let error {
                    print("Error: \(error)")
                    
                    DispatchQueue.main.async {
                        self.statusTextView.text.append("Error: \(error)\n")
                    }
                }
            }
        } else {
            printer.open(completion: { error in
                if let error = error {
                    print("Error: \(error)")
                    
                    DispatchQueue.main.async {
                        self.statusTextView.text.append("Error: \(error)\n")
                    }
                    
                    printer.close { }
                    return
                }
                
                let jobSettings = StarSpoolJobSettings(isRetryEnabled: true, timeout: 30)
                
                printer.print(command: command, starSpoolJobSettings: jobSettings, completion: {jobId, error in
                    if let error = error {
                        print("Error: \(error)")
                        
                        DispatchQueue.main.async {
                            self.statusTextView.text.append("Error: \(error)\n")
                        }
                        
                        printer.close { }
                        return
                    }

                    if let jobId = jobId {
                        print("jobId: \(jobId)")
                        
                        DispatchQueue.main.async {
                            self.jobIdTextFIeld.text = String(jobId)
                        }
                    }
                    
                    print("Success")
                    printer.close { }
                })
            })
        }
    }
    
    @IBAction func touchUpGetJobStatusButton(_ sender: Any) {
        let printer = getStarPrinter()
        
        let jobId = Int(jobIdTextFIeld.text!) ?? 0
        
        // Use the different methods of StarPrinter class depending on the OS version.
        // Please refer to the following URL for details.
        // https://www.star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift/api-reference/star-printer/index.html
        if #available(iOS 13.0, *) {
            Task {
                do {
                    try await printer.open()
                    defer {
                        Task {
                            await printer.close()
                        }
                    }
                    
                    let jobStatus = try await printer.getSpoolJobStatus(jobId: jobId)
                    print(jobStatus)
                    
                    DispatchQueue.main.async {
                        self.statusTextView.text.append(jobStatus.description + "\n")
                    }
                    
                    print("Success")
                } catch let error {
                    DispatchQueue.main.async {
                        self.statusTextView.text.append("Error: \(error)\n\n")
                    }
                    
                    print("Error: \(error)")
                }
            }
        } else {
            printer.open(completion: { error in
                if let error = error {
                    print("Error: \(error)")
                    printer.close { }
                    return
                }
                
                printer.getSpoolJobStatus(jobId: jobId, completion: { jobStatus, error in
                    if let error = error {
                        print("Error: \(error)")
                        
                        DispatchQueue.main.async {
                            self.statusTextView.text.append("Error: \(error)\n\n")
                        }
                        
                        printer.close { }
                        return
                    }
                    
                    if let jobStatus = jobStatus {
                        print(jobStatus)
                        
                        DispatchQueue.main.async {
                            self.statusTextView.text.append(jobStatus.description + "\n")
                        }
                    }

                    print("Success")
                    printer.close { }
                })
            })
        }
    }
}
