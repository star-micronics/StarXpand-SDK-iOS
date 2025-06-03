//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample02_For203dpiAnd300dpi_DrinkLabel1_Template {
    static func createDrinkLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 48.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(48.0)
            // .settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    // By setting the base print size of text to x1.5 for 300dpi,
                    // you can print text at the same size as 203dpi.
                    //.styleBaseMagnification(StarXpandCommand.Printer.BaseMagnificationParameter().setText(.x1_5))
                    .styleBold(true)
                    .actionPrintText(
                        "Item:\t${item_number} of ${number_of_items}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${customer_name}\n" +
                                "${item_name}\n"
                            )
                    )
                    .actionPrintText(
                        "${order_detail}\n" +
                        "\n" +
                        "Time:\t${time}\n" +
                        "Reg:\t${register}\n" +
                        "\n" +
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "${note}\n"
                            )
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
