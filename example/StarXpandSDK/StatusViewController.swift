//
//  StatusViewController.swift
//  StarXpandSDK
//
//  Copyright © 2021 Star Micronics. All rights reserved.
//

import UIKit
import StarIO10

class StatusViewController: UIViewController {

    @IBOutlet weak var interfaceSelector: UISegmentedControl!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpStatusButton(_ sender: Any) {
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
        
        Task {
            do {
                try await printer.open()
                defer {
                    Task {
                        await printer.close()
                    }
                }
                
                let status = try await printer.getStatus()
                print("""
                    Has Error: \(status.hasError)
                    Paper Empty: \(status.paperEmpty)
                    Paper Near Empty: \(status.paperNearEmpty)
                    Cover Open: \(status.coverOpen)
                    Drawer Open Close Signal: \(status.drawerOpenCloseSignal)
                    """)
                
                Task { @MainActor in
                    self.statusTextView.text.append("""
                        Has Error: \(status.hasError)
                        Paper Empty: \(status.paperEmpty)
                        Paper Near Empty: \(status.paperNearEmpty)
                        Cover Open: \(status.coverOpen)
                        Drawer Open Close Signal: \(status.drawerOpenCloseSignal)
                        \n
                        """)
                }
            } catch let error {
                print("Error: \(error)")
                
                Task { @MainActor in
                    self.statusTextView.text.append("Error: \(error)\n\n")
                }
            }
        }
    }
}
