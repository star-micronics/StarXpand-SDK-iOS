//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample12_For203dpiAnd300dpi_InventoryLabel_Template {
    static func createInventoryLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 72.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(72.0)
            //.settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleUnderLine(true)
                            .actionPrintText(
                                "${name}\n"
                            )
                    )
                    .actionPrintText(
                        "P/N: ${parts_number%06u}\n"
                    )
                    .actionPrintBarcode(
                        //TODO 2558271100031だと3inchに収まらない
                        StarXpandCommand.Printer.BarcodeParameter(content: "${sku}", symbology: .code39)
                            .setBarDots(3)
                            .setHeight(18.0)
                            .setPrintHRI(true)
                    )
                    .actionPrintText(
                        "\n" +
                        "ABC: ${abc}\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
