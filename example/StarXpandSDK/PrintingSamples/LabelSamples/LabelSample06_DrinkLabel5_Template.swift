//
//  LabelSample06_DrinkLabel5_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample06_DrinkLabel5_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleLineSpace(1.0)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleInvert(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${header}\n"
                            )
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${order_types}\n"
                            )
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "#${order_number%04d}\n"
                            )
                    )
                    .actionPrintText(
                        "${time}\n"
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.left)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${product_name}\n"
                            )
                            .add(
                                StarXpandCommand.PrinterBuilder(
                                    StarXpandCommand.Printer.PrinterParameter()
                                        .setTemplateExtension(
                                            StarXpandCommand.TemplateExtensionParameter()
                                                .setEnableArrayFieldData(true)
                                        )
                                )
                                    .styleHorizontalPositionTo(3.0)
                                    .actionPrintText(
                                        "${item_list.detail}\n"
                                    )
                            )
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleInvert(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${footer}\n"
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
