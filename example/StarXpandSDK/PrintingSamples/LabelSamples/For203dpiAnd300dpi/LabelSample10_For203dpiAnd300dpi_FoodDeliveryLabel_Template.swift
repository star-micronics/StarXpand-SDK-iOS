//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample10_For203dpiAnd300dpi_FoodDeliveryLabel_Template {
    static func createFoodDeliveryLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 72.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(72.0)
            //.settingPrintableArea(48.7)
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleBold(true)
                        .styleMagnification(StarXpandCommand.MagnificationParameter(width: 3, height: 3))
                        .actionPrintText(
                            "${store_name}\n"
                        )
                        .add(
                            StarXpandCommand.PrinterBuilder()
                                .styleInvert(true)
                                .actionPrintText(
                                    "${order_name}\n"
                                )
                        )
                )
                .styleAlignment(.center)
                .actionPrintText(
                    "Placed at ${time}\n"
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
                            "${order_types}\n"
                        )
                    )
                .add(
                    StarXpandCommand.PrinterBuilder()
                        .styleUnderLine(true)
                        .actionPrintText("                                                \n")
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
                            .setWidth(
                                40,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setEllipsizeType(.end)
                            )
                    )
                    .actionPrintText(
                        "$${item_list.price%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                8,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                )
                .actionPrintText(
                    "------------------------------------------------\n"
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
                .actionPrintText(
                    "Amount paid"
                )
                .actionPrintText(
                    "$${amount_paid%.2f}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            37,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setAlignment(.right)
                        )
                )
                .actionPrintText(
                    "item ${item_count}",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(10)
                )
                .actionPrintText(
                    "$${item_price%.2f}\n",
                    StarXpandCommand.Printer.TextParameter()
                        .setWidth(
                            38,
                            StarXpandCommand.Printer.TextWidthParameter()
                                .setAlignment(.right)
                        )
                )
                .styleAlignment(.left)
                .actionPrintText(
                    "------------------------------------------------\n" +
                    "${note}\n"
                )
                .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
