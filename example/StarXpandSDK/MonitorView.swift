import SwiftUI
import StarIO10

struct MonitorView: View {
    @Binding var isProcessing: Bool
    @State var interfaceType = DefaultConnectionSettings.get().interfaceType
    @State var identifier = DefaultConnectionSettings.get().identifier
    @State var buttonName = "Start Monitor"
    @StateObject var monitorViewModel = MonitorViewModel()
    
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

            Button(monitorViewModel.isMonitoring ? "Stop Monitor" : "Start Monitor") {
                let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                Task {
                    isProcessing = true
                    if monitorViewModel.isMonitoring {
                        await monitorViewModel.stop()
                    } else {
                        await monitorViewModel.start(starConnectionSettings)
                    }
                    isProcessing = false
                }
            }
            
            ScrollView {
                Text(monitorViewModel.logText)
                    .padding()
            }

            Spacer()
        }
        .onDisappear {
            Task {
                if monitorViewModel.isMonitoring {
                    await monitorViewModel.stop()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            Task {
                if monitorViewModel.isMonitoring {
                    await monitorViewModel.stop()
                }
            }
        }
        .navigationTitle(Text("Monitor"))
        .padding()
    }
}

@MainActor
class MonitorViewModel: ObservableObject, PrinterDelegate, DrawerDelegate, InputDeviceDelegate, DisplayDelegate {
    @Published var logText = ""
    @Published var isMonitoring = false
    private var printer: StarPrinter?

    func start(_ starConnectionSettings: StarConnectionSettings) async {
        var log = ""

        printer = StarPrinter(starConnectionSettings)
                
        printer?.printerDelegate = self
        printer?.drawerDelegate = self
        printer?.inputDeviceDelegate = self
        printer?.displayDelegate = self
        
        do {
            try await self.printer?.open()
            isMonitoring = true
            log = "Start Monitoring"
        } catch let error {
            await self.printer?.close()
            log = "Error: \(error)"
        }
        print (log)
        logText = log + "\n"
    }
    
    func stop() async {
        await self.printer?.close()
        isMonitoring = false

        let log = "Stop Monitoring"
        print (log)
        logText.append(log)
    }
    
    nonisolated func printer(_ printer: StarPrinter, communicationErrorDidOccur error: any Error) {
        let log = "Printer: Communication Error\n\(error)"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func printerIsReady(_ printer: StarPrinter) {
        let log = "Printer: Ready"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func printerDidHaveError(_ printer: StarPrinter) {
        let log = "Printer: Error"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func printerIsPaperReady(_ printer: StarPrinter) {
        let log = "Printer: Paper Ready"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func printerIsPaperNearEmpty(_ printer: StarPrinter) {
        let log = "Printer: Paper Near Empty"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func printerIsPaperEmpty(_ printer: StarPrinter) {
        let log = "Printer: Paper Empty"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func printerIsCoverOpen(_ printer: StarPrinter) {
        let log = "Printer: Cover Opened"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func printerIsCoverClose(_ printer: StarPrinter) {
        let log = "Printer: Cover Closed"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func drawer(printer: StarPrinter, communicationErrorDidOccur error: any Error) {
        let log = "Drawer: Communication Error\n\(error)"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func drawer(printer: StarPrinter, didSwitch openCloseSignal: Bool) {
        let log = "Drawer: Open Close Signal Switched: \(openCloseSignal)"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func drawer(printer: StarPrinter, didSwitchStatusDetails statusDetails: StarPrinterStatusDetail) {
        let log: String = "Drawer: Status Details Changed"
        
//        log += "\n"
//        log += "    drawer1OpenCloseSignal: \(statusDetails.drawer1OpenCloseSignal?.description ?? "N/A")" + "\n"
//        log += "    drawer2OpenCloseSignal: \(statusDetails.drawer2OpenCloseSignal?.description ?? "N/A")" + "\n"
//        log += "    drawer3OpenCloseSignal: \(statusDetails.drawer3OpenCloseSignal?.description ?? "N/A")" + "\n"
//        log += "    drawer4OpenCloseSignal: \(statusDetails.drawer4OpenCloseSignal?.description ?? "N/A")" + "\n"
//        log += "    drawer1OpenedMethod: \(statusDetails.drawer1OpenedMethod?.description ?? "N/A")" + "\n"
//        log += "    drawer2OpenedMethod: \(statusDetails.drawer2OpenedMethod?.description ?? "N/A")" + "\n"
//        log += "    drawer3OpenedMethod: \(statusDetails.drawer3OpenedMethod?.description ?? "N/A")" + "\n"
//        log += "    drawer4OpenedMethod: \(statusDetails.drawer4OpenedMethod?.description ?? "N/A")" + "\n"
//        log += "    externalDevice1Connected: \(statusDetails.externalDevice1Connected?.description ?? "N/A")" + "\n"
//        log += "    externalDevice2Connected: \(statusDetails.externalDevice2Connected?.description ?? "N/A")" + "\n"
//        log += "    externalDevice3Connected: \(statusDetails.externalDevice3Connected?.description ?? "N/A")" + "\n"
//        log += "    externalDevice4Connected: \(statusDetails.externalDevice4Connected?.description ?? "N/A")" + "\n"
        
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func inputDevice(printer: StarPrinter, communicationErrorDidOccur error: any Error) {
        let log = "Input Device: Communication Error\n\(error)"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func inputDeviceDidConnect(printer: StarPrinter) {
        let log = "Input Device: Connected"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func inputDeviceDidDisconnect(printer: StarPrinter) {
        let log = "Input Device: Disconnected"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func inputDevice(printer: StarPrinter, didReceive data: Data) {
        let log = "Input Device: DataReceived \(NSData(data: data))"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func display(printer: StarPrinter, communicationErrorDidOccur error: any Error) {
        let log = "Display: Communication Error\n\(error)"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func displayDidConnect(printer: StarPrinter) {
        let log = "Display: Connected"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func displayDidDisconnect(printer: StarPrinter) {
        let log = "Display: Disconnected"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
}
