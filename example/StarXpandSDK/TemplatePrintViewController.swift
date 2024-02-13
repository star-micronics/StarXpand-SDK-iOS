//
//  TemplatePrintViewController.swift
//  StarXpandSDK
//
//  Copyright © 2023 Star Micronics. All rights reserved.
//

import UIKit
import StarIO10

class TemplatePrintViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let templateArray = [
        "Receipt w/ specifying number of characters",
        "Receipt w/o specifying number of characters",
        "Label"
    ]
    
    @IBOutlet weak var interfaceSelector: UISegmentedControl!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var templatePicker: UIPickerView!
    @IBOutlet weak var fieldDataSelector: UISegmentedControl!
    @IBOutlet weak var printButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        templatePicker.delegate = self
        templatePicker.dataSource = self
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

        let template: String
        
        switch templatePicker.selectedRow(inComponent: 0) {
        case 0:
            template = createReceiptWithSpecifyingNumberOfCharactersTemplate()
            
        case 1:
            template = createReceiptWithoutSpecifyingNumberOfCharactersTemplate()
            
        default: //case 2:
            template = createLabelTemplate()
        }
            
        let fieldData: String
        
        switch (templatePicker.selectedRow(inComponent: 0), fieldDataSelector.selectedSegmentIndex) {
        case (0, 0):
            fieldData = readJsonFile("receipt1_field_data")
        case (0, 1):
            fieldData = readJsonFile("receipt2_field_data")
        case (1, 0):
            fieldData = readJsonFile("receipt1_field_data")
        case (1, 1):
            fieldData = readJsonFile("receipt3_field_data")
        case (2, 0):
            fieldData = readJsonFile("label1_field_data")
        default: //case (2, 1):
            fieldData = readJsonFile("label2_field_data")
        }
        
        printer.template = template
        
        Task {
            do {
                try await printer.open()
                defer {
                    Task {
                        await printer.close()
                    }
                }
                
                try await printer.print(command: fieldData)
                
                print("Success")
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    private func createReceiptWithSpecifyingNumberOfCharactersTemplate() -> String {
        guard let logo = UIImage(named: "logo_01") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        
        guard let signature = UIImage(named: "signature") else {
            print("Failed to load \"signature.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logo, width: 406))
                .styleInternationalCharacter(.usa)
                .styleCharacterSpace(0.0)
                .add(
                     StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .styleInvert(true)
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                    .actionPrintText("${store_name}\n")
                    )
                .actionFeed(1.0)
                .actionPrintText(
                    "Order ${order_number}",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            16
                        )
                )
                .actionPrintText(" ")
                .actionPrintText(
                    "${time}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            15,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setAlignment(.right)
                                .setEllipsizeType(.end)
                        )
                )
                .actionPrintText(
                    "Sale for ${sales_type}",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(16)
                )
                .actionPrintText(" ")
                .actionPrintText(
                    "Served by ${server}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            15,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setAlignment(.right)
                                .setEllipsizeType(.end)
                        )
                )
                .actionPrintText(
                    "Transaction #${transaction_id}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .add(
                    StarXpandCommand.PrinterBuilder(
                        StarXpandCommand.Printer.PrinterParameter()
                            .setTemplateExtension(
                                StarXpandCommand.TemplateExtensionParameter()
                                    .setEnableArrayFieldData(true)
                            )
                    )
                        .actionPrintText(
                            "${item_list.quantity}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(2)
                        )
                        .actionPrintText(
                            "${item_list.name}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(24)
                        )
                        .actionPrintText(
                            "${item_list.unit_price%6.2lf}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(6)
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText(
                    "Subtotal",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(26)
                )
                .actionPrintText(
                    "${subtotal%6.2lf}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            6,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setEllipsizeType(.end)
                        )
                )
                .actionPrintText(
                    "Tax",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(26)
                )
                .actionPrintText(
                    "${tax%6.2lf}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            6,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setEllipsizeType(.end)
                        )
                )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleBold(true)
                        .actionPrintText(
                            "Total",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(26)
                        )
                        .actionPrintText(
                            "${total%6.2lf}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    6,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setEllipsizeType(.end)
                                )
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText(
                    "${credit_card_number}",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(26)
                )
                .actionPrintText(
                    "${total%6.2lf}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            6,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setEllipsizeType(.end)
                        )
                )
                .actionPrintText(
                    "Approval Code",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(16)
                )
                .actionPrintText(
                    "${approval_code}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            16,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setAlignment(.right)
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText(
                    "Amount",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(26)
                )
                .actionPrintText(
                    "${amount%6.2lf}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            6,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setEllipsizeType(.end)
                        )
                )
                .actionPrintText(
                    "Total",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(26)
                )
                .actionPrintText(
                    "${total%6.2lf}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            6,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setEllipsizeType(.end)
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText(
                    "Signature"
                )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleAlignment(.center)
                        .actionPrintImage(
                            StarXpandCommand.Printer.ImageParameter(image: signature, width: 256)
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width: 32.0)
                        .setX(8.0)
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText("\n")
                .styleAlignment(.center)
                .actionPrintText(
                    "${address}\n"
                )
                .actionPrintText(
                    "${tel}\n"
                )
                .actionPrintText(
                    "${mail}\n"
                )
                .actionFeed(1.0)
                .actionPrintText(
                    "${url}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionFeed(2.0)
                .actionPrintText(
                    "Powered by Star Micronics\n"
                )
                .actionPrintBarcode(
                    StarXpandCommand.Printer.BarcodeParameter(content: "${transaction_id}", symbology: .code128)
                        .setPrintHRI(true)
                )
                .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
    
    private func createReceiptWithoutSpecifyingNumberOfCharactersTemplate() -> String {
        guard let logo = UIImage(named: "logo_01") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        
        guard let signature = UIImage(named: "signature") else {
            print("Failed to load \"signature.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logo, width: 406))
                .styleInternationalCharacter(.usa)
                .styleCharacterSpace(0.0)
                .add(
                     StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .styleInvert(true)
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                    .actionPrintText("${store_name}\n")
                    )
                .actionFeed(1.0)
                .styleHorizontalTabPositions([17])
                .actionPrintText(
                    "Order ${order_number}\t${time}\n"
                )
                .actionPrintText(
                    "Sale for ${sales_type}\tServed by ${server}\n"
                )
                .actionPrintText(
                    "Transaction #${transaction_id}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .add(
                    StarXpandCommand.PrinterBuilder(
                        StarXpandCommand.Printer.PrinterParameter()
                            .setTemplateExtension(
                                StarXpandCommand.TemplateExtensionParameter()
                                    .setEnableArrayFieldData(true)
                            )
                    )
                        .styleHorizontalTabPositions([2, 26])
                        .actionPrintText(
                            "${item_list.quantity}\t${item_list.name}\t${item_list.unit_price%6.2lf}\n"
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .styleHorizontalTabPositions([26])
                .actionPrintText(
                    "Subtotal\t${subtotal%6.2lf}\n"
                )
                .actionPrintText(
                    "Tax\t${tax%6.2lf}\n"
                )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleBold(true)
                        .actionPrintText(
                            "Total\t${total%6.2lf}\n"
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText(
                    "${credit_card_number}\t${total%6.2lf}\n"
                )
                .actionPrintText(
                    "Approval Code\t${approval_code}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText(
                    "Amount\t${amount%6.2lf}\n"
                )
                .actionPrintText(
                    "Total\t${total%6.2lf}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText(
                    "Signature\n"
                )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleAlignment(.center)
                        .actionPrintImage(
                            StarXpandCommand.Printer.ImageParameter(image: signature, width: 256)
                        )
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:32.0)
                        .setX(8.0)
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionPrintText("\n")
                .styleAlignment(.center)
                .actionPrintText(
                    "${address}\n"
                )
                .actionPrintText(
                    "${tel}\n"
                )
                .actionPrintText(
                    "${mail}\n"
                )
                .actionFeed(1.0)
                .actionPrintText(
                    "${url}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width:48.0)
                )
                .actionFeed(2.0)
                .actionPrintText(
                    "Powered by Star Micronics\n"
                )
                .actionPrintBarcode(
                    StarXpandCommand.Printer.BarcodeParameter(content: "${transaction_id}", symbology: .code128)
                        .setPrintHRI(true)
                )
                .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
    
    private func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .addPageMode(
                    parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 30.0),
                    builder: StarXpandCommand.PageModeBuilder()
                        .styleHorizontalPositionTo(4.0)
                        .actionPrintText("${item_name}\n")
                        .styleVerticalPositionTo(6.0)
                        .actionPrintBarcode(
                            StarXpandCommand.Printer.BarcodeParameter(content: "${sku}", symbology: .ean13)
                                .setHeight(5.0)
                                .setPrintHRI(true)
                        )
                        .add(
                            StarXpandCommand.PageModeBuilder()
                                .styleFont(.b)
                                .styleVerticalPositionTo(0.0)
                                .styleHorizontalPositionTo(34.0)
                                .actionPrintText("EUR")
                                .styleVerticalPositionTo(0.0)
                                .styleHorizontalPositionTo(43.0)
                                .actionPrintText("UK")
                        )
                        .add(
                            StarXpandCommand.PageModeBuilder()
                                .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                                .stylePrintDirection(.bottomToTop)
                                .styleVerticalPositionTo(35.0)
                                .styleHorizontalPositionTo(5.0)
                                .actionPrintText("${price_eur%.2lf}")
                                .styleVerticalPositionTo(43.0)
                                .styleHorizontalPositionTo(5.0)
                                .actionPrintText("${price_gbp%.2lf}")
                        )
                        .addPageMode(
                            parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 32.0, height: 15.0)
                                .setY(15.0),
                            builder: StarXpandCommand.PageModeBuilder()
                                .actionPrintText("${maker_information}")
                        )
                )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return templateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return templateArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let label = (view as? UILabel) ?? UILabel()
        label.text = templateArray[row]
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            fieldDataSelector.setTitle("Receipt1", forSegmentAt: 0)
            fieldDataSelector.setTitle("Receipt2", forSegmentAt: 1)
            break
            
        case 1:
            fieldDataSelector.setTitle("Receipt1", forSegmentAt: 0)
            fieldDataSelector.setTitle("Receipt3", forSegmentAt: 1)
            break
            
        case 2:
            fieldDataSelector.setTitle("Label1", forSegmentAt: 0)
            fieldDataSelector.setTitle("Label2", forSegmentAt: 1)
            break
        default:
            break
        }
    }
    
    private func readJsonFile(_ fileName: String) -> String {
        let filePath = Bundle.main.path(forResource: fileName, ofType: "json")!
        
        let filePathUrl = URL(fileURLWithPath: filePath)
        let fileData = try! Data(contentsOf: filePathUrl, options: [])
        
        return String(data: fileData, encoding: .utf8)!
    }
}
