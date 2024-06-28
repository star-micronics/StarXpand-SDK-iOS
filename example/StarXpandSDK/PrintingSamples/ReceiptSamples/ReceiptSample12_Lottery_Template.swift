//
//  ReceiptSample12_Lottery_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample12_Lottery_Template {
    static func createReceiptTemplate() -> String {
        guard let logoImage = UIImage(named: "logo_01.png") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
                    .settingPrintableArea(72.0)
                    .addPrinter(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.center)
                            .styleLineSpace(3.0)
                            .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logoImage, width: 400))
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
                                        "${item_list.header}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(1)
                                    )
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .actionPrintText(
                                        " ${item_list.number_1%02d}" +
                                                " ${item_list.number_2%02d}" +
                                                " ${item_list.number_3%02d}" +
                                                " ${item_list.number_4%02d}" +
                                                " ${item_list.number_5%02d}"
                                    )
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                                    .actionPrintText(
                                        " OP"
                                    )
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .actionPrintText(
                                        " ${item_list.number_6%02d}"
                                    )
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                                    .actionPrintText(
                                        " OP\n"
                                    )
                            )
                            .actionFeedLine(1)
                            .add(
                                StarXpandCommand.PrinterBuilder()
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .actionPrintText(
                                        "${winning_day}\n" +
                                                "$${price%.2f}\n"
                                    )
                            )
                            .actionFeedLine(1)
                            .actionPrintText(
                                "${sales_number}\n" +
                                        "${datetime}\n"
                            )
                            .actionFeedLine(1)
                            .actionPrintText(
                                "${note}\n"
                            )
                            .actionPrintBarcode(
                                StarXpandCommand.Printer.BarcodeParameter(content: "${barcode}", symbology: .code128)
                                    .setHeight(7.0)
                            )
                            .actionCut(.partial)
                    )
                )
                
                return builder.getCommands()
            }
        }
