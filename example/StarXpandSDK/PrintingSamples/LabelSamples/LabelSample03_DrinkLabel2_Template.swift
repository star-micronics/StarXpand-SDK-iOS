//
//  LabelSample03_DrinkLabel2_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample03_DrinkLabel2_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .actionPrintText(
                        "Item: ${item_number%2d} of ${number_of_items}\n"
                    )
                    .actionPrintText(
                        "Items in order: ${items_in_order}"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionFeed(6.0)
                            .actionPrintText(
                                "${customer_name}"
                            )
                            .actionFeed(8.0)
                            .actionPrintText(
                                "${product_name}"
                            )
                            .actionFeed(6.0)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                        )
                            .actionPrintText(
                                "${item_list.detail}\n"
                            )
                    )
                    .actionPrintText(
                        "\nTime: ${time}\n"
                    )
                    .actionPrintText(
                        "\n${order_types}\n"
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
