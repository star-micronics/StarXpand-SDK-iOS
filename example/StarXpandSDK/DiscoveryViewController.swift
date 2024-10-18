//
//  DiscoveryViewController.swift
//  StarXpandSDK
//
//  Copyright © 2021 Star Micronics. All rights reserved.
//

import UIKit
import StarIO10

class DiscoveryViewController: UIViewController, StarDeviceDiscoveryManagerDelegate {
    
    @IBOutlet weak var lanSwitch: UISwitch!
    @IBOutlet weak var bluetoothSwitch: UISwitch!
    @IBOutlet weak var bleSwitch: UISwitch!
    @IBOutlet weak var usbSwitch: UISwitch!
    
    @IBOutlet weak var discoveryButton: UIButton!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    private var manager: (any StarDeviceDiscoveryManager)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpDiscoveryButton(_ sender: Any) {
        resultTextView.text = ""
        
        manager?.stopDiscovery()
        
        var interfaceTypeArray : [InterfaceType] = []
        
        if lanSwitch.isOn {
            interfaceTypeArray.append(InterfaceType.lan)
        }
        
        if bluetoothSwitch.isOn {
            interfaceTypeArray.append(InterfaceType.bluetooth)
        }
        
        if bleSwitch.isOn {
            interfaceTypeArray.append(InterfaceType.bluetoothLE)
        }
        
        if usbSwitch.isOn {
            interfaceTypeArray.append(InterfaceType.usb)
        }
        
        do {
            try manager = StarDeviceDiscoveryManagerFactory.create(interfaceTypes: interfaceTypeArray)
            
            manager?.discoveryTime = 10000
            
            manager?.delegate = self
            
            try manager?.startDiscovery()
            
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    nonisolated func manager(_ manager: any StarDeviceDiscoveryManager, didFind printer: StarPrinter) {
        let interfaceType = printer.connectionSettings.interfaceType
        let identifier = printer.connectionSettings.identifier
        
        Task { @MainActor in
            
            switch interfaceType {
            case .lan:
                let findPrinter = "LAN: " + identifier
                self.resultTextView.text = self.resultTextView.text + "\n" + findPrinter
                
            case .bluetooth:
                let findPrinter = "Bluetooth: " + identifier
                self.resultTextView.text = self.resultTextView.text + "\n" + findPrinter
                
            case .bluetoothLE:
                let findPrinter = "BluetoothLE: " + identifier
                self.resultTextView.text = self.resultTextView.text + "\n" + findPrinter
                
            case .usb:
                let findPrinter = "USB: " + identifier
                self.resultTextView.text = self.resultTextView.text + "\n" + findPrinter
                
            default:
                break
            }
        }
        
        print("Found printer: \(identifier).")
    }
    
    nonisolated func managerDidFinishDiscovery(_ manager: any StarDeviceDiscoveryManager) {
        print("Discovery finished.")
    }
}
