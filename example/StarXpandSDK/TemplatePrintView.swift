import SwiftUI
import StarIO10

struct TemplatePrintView: View {
    @Binding var isProcessing: Bool
    @State var interfaceType = DefaultConnectionSettings.get().interfaceType
    @State var identifier = DefaultConnectionSettings.get().identifier
    @StateObject var templatePrintViewModel = TemplatePrintViewModel()

    @State var selectedTemplate = 0
    @State var selectedFieldData = 0
    
    var body: some View {
        VStack {
            Picker("Select a interfaceType", selection: $interfaceType) {
                Text("Lan").tag(InterfaceType.lan)
                Text("Bluetooth").tag(InterfaceType.bluetooth)
                Text("BluetoothLE").tag(InterfaceType.bluetoothLE)
                Text("Usb").tag(InterfaceType.usb)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TextField("Enter identifier", text: $identifier)
                .padding(1)
                .textFieldStyle(.roundedBorder)
            
            Text("Template")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Picker("Select a Template", selection: $selectedTemplate) {
                Text("Receipt w/ specifying number of characters").tag(0)
                Text("Receipt w/o specifying number of characters").tag(1)
                Text("Label").tag(2)
            }
            .minimumScaleFactor(0.5)
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)
            
            Text("Field Data")
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("Select a Field Data", selection: $selectedFieldData) {
                switch selectedTemplate {
                case 0:
                    Text("Receipt1").tag(0)
                    Text("Receipt2").tag(1)
                case 1:
                    Text("Receipt1").tag(0)
                    Text("Receipt3").tag(1)
                default: 
                    Text("Label1").tag(0)
                    Text("Label2").tag(1)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("Print") {
                let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                Task {
                    isProcessing = true
                    await templatePrintViewModel.printing(starConnectionSettings, selectedTemplate: selectedTemplate, selectedFeildData: selectedFieldData)
                    isProcessing = false
                }
            }

            Text(templatePrintViewModel.logText)
                .padding()

            Spacer()
        }
        .navigationTitle(Text("Template Print"))
        .padding()
    }
}

@MainActor
class TemplatePrintViewModel: ObservableObject {
    @Published var logText = ""
    
    public func printing(_ starConnectionSettings: StarConnectionSettings, selectedTemplate: Int, selectedFeildData: Int) async {
        var log = ""
        logText = log

        let template = switch selectedTemplate {
        case 0:
            createReceiptWithSpecifyingNumberOfCharactersTemplate()
        case 1:
            createReceiptWithoutSpecifyingNumberOfCharactersTemplate()
        default: 
            createLabelTemplate()
        }
        
        let fieldData = switch (selectedTemplate, selectedFeildData) {
        case (0, 0):
            readJsonFile("receipt1_field_data")
        case (0, 1):
            readJsonFile("receipt2_field_data")
        case (1, 0):
            readJsonFile("receipt1_field_data")
        case (1, 1):
            readJsonFile("receipt3_field_data")
        case (2, 0):
            readJsonFile("label1_field_data")
        default: // case (2, 1):
            readJsonFile("label2_field_data")
        }
        
        let printer = StarPrinter(starConnectionSettings)
        printer.template = template
        
        do {
            try await printer.open()
            defer {
                Task {
                    await printer.close()
                }
            }
            
            try await printer.print(command: fieldData)
            
            log = "Success"
        } catch let error {
            log = "Error: \(error)"
        }
        print (log)
        logText = log
    }
    
    private func readJsonFile(_ fileName: String) -> String {
         let filePath = Bundle.main.path(forResource: fileName, ofType: "json")!
         
         let filePathUrl = URL(fileURLWithPath: filePath)
         let fileData = try! Data(contentsOf: filePathUrl, options: [])
         
         return String(data: fileData, encoding: .utf8)!
     }
    
    // swiftlint:disable:next function_body_length
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
    
    // swiftlint:disable:next function_body_length
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
                )
                .actionPrintText(
                    "${credit_card_number}\t${total%6.2lf}\n"
                )
                .actionPrintText(
                    "Approval Code\t${approval_code}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
                )
                .actionPrintText(
                    "Amount\t${amount%6.2lf}\n"
                )
                .actionPrintText(
                    "Total\t${total%6.2lf}\n"
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 32.0)
                        .setX(8.0)
                )
                .actionPrintRuledLine(
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
                    StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
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
}
