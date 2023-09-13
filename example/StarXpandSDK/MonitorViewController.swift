//
//  MonitorViewController.swift
//  StarXpandSDK
//
//  Copyright © 2021 Star Micronics. All rights reserved.
//

//
// This sample code performs the minimum processing to communicate with the printer.
// In the actual application code, please implement it considering the exclusion control.
//

import UIKit
import StarIO10

class MonitorViewController: UIViewController, PrinterDelegate, DrawerDelegate, InputDeviceDelegate, DisplayDelegate {
    
    @IBOutlet weak var interfaceSelector: UISegmentedControl!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var monitorButton: UIButton!
    @IBOutlet weak var statusTextView: UITextView!
    
    private var printer: StarPrinter? = nil
    
    private var isMonitoring: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willResignActive),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMonitoring {
            self.stopMonitoring()
        }
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.willResignActiveNotification,
                                                  object: nil)
    }
    
    @objc func willResignActive() {
        if self.isMonitoring {
            self.stopMonitoring()
        }
    }
    
    @IBAction func touchUpMonitorButton(_ sender: Any) {
        if isMonitoring {
            stopMonitoring()
        } else {
            startMonitoring()
        }
    }
    
    private func startMonitoring() {
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
        
        printer = StarPrinter(starConnectionSettings)
        
        printer?.printerDelegate = self
        printer?.drawerDelegate = self
        printer?.inputDeviceDelegate = self
        printer?.displayDelegate = self
        
        Task {
            do {
                try await self.printer?.open()
                
                self.monitorButton.setTitle("Stop Monitoring", for: .normal)
                self.isMonitoring = true
            } catch let error {
                print("Error: \(error)")
                
                DispatchQueue.main.async {
                    self.statusTextView.text.append("Error: \(error)\n")
                }
                
                await self.printer?.close()
            }
        }
    }
    
    private func stopMonitoring() {
        Task {
            await self.printer?.close()
            
            self.monitorButton.setTitle("Start Monitoring", for: .normal)
            self.isMonitoring = false
        }
    }
    
    func printer(_ printer: StarPrinter, communicationErrorDidOccur error: Error) {
        print("Printer: Communication Error")
        print(error)
        
        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Communication Error\n")
            self.statusTextView.text.append("\(error)\n")
        }
    }
    
    func printerIsReady(_ printer: StarPrinter) {
        print("Printer: Ready")
        
        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Ready\n")
        }
    }
    
    func printerDidHaveError(_ printer: StarPrinter) {
        print("Printer: Error")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Error\n")
        }
    }
    
    func printerIsPaperReady(_ printer: StarPrinter) {
        print("Printer: Paper Ready")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Paper Ready\n")
        }
    }
    
    func printerIsPaperNearEmpty(_ printer: StarPrinter) {
        print("Printer: Paper Near Empty")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Paper Near Empty\n")
        }
    }
    
    func printerIsPaperEmpty(_ printer: StarPrinter) {
        print("Printer: Paper Empty")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Paper Empty\n")
        }
    }
    
    func printerIsCoverOpen(_ printer: StarPrinter) {
        print("Printer: Cover Opened")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Cover Opened\n")
        }
    }
    
    func printerIsCoverClose(_ printer: StarPrinter) {
        print("Printer: Cover Closed")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Printer: Cover Closed\n")
        }
    }
    
    func drawer(printer: StarPrinter, communicationErrorDidOccur error: Error) {
        print("Drawer: Communication Error")
        print(error);

        DispatchQueue.main.async {
            self.statusTextView.text.append("Drawer: Communication Error\n")
            self.statusTextView.text.append("\(error)\n")
        }
    }
    
    func drawer(printer: StarPrinter, didSwitch openCloseSignal: Bool) {
        print("Drawer: Open Close Signal Switched: \(openCloseSignal)")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Drawer: Open Close Signal Switched: \(openCloseSignal)\n")
        }
    }
    
    func inputDevice(printer: StarPrinter, communicationErrorDidOccur error: Error) {
        print("Input Device: Communication Error")
        print(error)

        DispatchQueue.main.async {
            self.statusTextView.text.append("Input Device: Communication Error\n")
            self.statusTextView.text.append("\(error)\n")
        }
    }
    
    func inputDeviceDidConnect(printer: StarPrinter) {
        print("Input Device: Connected")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Input Device: Connected\n")
        }
    }
    
    func inputDeviceDidDisconnect(printer: StarPrinter) {
        print("Input Device: Disconnected")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Input Device: Disconnected\n")
        }
    }

    func inputDevice(printer: StarPrinter, didReceive data: Data) {
        print("Input Device: DataReceived \(NSData(data: data))")
        
        DispatchQueue.main.async {
            self.statusTextView.text.append("Input Device: DataReceived \(NSData(data: data))\n")
        }
    }
    
    func display(printer: StarPrinter, communicationErrorDidOccur error: Error) {
        print("Display: Communication Error")
        print(error)

        DispatchQueue.main.async {
            self.statusTextView.text.append("Display: Communication Error\n")
            self.statusTextView.text.append("\(error)\n")
        }
    }
    
    func displayDidConnect(printer: StarPrinter) {
        print("Display: Connected")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Display: Connected\n")
        }
    }
    
    func displayDidDisconnect(printer: StarPrinter) {
        print("Display: Disconnected")

        DispatchQueue.main.async {
            self.statusTextView.text.append("Display: Disconnected\n")
        }
    }
}
