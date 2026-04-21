import SwiftUI
import StarIO10

struct DiscoveryView: View {
    @Binding var isProcessing: Bool
    @State private var lanSwitch = true
    @State private var bluetoothSwitch = true
    @State private var bluetoothLeSwitch = true
    @State private var usbSwitch = true
    @State private var selectedItem: String?
    @StateObject var discoveryViewModel = DiscoveryViewModel()

    var body: some View {
        VStack {
            Toggle("Lan", isOn: $lanSwitch)
            Toggle("Bluetooth", isOn: $bluetoothSwitch)
            Toggle("BluetoothLE", isOn: $bluetoothLeSwitch)
            Toggle("Usb", isOn: $usbSwitch)
            
            Button("Discovery") {
                var interfaceTypeArray: [InterfaceType] = []
                
                if lanSwitch {
                    interfaceTypeArray.append(InterfaceType.lan)
                }
                if bluetoothSwitch {
                    interfaceTypeArray.append(InterfaceType.bluetooth)
                }
                if bluetoothLeSwitch {
                    interfaceTypeArray.append(InterfaceType.bluetoothLE)
                }
                if usbSwitch {
                    interfaceTypeArray.append(InterfaceType.usb)
                }
                discoveryViewModel.discovery(interfaceTypeArray)
            }
            .padding()
            
            List {
                ForEach(discoveryViewModel.logText.indices, id: \.self) { index in
                    Text(discoveryViewModel.logText[index])
                        .onTapGesture {
                            selectedItem = discoveryViewModel.logText[index]
                            if let selectedItem = selectedItem,
                               let rangeStart = selectedItem.range(of: ": ")?.upperBound,
                               let rangeEnd = selectedItem[rangeStart...].range(of: ",")?.lowerBound {
                                
                                let address = String(selectedItem[rangeStart..<rangeEnd])
                                UIPasteboard.general.string = address
                            }
                        }
                }
            }
            .padding()

            if let selectedItem = selectedItem {
                Text("Copied Item: \(selectedItem)")
                    .padding()
            }
            
            Spacer()
        }
        .navigationTitle(Text("Discovery"))
        .padding()
        .onChange(of: discoveryViewModel.isProcessing) { newValue in
            isProcessing = newValue
        }
    }
}

@MainActor
class DiscoveryViewModel: ObservableObject, StarDeviceDiscoveryManagerDelegate {
    @Published var logText: [String] = []
    @Published var isProcessing = false

    private var manager: (any StarDeviceDiscoveryManager)?
    
    func discovery(_ interfaceTypes: [InterfaceType]) {
        isProcessing = true
        var log = ""
        logText = []

        do {
            manager?.stopDiscovery()
            
            try manager = StarDeviceDiscoveryManagerFactory.create(interfaceTypes: interfaceTypes)
            manager?.discoveryTime =
                if interfaceTypes.contains(.bluetoothLE) { 10_000 }
                else if interfaceTypes.contains(.lan) { 5_000 }
                else { 2_000 }
            manager?.delegate = self
            
            try manager?.startDiscovery()
            
            log = "Discovery started for: "
            if interfaceTypes.contains(.lan) { log.append("Lan, ") }
            if interfaceTypes.contains(.bluetooth) { log.append("Bluetooth, ") }
            if interfaceTypes.contains(.bluetoothLE) { log.append("BluetoothLE, ") }
            if interfaceTypes.contains(.usb) { log.append("Usb, ") }
        } catch let error {
            log = "Error: \(error)"
            isProcessing = false
        }
        print(log)
    }
    
    nonisolated func manager(_ manager: any StarDeviceDiscoveryManager, didFind printer: StarPrinter) {
        let interfaceType = printer.connectionSettings.interfaceType
        let identifier = printer.connectionSettings.identifier
        
        let log = switch interfaceType {
        case .lan:
            "Lan: \(identifier), \(printer.information?.model, default: ""), \(printer.information?.detail.lan.uniqueId ?? "")"

        case .bluetooth:
            "Bluetooth: \(identifier), \(printer.information?.model, default: "")"

        case .bluetoothLE:
            "BluetoothLE: \(identifier), \(printer.information?.model, default: ""), \(printer.information?.detail.bluetoothLE.deviceName ?? "")"

        case .usb:
            "Usb: \(identifier), \(printer.information?.model, default: "")"

        default:
            ""
        }
        
        print("Found printer: \(log)")
        Task { @MainActor in
            logText.append(log)
        }
    }
    
    nonisolated func managerDidFinishDiscovery(_ manager: any StarDeviceDiscoveryManager) {
        let log = "Discovery finished."
        
        print(log)
        Task { @MainActor in
            isProcessing = false
        }
    }
}
