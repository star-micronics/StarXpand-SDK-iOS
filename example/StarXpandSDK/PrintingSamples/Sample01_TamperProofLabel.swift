//
//  Sample01_TamperProofLabel.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample01_TamperProofLabel {
    static func createTamperProofLabel() -> String {
        guard let checkedImage = UIImage(named: "sample01_tamper_proof_label_checked.png") else {
            print("Failed to load \"sample01_tamper_proof_label_checked.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .styleAlignment(.center)
                .styleBold(true)
                .styleMagnification(StarXpandCommand.MagnificationParameter(width: 4, height: 4))
                .actionPrintText(
                    "SEALED\n"
                )
                .actionPrintText(
                    "FRESH\n"
                )
                .styleBold(false)
                .styleMagnification(StarXpandCommand.MagnificationParameter(width: 3, height: 3))
                .actionPrintText(
                    "for Safety\n"
                )
                .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: checkedImage, width: 100))
                .styleBold(true)
                .actionPrintText(
                    "................\n"
                )
                .styleBold(false)
                .actionPrintText(
                    "Scan to leave\n"
                )
                .actionPrintText(
                    "a review\n"
                )                        
                .actionPrintQRCode(StarXpandCommand.Printer.QRCodeParameter(content: "http://starmicronics.com/")
                    .setCellSize(8)
                    .setLevel(.q)
                    .setModel(.model2))
                .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
