//
//  ReceiptSample04_FoodDelivery2_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample04_FoodDelivery2_Template {
    static func createReceiptTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                            .actionPrintText(
                                "${store_name}\n"
                            )
                            .styleInvert(true)
                            .actionPrintText(
                                "${order_number}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        7,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.left)
                                    )
                            )
                            .styleBold(false)
                            .actionPrintText(
                                "${customer_name}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        17,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                    )
                    .actionPrintText(
                        "Placed at ${placed_at}\n"
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "Due at ${due_at}"
                    )
                    .styleBold(false)
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .actionFeed(4.0)
                            .styleAlignment(.center)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                            .actionPrintText(
                                "${order_types}\n"
                            )
                            .actionFeed(2.0)
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Disposable items:${disposable_items}\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                        )
                            .styleBold(true)
                            .actionPrintText(
                                "${item_list.quantity} x ${item_list.name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(39)
                            )
                            .actionPrintText(
                                " "
                            )
                            .styleBold(false)
                            .actionPrintText(
                                "$${item_list.price%.2f}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        8,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                "${item_list.detail1}" +
                                "${item_list.detail2}" +
                                "${item_list.detail3}" +
                                "${item_list.detail4}"
                            )
                            .actionFeed(1.0)
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Subtotal"
                    )
                    .actionPrintText(
                        "$${subtotal%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                40,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "Amount paid"
                    )
                    .actionPrintText(
                        "$${total%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                37,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .styleBold(false)
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .styleAlignment(.center)
                    .actionPrintText(
                        "${note}"
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
