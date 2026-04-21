import SwiftUI
import StarIO10

struct FirmwareUpdateView: View {
    @Binding var isProcessing: Bool
    @State var interfaceType = DefaultConnectionSettings.get().interfaceType
    @State var identifier = DefaultConnectionSettings.get().identifier
    @StateObject var firmwareUpdateViewModel = FirmwareUpdateViewModel()

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

            HStack {
                Button("CheckVersions") {
                    let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                    Task {
                        isProcessing = true
                        await firmwareUpdateViewModel.checkVersions(starConnectionSettings)
                        isProcessing = false
                    }
                }
                .padding()
                
                Button("Update") {
                    let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                    Task {
                        isProcessing = true
                        await firmwareUpdateViewModel.update(starConnectionSettings)
                        isProcessing = false
                    }
                }
                .padding()
            }
            
            ScrollView {
                Text(firmwareUpdateViewModel.logText)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle(Text("Firmware Update"))
        .padding()
    }
}

@MainActor
class FirmwareUpdateViewModel: ObservableObject, FirmwareUpdateDelegate {
    @Published var logText = ""
        
    func checkVersions(_ starConnectionSettings: StarConnectionSettings) async {
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
            if let firmware = printer.setting?.firmware {
                logText.append("isUpdatable: \(String(describing: firmware.isUpdatable))\n\n")
                
                logText.append("Before checkVersions()\n")
                logText.append("currentVersion : \(String(describing: firmware.currentVersion)) \n")
                logText.append("latestVersion : \(String(describing: firmware.latestVersion)) \n\n")
                
                try await firmware.checkVersions()
                
                logText.append("After checkVersions()\n")
                logText.append("currentVersion : \(String(describing: firmware.currentVersion)) \n")
                logText.append("latestVersion : \(String(describing: firmware.latestVersion)) \n\n")

                log = "Success"
            } else {
                log = "Not Supported Model."
            }
        } catch let error {
            log = "Error: \(error)"
        }
        
        print(log)
        logText.append(log)
    }
    
    func update(_ starConnectionSettings: StarConnectionSettings) async {
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

            if let firmware = printer.setting?.firmware {
                firmware.updateDelegate = self
                 
                logText.append("Caution : The firmware is being updated. Until the result is displayed, please leave the printer turned on and wait without operating the screen of this device.\n\n")

                 // To disable uploading the information of user device and printer to the Star Micronics server by the .update() method,
                 // set the below property to false.
                 // StarIO10DiagInfoUpload.shared.isEnabled = false
                 
                try await firmware.update()

                logText.append("\nFirmware data transmission has been completed. The firmware is being updated.　This process may take several minutes.\n\n")

                log = "Success"
            } else {
                log = "Not Supported Model."
            }
        } catch let error {
            log = "Error: \(error)"
        }
        print(log)
        logText.append(log)
    }
    
    nonisolated func firmwareUpdateProgress(_ firmware: StarPrinterSettingFirmware, step: FirmwareUpdateStep) {
        let log = "firmwareUpdateProgress : \(step.description)"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func firmwareUpdateTransmitComplete(_ firmware: StarPrinterSettingFirmware) {
        let log = "firmwareUpdateTransmitComplete"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
    
    nonisolated func firmwareUpdate(_ firmware: StarPrinterSettingFirmware, errorDidOccur error: any Error) {
        let log = "firmwareUpdate Error: \(error)"
        print(log)
        Task { @MainActor in
            logText.append(log + "\n")
        }
    }
}
