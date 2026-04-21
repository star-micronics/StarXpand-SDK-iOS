import SwiftUI
import StarIO10

struct PrintingView: View {
    @Binding var isProcessing: Bool
    @State var interfaceType = DefaultConnectionSettings.get().interfaceType
    @State var identifier = DefaultConnectionSettings.get().identifier
    @StateObject var printingViewModel = PrintingViewModel()

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

            Button("Print") {
                let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                Task {
                    isProcessing = true
                     await printingViewModel.printing(starConnectionSettings)
                    isProcessing = false
                }
            }
            
            Text(printingViewModel.logText)
                .padding()

            Spacer()
        }
        .navigationTitle(Text("Printing"))
        .padding()
    }
}

@MainActor
class PrintingViewModel: ObservableObject {
    @Published var logText = ""
    
    func printing(_ starConnectionSettings: StarConnectionSettings) async {
        var log = ""
        logText = log

        let printer = StarPrinter(starConnectionSettings)
        
        do {
            try await printer.open()
            defer {
                Task {
                    await printer.close()
                }
            }
            try await printer.print(command: createDrawerCommand())

            try await printer.print(command: createPrinterCommand())

            log = "Success"
        } catch let error {
            log = "Error: \(error)"
        }
        print (log)
        logText = log
    }
    
    private func createPrinterCommand() -> String {
        guard let logo = UIImage(named: "logo_01") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        
        // TSP100III series and TSP100LAN do not support actionPrintText because these products are graphics-only printers.
        // Please use the actionPrintImage method to create printing data for these products.
        // For other available methods, please also refer to "Supported Model" of each method.
        // https://star-m.jp/products/s_print/sdk/starxpand/manual/en/ios-swift-api-reference/star-xpand-command/printer-builder/action-print-image.html
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
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
        return builder.getCommands()
    }
    
    private func createDrawerCommand() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addDrawer(StarXpandCommand.DrawerBuilder()
                .actionOpen(StarXpandCommand.Drawer.OpenParameter())
            )
        )
        return builder.getCommands()
    }
}
