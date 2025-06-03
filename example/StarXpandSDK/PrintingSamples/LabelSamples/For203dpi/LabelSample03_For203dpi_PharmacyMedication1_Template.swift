//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample03_For203dpi_PharmacyMedication1_Template {
    static func createLabelTemplate() -> String {
        guard let logoImage = UIImage(named: "pharmacy_medication1_logo.png") else {
            print("Failed to load \"pharmacy_medication1_logo.png\".")
            return ""
        }
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 75.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintImage(
                                StarXpandCommand.Printer.PageModeImageParameter(image: logoImage, x: 0.0, y: 0.0, width: 130)
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 54.0, height: 20.0 )
                                    .setX(18.0)
                                    .setY(0.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(0.0)
                                    .styleVerticalPositionTo(4.0)
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 2,height: 2)
                                    )
                                    .actionPrintText(
                                        "${store_name}\n"
                                    )
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 1,height: 1)
                                    )
                                    .actionPrintText(
                                        "${address}\n"
                                    )
                                    .actionPrintText(
                                        "${telephone_number}\n"
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 20.0)
                                    .setY(20.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintRectangle(
                                        StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 72.0, height: 16.0)
                                    )
                                    .styleHorizontalPositionTo(1.0)
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 2,height: 2)
                                    )
                                    .styleVerticalPositionTo(4.0)
                                    .actionPrintText(
                                        "${number}\n"
                                    )
                                    .styleHorizontalPositionTo(1.0)
                                    .styleVerticalPositionBy(4.0)
                                    .actionPrintText(
                                        "${customer_name}"
                                    )
                            )
                            .styleVerticalPositionTo(40.0)
                            .actionPrintText(
                                "Usage:\n"
                            )
                            .styleBold(true)
                            .actionPrintText(
                                "${usage}\n"
                            )
                            .styleBold(false)
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 10.0)
                                    .setY(55.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintRectangle(
                                        StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 72.0, height: 8.0)
                                    )
                                    .styleHorizontalPositionTo(1.0)
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 2,height: 2)
                                    )
                                    .styleVerticalPositionTo(4.0)
                                    .actionPrintText(
                                        "□ Refill\t□ No Refill\n"
                                    )
                            )
                            .styleVerticalPositionTo(65.0)
                            .actionPrintText(
                                "EXP: ${expiry_date}\n"
                            )
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleMagnification(
                                        StarXpandCommand.MagnificationParameter(width: 2,height: 1)
                                        )
                                    .actionPrintText(
                                        "Quantity: ${quantity}\n"
                                    )
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
