//
//  Sample05_FoodDelivery.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample05_FoodDelivery {
    static func createFoodDeliveryReceipt() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleBold(true)
                        .styleMagnification(StarXpandCommand.MagnificationParameter(width: 3, height: 3))
                        .actionPrintText(
                            "Star Eats\n"
                        )
                        .add(
                            StarXpandCommand.PrinterBuilder()
                                .styleInvert(true)
                                .actionPrintText(
                                    "8A720  Micronics\n"
                                )
                        )
                )
                .styleAlignment(.center)
                .actionPrintText(
                    "Placed at March 24 2021 1:30PM\n"
                )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleUnderLine(true)
                        .actionPrintText(
                            "                                                \n"
                        )
                    )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleBold(true)
                        .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                        .actionPrintText(
                            "DELIVERY\n"
                        )
                    )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleUnderLine(true)
                        .actionPrintText("                                                \n")
                )
                .styleAlignment(.left)
                .actionPrintText(
                    "1XStar's lunch box A *                    $10.95\n" +
                    "------------------------------------------------\n" +
                    "Subtotal                                   $0.97\n" +
                    "Amount paid                               $11.92\n" +
                    "item 1                                    $10.00\n" +
                    "------------------------------------------------\n" +
                    "*Use special source as you like!\n"
                )
                .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
