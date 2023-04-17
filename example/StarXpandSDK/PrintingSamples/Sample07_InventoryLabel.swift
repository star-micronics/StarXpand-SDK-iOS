//
//  Sample07_InventoryLabel.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample07_InventoryLabel {
    static func createInventoryLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleUnderLine(true)
                            .actionPrintText(
                                "Star TSP100IV\n"
                            )
                    )
                    .actionPrintText(
                        "P/N: 000001\n"
                    )
                    .actionPrintBarcode(
                        //TODO 2558271100031だと3inchに収まらない
                        StarXpandCommand.Printer.BarcodeParameter(content: "2558271100", symbology: .code39)
                            .setBarDots(3)
                            .setHeight(18.0)
                            .setPrintHRI(true)
                    )
                    .actionPrintText(
                        "\n" +
                        "ABC: WAREHOUSE\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
