//
//  LabelSample24_BarcodeLabel2_3inch_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample24_BarcodeLabel2_3inch_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .actionPrintText(
                        "${product_name}\n"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "${parameter1} / ${parameter2} / ${parameter3} / ${parameter4}\n"
                    )
                    .actionPrintBarcode(
                        StarXpandCommand.Printer.BarcodeParameter(content: "${sku}", symbology: .upcA)
                            .setBarDots(3)
                            .setHeight(12.0)
                            .setPrintHRI(true)
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
