//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample18_For203dpiAnd300dpi_BarcodeLabel2_Narrow_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 48.0 for 203dpi, 34.0 for 300dpi
            .settingPrintableArea(48.0)
            //.settingPrintableArea(34.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .actionPrintText(
                        "${product_name}\n"
                    )
                    .styleBold(false)
                    .styleFont(.b)
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
