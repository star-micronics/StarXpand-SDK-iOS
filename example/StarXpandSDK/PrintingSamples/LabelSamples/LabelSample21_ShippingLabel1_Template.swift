//
//  LabelSample21_ShippingLabel1_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample21_ShippingLabel1_Template {
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
                    .styleLineSpace(0.0)
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0,height: 21.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 50.0,height: 8.0),
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
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 42.0,height: 8.0)
                                    .setX(6.0)
                                    .setY(10.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleLineSpace(0.0)
                                    .actionPrintText(
                                        "${address}\n"
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 42.0,height: 4.0)
                                    .setX(6.0)
                                    .setY(17.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "${telephone_number}\n"
                                    )
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
                    )
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 30.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 72.0, height: 30.0)
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 3.0)
                                    .setX(1.0)
                                    .setY(1.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleBold(true)
                                    .actionPrintText(
                                        "TO:"
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 70.0, height: 28.0)
                                    .setX(2.0)
                                    .setY(4.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleLineSpace(3.0)
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 2,height: 2)
                                    )
                                    .styleVerticalPositionTo(4.0)
                                    .actionPrintText(
                                        "${name_to}\n"
                                    )
                                    .styleVerticalPositionBy(4.0)
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
