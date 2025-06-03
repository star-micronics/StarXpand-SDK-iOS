//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample09_For203dpi_CleanedAndSanitised_Template {
    static func createLabelTemplate() -> String {
        guard let handImage = UIImage(named: "cleanedsanitised_hand.png") else {
            print("Failed to load \"cleanedsanitised_hand.png\".")
            return ""
        }
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 40.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 18.0, height: 18.0)
                                    .setThickness(0.8)
                            )
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 20.0, width: 72.0, height: 20.0)
                                    .setThickness(0.8)
                            )
                            .actionPrintImage(
                                StarXpandCommand.Printer.PageModeImageParameter(image: handImage, x: 1.0, y: 1.0, width: 130)
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 50.0, height: 20.0)
                                    .setX(22.0)
                                    .setY(0.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .styleVerticalPositionTo(3.0)
                                    .actionPrintText(
                                        "CLEANED\n"
                                    )
                                    .styleVerticalPositionBy(4.0)
                                    .actionPrintText(
                                        "& SANITISED\n"
                                    )
                            )
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionTo(21.0)
                            .actionPrintText(
                                "Name:"
                            )
                            .styleHorizontalPositionTo(45.0)
                            .actionPrintText(
                                "Date:"
                            )
                            .styleHorizontalPositionTo(2.0)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 2))
                            .styleVerticalPositionBy(10.0)
                            .actionPrintText(
                                "${name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(28)
                            )
                            .actionPrintText(
                                " "
                            )
                            .actionPrintText(
                                "${date}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(16)
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
