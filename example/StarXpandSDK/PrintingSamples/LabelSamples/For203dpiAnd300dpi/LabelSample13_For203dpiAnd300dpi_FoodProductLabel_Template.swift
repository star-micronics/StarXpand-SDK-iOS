//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample13_For203dpiAnd300dpi_FoodProductLabel_Template {
    static func createFoodProductLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 72.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(72.0)
            //.settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${name}\n"
                            )
                    )
                    .actionPrintText(
                        "${message}\n" +
                        "------------------------------------------------\n" +
                        "MFG ${manufacturing_date}\n" +
                        "------------------------------------------------\n" +
                        "${note}\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
