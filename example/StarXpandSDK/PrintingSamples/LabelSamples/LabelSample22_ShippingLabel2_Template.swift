//
//  LabelSample22_ShippingLabel2_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample22_ShippingLabel2_Template {
    static func createLabelTemplate() -> String {
        guard let logoImage = UIImage(named: "logo_01.png") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        guard let houseImage = UIImage(named: "label_sample21_shipping_label_house.png") else {
            print("Failed to load \"label_sample21_shipping_label_house.png\".")
            return ""
        }
        guard let phoneImage = UIImage(named: "label_sample21_shipping_label_phones_old.png") else {
            print("Failed to load \"label_sample21_shipping_label_phones_old.png\".")
            return ""
        }
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0,height: 72.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .stylePrintDirection(.bottomToTop)
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 8.0,height: 50.0)
                                    .setY(24.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 2,height: 2)
                                    )
                                    .styleVerticalPositionTo(4.0)
                                    .actionPrintText(
                                        "${business_name}\n"
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 8.0,height: 42.0)
                                    .setX(10.0)
                                    .setY(24.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleLineSpace(0.0)
                                    .actionPrintText(
                                        "${address}\n"
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 4.0,height: 42.0)
                                    .setX(17.0)
                                    .setY(24.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "${telephone_number}\n"
                                    )
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 22.0, xEnd: 72.0, yEnd: 22.0)
                                    .setLineStyle(.single)
                                    .setThickness(1.0)
                            )
                            .actionPrintImage(
                                StarXpandCommand.Printer.PageModeImageParameter(image: logoImage, x: 47.0, y: 0.0, width: 200)
                            )
                            .actionPrintImage(
                                StarXpandCommand.Printer.PageModeImageParameter(image: houseImage, x: 0.0, y: 10.0, width: 40)
                            )
                            .actionPrintImage(
                                StarXpandCommand.Printer.PageModeImageParameter(image: phoneImage, x: 0.0, y: 16.0, width: 40)
                            )
                            .stylePrintDirection(.leftToRight)
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 47.0, height: 72.0)
                                    .setX(25.0)
                                    .setY(0.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleBold(true)
                                    .styleLineSpace(3.0)
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 2,height: 2)
                                    )
                                    .styleVerticalPositionTo(6.0)
                                    .actionPrintText(
                                        "TO:\n"
                                    )
                                    .styleBold(false)
                                    .styleVerticalPositionBy(7.0)
                                    .actionPrintText(
                                        "${name_to}\n"
                                    )
                                    .styleVerticalPositionBy(3.0)
                                    .actionPrintText(
                                        "${address_to}\n"
                                    )
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
