//
//  LabelSample23_BarcodeLabel1_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample23_BarcodeLabel1_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 38.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionTo(6.0)
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
                            .styleVerticalPositionBy(2.0)
                            .actionPrintText(
                                "${product_number}\n"
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 16.0)
                                    .setX(0.0)
                                    .setY(20.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(4.0)
                                    .styleVerticalPositionTo(10.0)
                                    .actionPrintBarcode(StarXpandCommand.Printer.BarcodeParameter(content: "${sku}", symbology: .upcA)
                                        .setBarDots(3)
                                        .setHeight(12.0)
                                        .setPrintHRI(true)
                                    )
                                    .styleVerticalPositionTo(2.0)
                                    .actionPrintText(
                                        "MSRP $${msrp%.2f} \n",
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
                                            .styleHorizontalPositionTo(46.0)
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .styleVerticalPositionBy(3.0)
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
