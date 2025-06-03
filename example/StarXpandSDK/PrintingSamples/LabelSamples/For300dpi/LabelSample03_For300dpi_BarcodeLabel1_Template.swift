//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample03_For300dpi_BarcodeLabel1_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.7, height: 24.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionTo(3.0)
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .actionPrintText(
                                        "${shop_name}\n"
                                    )
                            )
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionBy(1.0)
                            .actionPrintText(
                                "${product_name}\n"
                            )
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionBy(1.0)
                            .actionPrintText(
                                "${product_number}\n"
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.7, height: 10.0)
                                    .setX(0.0)
                                    .setY(14.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(4.0)
                                    .styleVerticalPositionTo(6.0)
                                    .actionPrintBarcode(StarXpandCommand.Printer.BarcodeParameter(content: "${sku}", symbology: .upcA)
                                        .setBarDots(3)
                                        .setHeight(8.0)
                                        .setPrintHRI(true)
                                    )
                                    .styleVerticalPositionTo(1.0)
                                    .actionPrintText(
                                        "MSRP $${msrp%.2f} \n\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                48,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                            )
                                    )
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleBold(true)
                                            .styleHorizontalPositionTo(31.0)
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .actionPrintText(
                                                "$${selling_price% .2f}\n"
                                            )
                                    )
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
