//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample04_For203dpiAnd300dpi_DrinkLabel3_Template {
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
                    .actionPrintText(
                        "No.${order_number}(${item_number}/${number_of_items}) ${datetime}\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
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
                            .styleHorizontalPositionTo(2.0)
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
                    .styleAlignment(.right)
                    .actionPrintText(
                        "No:${number}\n"
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
