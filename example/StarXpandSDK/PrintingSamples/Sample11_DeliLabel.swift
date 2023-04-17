//
//  Sample11_DeliLabel.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample11_DeliLabel {
    static func createDeliLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "Star Grocery Store\n"
                            )
                    )
                    .actionPrintText(
                        "123 Star road, City, State 12345\n" +
                        "\n"
                    )
                    .styleAlignment(.left)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "Roast Beef\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                    )
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 32.0)
                            .setY(3.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .styleVerticalPositionBy(16.0)
                            .actionPrintBarcode(StarXpandCommand.Printer.BarcodeParameter(content: "21234567890", symbology: .upcA)
                                .setBarDots(3)
                                .setHeight(10.0)
                                .setPrintHRI(true)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 38.0, y: 0.0, width: 34.0, height: 27.0)
                                    .setRoundCorner(true)
                                    .setCornerRadius(3.0)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 38.0, yStart: 13.5, xEnd: 72.0, yEnd: 13.5)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 55.0, yStart: 0.0, xEnd: 55.0, yEnd: 13.5)
                            )
                            .styleHorizontalPositionTo(45.0)
                            .styleVerticalPositionTo(2.0)
                            .actionPrintText(
                                "$/lb\n"
                            )
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(45.0)
                                    .styleVerticalPositionTo(8.0)
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                                    .actionPrintText(
                                        "4.99\n"
                                    )
                            )
                            .styleHorizontalPositionTo(58.0)
                            .styleVerticalPositionTo(2.0)
                            .actionPrintText(
                                "weight\n"
                            )
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(58.0)
                                    .styleVerticalPositionTo(8.0)
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                                    .actionPrintText(
                                        "0.24 lb\n"
                                    )
                            )
                            .styleHorizontalPositionTo(62.0)
                            .styleVerticalPositionTo(15.5)
                            .actionPrintText(
                                "Price\n"
                            )
                            .styleHorizontalPositionTo(60.0)
                            .styleVerticalPositionTo(21.5)
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "$ 1.20\n"
                            )
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
