//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample18_For203dpiAnd300dpi_BarcodeLabel2_Wide_Template {
    static func createLabelTemplate() -> String {
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
                    .actionPrintText(
                        "${product_name}\n"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "${parameter1} / ${parameter2} / ${parameter3} / ${parameter4}\n"
                    )
                    .actionPrintBarcode(
                        StarXpandCommand.Printer.BarcodeParameter(content: "${sku}", symbology: .upcA)
                            .setBarDots(3)
                            .setHeight(12.0)
                            .setPrintHRI(true)
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
