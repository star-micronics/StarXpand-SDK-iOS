//
//  LabelSample02_DrinkLabel1_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample02_DrinkLabel1_Template {
    static func createDrinkLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleBold(true)
                    .actionPrintText(
                        "Item:\t${item_number} of ${number_of_items}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${customer_name}\n" +
                                "${item_name}\n"
                            )
                    )
                    .actionPrintText(
                        "${order_detail}\n" +
                        "\n" +
                        "Time:\t${time}\n" +
                        "Reg:\t${register}\n" +
                        "\n" +
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "${note}\n"
                            )
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
