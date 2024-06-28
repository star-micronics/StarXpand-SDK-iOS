//
//  ReceiptSample01_OnlineOrder_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample01_OnlineOrder_Template {
    static func createReceiptTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                            .styleBold(true)
                            .actionPrintText(
                                "${store_name}\n" +
                                "${order_number}\n"
                            )
                    )
                    .actionPrintText(
                        "${name}\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.3)
                    )
                    .actionFeed(1.0)
                    .actionPrintText(
                        "${date}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "${time}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeed(1.0)
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .styleAlignment(.center)
                    .actionPrintText(
                        "PICKUP ${pickup_time}\n"
                    )
                    .styleAlignment(.left)
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionFeedLine(1)
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
                                "${item_list.quantity} x ${item_list.name}\n"
                            )
                            .styleBold(false)
                            .actionPrintText(
                                "${item_list.detail}"
                            )
                            .actionFeedLine(1)
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionFeed(1.0)
                    .actionPrintText(
                        "${note}\n"
                    )
                    .actionFeed(1.0)
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "${footer1}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "${footer2}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
