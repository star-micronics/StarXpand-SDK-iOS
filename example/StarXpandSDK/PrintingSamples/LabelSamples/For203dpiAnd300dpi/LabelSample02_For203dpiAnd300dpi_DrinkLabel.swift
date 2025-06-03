//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample02_For203dpiAnd300dpi_DrinkLabel {
    static func createDrinkLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleBold(true)
                    .actionPrintText(
                        "Item:   1 of 3\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "* Jane Smith *\n" +
                                "Gr Icd Coffee\n"
                            )
                    )
                    .actionPrintText(
                        "No Classic\n" +
                        "With Whole Milk\n" +
                        "\n" +
                        "Time:   4:14:29 PM\n" +
                        "Reg:    9\n" +
                        "\n" +
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                ">MOBILE<\n"
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
