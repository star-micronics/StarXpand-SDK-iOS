//
//  LabelSample33_VisitorLabel_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample33_VisitorLabel_Template {
    static func createReceiptTemplate() -> String {
        guard let logoImage = UIImage(named: "logo_01.png") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        
        guard let userImage = UIImage(named: "label_sample33_visitor_label_user_profile_picture.png") else {
            print("Failed to load \"label_sample33_visitor_label_user_profile_picture.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 90.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .stylePrintDirection(.topToBottom)
                            .actionPrintImage(StarXpandCommand.Printer.PageModeImageParameter(image: logoImage,x: 7.0,y: 4.0,width: 140 ))
                            .actionPrintImage(StarXpandCommand.Printer.PageModeImageParameter(image: userImage,x: 5.0,y: 14.0,width: 160 ))
                            .actionPrintRuledLine(StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 4.0, yStart: 12.0, xEnd: 75.0, yEnd: 12.0))
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 52.0)
                                    .setX(0.0)
                                    .setY(28.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleBold(true)
                                    .styleHorizontalPositionTo(0.0)
                                    .styleVerticalPositionTo(8.0)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 3,height: 3))
                                    .actionPrintText(
                                        "VISITOR\n"
                                    )
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .styleVerticalPositionBy(5.0)
                                    .actionPrintText(
                                        "${name}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(17)
                                    )
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                                    .styleVerticalPositionBy(1.0)
                                    .actionPrintText(
                                        "${company_name}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(34)
                                    )
                                    .styleBold(false)
                                    .styleVerticalPositionBy(1.0)
                                    .actionPrintText(
                                        "Visiting:"
                                    )
                                    .styleBold(true)
                                    .actionPrintText(
                                        "${visiting}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(25)
                                    )
                                    .styleBold(false)
                                    .styleVerticalPositionBy(1.0)
                                    .actionPrintText(
                                        "${datetime}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(34)
                                    )
                                    .styleHorizontalPositionTo(5.0)
                                    .styleVerticalPositionBy(3.0)
                                    .actionPrintBarcode(
                                        StarXpandCommand.Printer.BarcodeParameter(content: "${barcode}", symbology: .code128)
                                            .setHeight(5.0)
                                            .setPrintHRI(true)
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 28.0,height: 10.0)
                                    .setX(10.0)
                                    .setY(80.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(0.0)
                                    .styleVerticalPositionTo(0.0)
                                    .stylePrintDirection(.rightToLeft)
                                    .styleBold(true)
                                    .styleLineSpace(0.0)
                                    .actionPrintText(
                                        "FOLD\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                18,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .actionPrintText(
                                        "UNDER\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                18,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .actionPrintText(
                                        "▼   ▼\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                18,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
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
