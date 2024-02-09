//
//  Sample08_FoodProductLabel.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample08_FoodProductLabel {
    static func createFoodProductLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "Star's Lunch Box -A-\n"
                            )
                    )
                    .actionPrintText(
                        "Use special sauce as you like\n" +
                        "------------------------------------------------\n" +
                        "MFG 2021/4/1\n" +
                        "------------------------------------------------\n" +
                        "Contains Wheat, Milk, and Soy.\n" +
                        "May Contains Sesame.\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
