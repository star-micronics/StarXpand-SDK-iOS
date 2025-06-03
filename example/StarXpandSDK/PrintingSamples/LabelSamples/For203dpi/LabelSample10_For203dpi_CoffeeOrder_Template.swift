//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample10_For203dpi_CoffeeOrder_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 80.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 20.0, y: 3.0, width: 10.0, height: 10.0)
                                    .setThickness(0.4)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 50.0, y: 3.0, width: 10.0, height: 10.0)
                                    .setThickness(0.4)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 20.0, y: 18.0, width: 10.0, height: 10.0)
                                    .setThickness(0.4)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 50.0, y: 18.0, width: 10.0, height: 10.0)
                                    .setThickness(0.4)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 20.0, y: 31.0, width: 40.0, height: 10.0)
                                    .setThickness(0.4)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 20.0, y: 45.0, width: 40.0, height: 10.0)
                                    .setThickness(0.4)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 20.0, y: 59.0, width: 10.0, height: 6.0)
                                    .setThickness(0.4)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 44.0, y: 59.0, width: 16.0, height: 6.0)
                                    .setThickness(0.4)
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 12.0, height: 80.0)
                                    .setX(0.0)
                                    .setY(0.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .stylePrintDirection(.bottomToTop)
                                    .styleVerticalPositionTo(6.0)
                                    .actionPrintText(
                                        "${store_name}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                24,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                        )
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 60.0,height: 80.0)
                                    .setX(12.0)
                                    .setY(0.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(8.0)
                                    .styleVerticalPositionTo(0.0)
                                    .actionPrintText(
                                        "Decaf",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                6,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .styleHorizontalPositionTo(38.0)
                                    .actionPrintText(
                                        "Shots\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                6,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .styleHorizontalPositionTo(8.0)
                                            .styleVerticalPositionBy(4.0)
                                            .actionPrintText(
                                                "${decaf}",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        3,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                            .styleHorizontalPositionTo(38.0)
                                            .actionPrintText(
                                                "${shots}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        3,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                    )
                                    .styleHorizontalPositionTo(8.0)
                                    .styleVerticalPositionTo(15.0)
                                    .actionPrintText(
                                        "Size",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                6,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .styleHorizontalPositionTo(38.0)
                                    .actionPrintText(
                                        "Milk\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                6,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .styleHorizontalPositionTo(8.0)
                                            .styleVerticalPositionBy(4.0)
                                            .actionPrintText(
                                                "${size}",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        3,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                            .styleHorizontalPositionTo(38.0)
                                            .actionPrintText(
                                                "${milk}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        3,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                    )
                                    .styleHorizontalPositionTo(8.0)
                                    .styleVerticalPositionTo(28.0)
                                    .actionPrintText(
                                        "Syrup\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                27,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .styleHorizontalPositionTo(8.0)
                                            .styleVerticalPositionBy(4.0)
                                            .actionPrintText(
                                                "${syrup}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        13,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                    )
                                    .styleHorizontalPositionTo(8.0)
                                    .styleVerticalPositionTo(42.0)
                                    .actionPrintText(
                                        "Custom\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                27,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .styleHorizontalPositionTo(8.0)
                                            .styleVerticalPositionBy(4.0)
                                            .actionPrintText(
                                                "${custom}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        13,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                    )
                                    .styleHorizontalPositionTo(8.0)
                                    .styleVerticalPositionTo(56.0)
                                    .actionPrintText(
                                        "Drink",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                6,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .styleHorizontalPositionTo(32.0)
                                    .actionPrintText(
                                        "Iced\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                10,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleHorizontalPositionTo(8.0)
                                            .styleVerticalPositionBy(1.0)
                                            .actionPrintText(
                                                "${drink}",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        6,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                            .styleHorizontalPositionTo(32.0)
                                            .actionPrintText(
                                                "${iced}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        10,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                    )
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .styleVerticalPositionBy(3.0)
                                            .actionPrintText(
                                                "Name:"
                                            )
                                            .styleHorizontalPositionBy(1.0)
                                            .actionPrintText(
                                                "${customer_name}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(14)
                                            )
                                    )
                                    .actionPrintText(
                                        "FOR HERE"
                                    )
                                    .actionPrintText(
                                        "${item_number} of ${total_items}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                32,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                            )
                                    )
                                    .actionPrintText(
                                        "${order_number}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(30)
                                    )
                                    .actionPrintText(
                                        "${time}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                10,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
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
