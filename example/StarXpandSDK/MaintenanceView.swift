import SwiftUI
import StarIO10

struct MaintenanceView: View {
    @Binding var isProcessing: Bool
    @State var interfaceType = DefaultConnectionSettings.get().interfaceType
    @State var identifier = DefaultConnectionSettings.get().identifier
    @State private var resetTypes: Set<MaintenanceInformationType> = []
    @StateObject var maintenanceViewModel = MaintenanceViewModel()

    // The powerOnTimeMin counter is permanent and cannot be reset, so it is not listed here.
    private let resettableTypes = MaintenanceInformationType.allCases.filter { $0 != .powerOnTimeMin }

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

            Button("GetInformation") {
                let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                Task {
                    isProcessing = true
                    await maintenanceViewModel.getInformation(starConnectionSettings)
                    isProcessing = false
                }
            }
            .padding()

            Text("Reset target")
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(resettableTypes, id: \.self) { type in
                Toggle(type.description, isOn: Binding(
                    get: { resetTypes.contains(type) },
                    set: { isOn in
                        if isOn {
                            resetTypes.insert(type)
                        } else {
                            resetTypes.remove(type)
                        }
                    }
                ))
            }

            Button("ResetInformation") {
                let starConnectionSettings = StarConnectionSettings(interfaceType: interfaceType, identifier: identifier)
                let types = resettableTypes.filter { resetTypes.contains($0) }
                Task {
                    isProcessing = true
                    await maintenanceViewModel.resetInformation(starConnectionSettings, types)
                    isProcessing = false
                }
            }
            .padding()

            ScrollView {
                Text(maintenanceViewModel.logText)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle(Text("Maintenance"))
        .padding()
    }
}

@MainActor
class MaintenanceViewModel: ObservableObject {
    @Published var logText = ""

    func getInformation(_ starConnectionSettings: StarConnectionSettings) async {
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

            if let maintenance = printer.setting?.maintenance {
                let information = try await maintenance.getInformation()

                // Information not supported by the printer is omitted from the returned data.
                for type in MaintenanceInformationType.allCases {
                    if let value = information[type] {
                        logText.append("\(type.description) : \(value) \n")
                    } else {
                        logText.append("\(type.description) : Not Supported \n")
                    }
                }

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

    func resetInformation(_ starConnectionSettings: StarConnectionSettings, _ types: [MaintenanceInformationType]) async {
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

            if let maintenance = printer.setting?.maintenance {
                logText.append("Reset : \(types.map { $0.description }.joined(separator: ", ")) \n\n")

                // Once maintenance information has been reset, it cannot be restored.
                try await maintenance.resetInformation(types)

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
}
