import SwiftUI
import StarIO10

struct StatusView: View {
    @Binding var isProcessing: Bool
    @State var interfaceType = DefaultConnectionSettings.get().interfaceType
    @State var identifier = DefaultConnectionSettings.get().identifier
    @StateObject var statusViewModel = StatusViewModel()

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


            Button("Get Status") {
                let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                Task {
                    isProcessing = true
                    await statusViewModel.getStatus(starConnectionSettings)
                    isProcessing = false
                }
            }
            
            ScrollView {
                Text(statusViewModel.logText)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle(Text("Status"))
        .padding()
    }
}

@MainActor
class StatusViewModel: ObservableObject {
    @Published var logText = ""
    
    func getStatus(_ starConnectionSettings: StarConnectionSettings) async {
        var log = ""

        let printer = StarPrinter(starConnectionSettings)
        do {
            try await printer.open()
            defer {
                Task {
                    await printer.close()
                }
            }
            
            let status = try await printer.getStatus()

            log = """
                Has Error: \(status.hasError)
                Paper Empty: \(status.paperEmpty)
                Paper Near Empty: \(status.paperNearEmpty)
                Cover Open: \(status.coverOpen)
                Drawer Open Close Signal: \(status.drawerOpenCloseSignal)
                """
        } catch let error {
            log = "Error: \(error)"
        }
        print (log)
        logText.append("\(log)\n\n")
    }
}
