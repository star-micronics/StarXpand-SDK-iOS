//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample09_For203dpiAnd300dpi_FoodPrepLabel_Template {
    static func createFoodPrepLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 48.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(48.0)
            //.settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.right)
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${day_of_week}\n"
                            )
                    )
                    .styleAlignment(.left)
                    .actionPrintText(
                        "Product\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${product}\n"
                            )
                    )
                    .actionPrintText(
                        "Prepared On\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${prepared_on}\n"
                            )
                    )
                    .actionPrintText(
                        "Used by\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${used_by}\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 48.0)
                    )
                    .actionPrintText(
                        "User: ${user} ",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(16)
                    )
                    .actionPrintText(
                        "Manager: ${manager}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(16)
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
