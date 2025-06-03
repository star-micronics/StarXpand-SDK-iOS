//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample14_For203dpi_BarbellLabel_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(54.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 54.0, height: 27.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .styleHorizontalPositionTo(5.0)
                            .styleVerticalPositionTo(5.0)
                            .actionPrintBarcode(
                                StarXpandCommand.Printer.BarcodeParameter(content: "${barcode}", symbology: .code128)
                                    .setBarDots(2)
                                    .setHeight(4.0)
                                    .setPrintHRI(true)
                            )
                            .styleHorizontalPositionTo(32.0)
                            .styleVerticalPositionTo(4.0)
                            .actionPrintText(
                                "${product_name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        12,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.center)
                                    )
                            )
                            .styleVerticalPositionBy(3.0)
                            .styleHorizontalPositionTo(32.0)
                            .actionPrintText(
                                "$${price%.2f}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        12,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.center)
                                    )
                            )
                        
                            .styleHorizontalPositionTo(5.0)
                            .styleVerticalPositionTo(16.0)
                            .actionPrintBarcode(
                                StarXpandCommand.Printer.BarcodeParameter(content: "${barcode}", symbology: .code128)
                                    .setBarDots(2)
                                    .setHeight(4.0)
                                    .setPrintHRI(true)
                            )
                            .styleHorizontalPositionTo(32.0)
                            .styleVerticalPositionTo(15.0)
                            .actionPrintText(
                                "${product_name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        12,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.center)
                                    )
                            )
                            .styleVerticalPositionBy(3.0)
                            .styleHorizontalPositionTo(32.0)
                            .actionPrintText(
                                "$${price%.2f}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        12,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.center)
                                    )
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
