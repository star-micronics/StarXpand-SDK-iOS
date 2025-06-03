//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample05_For203dpiAnd300dpi_DrinkLabel4_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 72.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(72.0)
            //.settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleCJKCharacterPriority([.japanese])
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${order_types}"
                            )
                    )
                    .styleHorizontalPositionTo(0.0)
                    .actionPrintText(
                        "${datetime}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                48,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleInvert(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${order_number}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(4)
                            )
                    )
                    .actionPrintText(
                        "(${item_number}/${number_of_items})",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(6)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${time}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        17,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${product_name}\n"
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
                            .styleHorizontalPositionTo(1.0)
                            .actionPrintText(
                                "${item_list.detail}\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "${note}\n"
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
