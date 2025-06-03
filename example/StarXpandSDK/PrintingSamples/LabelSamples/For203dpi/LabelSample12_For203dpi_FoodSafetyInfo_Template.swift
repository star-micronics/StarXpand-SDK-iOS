//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample12_For203dpi_FoodSafetyInfo_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 58.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 72.0, height: 58.0))
                            .styleFont(.b)
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 68.0, height: 58.0)
                                    .setX(2.0)
                                    .setY(0.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 3,height: 3))
                                    .styleVerticalPositionTo(6.0)
                                    .actionPrintText(
                                        "FOOD SAFETY INFO\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                20,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .styleVerticalPositionBy(8.0)
                                    .actionPrintText(
                                        "Item:"
                                    )
                                    .styleHorizontalPositionBy(1.0)
                                    .styleUnderLine(true)
                                    .actionPrintText(
                                        "${item_name}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(24)
                                    )
                                    .styleUnderLine(false)
                                    .styleVerticalPositionBy(10.0)
                                    .actionPrintText(
                                        "Prepared Date:"
                                    )
                                    .styleHorizontalPositionBy(1.0)
                                    .styleUnderLine(true)
                                    .actionPrintText(
                                        "${prepared_date}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(15)
                                    )
                                    .styleUnderLine(false)
                                    .styleVerticalPositionBy(10.0)
                                    .actionPrintText(
                                        "Use By Date:"
                                    )
                                    .styleHorizontalPositionBy(1.0)
                                    .styleUnderLine(true)
                                    .actionPrintText(
                                        "${use_by_date}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(17)
                                    )
                            )
                            .styleHorizontalPositionTo(3.0)
                            .styleVerticalPositionTo(21.0)
                            .actionPrintText(
                                "Producto\n"
                            )
                            .styleHorizontalPositionTo(3.0)
                            .styleVerticalPositionTo(35.0)
                            .actionPrintText(
                                "Fecha de preparación\n"
                            )
                            .styleHorizontalPositionTo(3.0)
                            .styleVerticalPositionTo(49.0)
                            .actionPrintText(
                                "Fecha de expiración\n"
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
