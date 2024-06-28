//
//  ReceiptSample09_Order1_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample09_Order1_Template {
    static func createReceiptTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
                    .settingPrintableArea(72.0)
                    .addPrinter(
                        StarXpandCommand.PrinterBuilder()
                            .add(
                                StarXpandCommand.PrinterBuilder()
                                    .styleAlignment(.center)
                                    .styleLineSpace(0.0)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .actionPrintText(
                                        "${header}\n"
                                    )
                                    .styleBold(true)
                                    .styleInvert(true)
                                    .actionPrintText(
                                        "${title}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                24,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                            )
                            .actionFeed(2.0)
                            .actionPrintText(
                                "#${number}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(10)
                            )
                            .actionPrintText(
                                "${datetime}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        38,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .styleBold(true)
                            .actionPrintText(
                                "${store_name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(20)
                            )
                            .styleBold(false)
                            .actionPrintText(
                                "${order_number}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        28,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                "${customer_name}\n"
                            )
                            .actionFeedLine(1)
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            )
                            .add(
                                StarXpandCommand.PrinterBuilder()
                                    .styleBold(true)
                                    .actionPrintText(
                                        "# Item"
                                    )
                                    .actionPrintText(
                                        "Cst.#\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                42,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                            )
                                    )
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
                                        "${item_list.quantity}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(2)
                                    )
                                    .actionPrintText(
                                        "${item_list.name}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(41)
                                    )
                                    .actionPrintText(
                                        "${item_list.cost}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                5,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                            )
                                    )
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            )
                            .actionCut(.partial)
                    )
                )
                
                return builder.getCommands()
            }
        }
