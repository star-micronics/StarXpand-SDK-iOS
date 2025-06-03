//
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample10_Order2_Template {
    static func createReceiptTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
                    .settingPrintableArea(72.0)
                    .addPrinter(
                        StarXpandCommand.PrinterBuilder()
                            .styleCJKCharacterPriority([.japanese])
                            .actionPrintText(
                                "${time}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(8)
                            )
                            .actionPrintText(
                                "${staff_name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        20,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                            .setWidthType(.full)
                                    )
                            )
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                            .styleInvert(true)
                            .actionPrintText(
                                " ${classification} "
                            )
                            .styleInvert(false)
                            .actionPrintText(
                                " ${table_number}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(10)
                            )
                            .add(
                                StarXpandCommand.PrinterBuilder()
                                    .styleLineSpace(0.0)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                                    .actionPrintText(
                                        "${visitors}名\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                20,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                            )
                                    )
                            )
                            .actionFeed(0.5)
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
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
                                        "${item_list.name}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(22)
                                    )
                                    .actionPrintText(
                                        "${item_list.quantity}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                2,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                            )
                                    )
                            )
                            .actionCut(.partial)
                    )
                )
                
                return builder.getCommands()
            }
        }
