//
//  ReceiptSample02_Retail_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample02_Retail_Template {
    static func createReceiptTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleInvert(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                            .actionPrintText(
                                "${store_name}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        24,
                                        StarXpandCommand.Printer.TextWidthParameter().setAlignment(.center)
                                    )
                            )
                    )
                    .styleAlignment(.left)
                    .actionPrintText(
                        "${order_number}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "${datetime}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "${order_types}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "Served by ${staff_name}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "Transaction ${transaction}\n"
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
                            .actionPrintText(
                                "${item_list.quantity} x ${item_list.name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(37)
                            )
                            .actionPrintText(
                                " "
                            )
                            .actionPrintText(
                                "${item_list.price%8.2f} T\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        10,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                "${item_list.detail}"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Subtotal"
                    )
                    .actionPrintText(
                        "${subtotal_price%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                40,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "Tax"
                    )
                    .actionPrintText(
                        "${tax%8.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                45,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "Total"
                    )
                    .actionPrintText(
                        "${total_price%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                43,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .styleBold(false)
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "${payment_method}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "${payment_amount%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .styleAlignment(.center)
                    .actionPrintText(
                        "${address}\n" +
                        "${telephone_number}\n" +
                        "${footer}\n"
                    )
                    .actionPrintBarcode(
                        StarXpandCommand.Printer.BarcodeParameter(content: "${barcode}", symbology: .code128)
                            .setBarDots(1)
                            .setPrintHRI(true)
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
