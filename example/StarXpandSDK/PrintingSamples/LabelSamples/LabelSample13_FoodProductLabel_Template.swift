//
//  LabelSample13_FoodProductLabel_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample13_FoodProductLabel_Template {
    static func createFoodProductLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${name}\n"
                            )
                    )
                    .actionPrintText(
                        "${message}\n" +
                        "------------------------------------------------\n" +
                        "MFG ${manufacturing_date}\n" +
                        "------------------------------------------------\n" +
                        "${note}\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
