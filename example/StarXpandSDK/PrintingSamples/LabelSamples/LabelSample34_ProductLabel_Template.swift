//
//  LabelSample34_ProductLabel_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample34_ProductLabel_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 24.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 48.0, height: 24.0))
                            .actionPrintRuledLine(StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 22.0, yStart: 0.0, xEnd: 22.0, yEnd: 24.0))
                            .actionPrintRuledLine(StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 8.0, xEnd: 22.0, yEnd: 8.0))
                            .actionPrintRuledLine(StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 16.0, xEnd: 22.0, yEnd: 16.0))
                            .styleHorizontalPositionTo(2.0)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .styleVerticalPositionTo(4.0)
                            .actionPrintText(
                                "${code1}\n"
                            )
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionTo(12.0)
                            .actionPrintText(
                                "${code2}\n"
                            )
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionTo(20.0)
                            .actionPrintText(
                                "${code3}\n"
                            )
                            .styleHorizontalPositionTo(26.0)
                            .styleVerticalPositionTo(0.0)
                            .actionPrintQRCode(
                                StarXpandCommand.Printer.QRCodeParameter(content: "${qrcode}")
                                    .setCellSize(6)
                                    .setLevel(.q)
                                    .setModel(.model2)
                            )
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
