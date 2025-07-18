//
//  FirmwareUpdateViewController.swift
//  StarXpandSDK
//
//  Copyright © 2025 Star Micronics. All rights reserved.
//

import StarIO10
import UIKit

class FirmwareUpdateViewController: UIViewController, FirmwareUpdateDelegate {
    
    @IBOutlet weak var interfaceSelector: UISegmentedControl!
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var checkVersionsButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getStarPrinter() -> StarPrinter {
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
            selectedInterface = InterfaceType.unknown
        }
        
        let starConnectionSettings = StarConnectionSettings(interfaceType: selectedInterface,
                                                            identifier: identifier)
        
        return StarPrinter(starConnectionSettings)
    }
    
    @IBAction func touchUpCheckVersionsButton(_ sender: Any) {
        self.resultTextView.text = ""
        
        let printer = getStarPrinter()
        
        Task {
            do {
                try await printer.open()
                defer {
                    Task {
                        await printer.close()
                    }
                }
                
                if let firmware = printer.setting?.firmware {
                    
                    Task { @MainActor in
                        self.resultTextView.text.append("isUpdatable : \(String(describing: firmware.isUpdatable))\n")
                        self.resultTextView.text.append("\nBefore checkVersions()\n")
                        self.resultTextView.text.append("currentVersion : \(String(describing: firmware.currentVersion))\n")
                        self.resultTextView.text.append("latestVersion : \(String(describing: firmware.latestVersion))\n")
                    }
                    
                    try await firmware.checkVersions()
                    
                    Task { @MainActor in
                        self.resultTextView.text.append("\nAfter checkVersions()\n")
                        self.resultTextView.text.append("currentVersion : \(String(describing: firmware.currentVersion))\n")
                        self.resultTextView.text.append("latestVersion : \(String(describing: firmware.latestVersion))\n")
                        self.resultTextView.text.append("checkVersions() Success\n")
                    }
                    
                    print("Success")
                } else {
                    Task { @MainActor in
                        self.resultTextView.text.append("Not Supported Model.\n")
                    }
                }
            } catch let error {
                print("Error: \(error)")
                
                Task { @MainActor in
                    self.resultTextView.text.append("Error: \(error)\n")
                }
            }
        }
    }
    
    @IBAction func touchUpUpdateButton(_ sender: Any) {
        self.resultTextView.text = ""

        let printer = getStarPrinter()
        
        Task {
            do {
                lockScreen(lock: true)
                defer {
                    lockScreen(lock: false)
                }
                
                try await printer.open()
                defer {
                    Task {
                        await printer.close()
                    }
                }
                
                if let firmware = printer.setting?.firmware {
                    
                    firmware.updateDelegate = self
                    
                    Task { @MainActor in
                        self.resultTextView.text.append("Caution : The firmware is being updated. Until the result is displayed, please leave the printer turned on and wait without operating the screen of this device.\n\n")
                    }
                    
                    // To disable uploading the information of user device and printer to the Star Micronics server by the .update() method,
                    // set the below property to false.
                    // StarIO10DiagInfoUpload.shared.isEnabled = false
                    
                    try await Task { @MainActor in
                        try await firmware.update()
                    }.value
                    
                    Task { @MainActor in
                        self.resultTextView.text.append("\nFirmware data transmission has been completed. The firmware is being updated.　This process may take several minutes.\n\n")
                    }
                    
                    print("Success")
                } else {
                    Task { @MainActor in
                        self.resultTextView.text.append("Not Supported Model.\n")
                    }
                }
            } catch let error {
                print("Error: \(error)")
                
                Task { @MainActor in
                    self.resultTextView.text.append("Error: \(error)\n")
                }
            }
        }
    }
    
    private func lockScreen(lock: Bool) {
        if lock {
            self.activityIndicator.isHidden = false
            self.stepLabel.isHidden = false
            self.stepLabel.text = ""

            UIApplication.shared.isIdleTimerDisabled = true
            self.navigationItem.hidesBackButton = true
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.activityIndicator.isHidden = true
            self.stepLabel.isHidden = true
            
            UIApplication.shared.isIdleTimerDisabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.hidesBackButton = false
        }
    }
    
    nonisolated func firmwareUpdateProgress(_ firmware: StarPrinterSettingFirmware, step: FirmwareUpdateStep) {
        print("firmwareUpdateProgress : \(step.description)")
        Task { @MainActor in
            self.resultTextView.text.append("firmwareUpdateProgress : \(step.description)\n")
            self.stepLabel.text = step.description
        }
    }
    
    nonisolated func firmwareUpdateTransmitComplete(_ firmware: StarPrinterSettingFirmware) {
        print("firmwareUpdateTransmitComplete")
        Task { @MainActor in
            self.resultTextView.text.append("firmwareUpdateTransmitComplete\n")
        }
    }
    
    nonisolated func firmwareUpdate(_ firmware: StarPrinterSettingFirmware, errorDidOccur error: any Error) {
        print("firmwareUpdate errorDidOccur :  \(error)")
        Task { @MainActor in
            self.resultTextView.text.append("firmwareUpdate errorDidOccur :  \(error)\n")
        }
    }
}
