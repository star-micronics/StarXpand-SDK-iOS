//
//  LabelSample01_TamperProofLabel_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample01_TamperProofLabel_Template {
    static func createTamperProofLabel() -> String {
        guard let checkedImage = UIImage(named: "label_sample01_tamper_proof_label_checked.png") else {
            print("Failed to load \"label_sample01_tamper_proof_label_checked.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
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
                    "${remarks}\n"
                )
                .actionPrintQRCode(StarXpandCommand.Printer.QRCodeParameter(content: "${store_url}")
                    .setCellSize(8)
                    .setLevel(.q)
                    .setModel(.model2))
                .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}