//
//  LabelSample27_AllergenWarning_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample27_AllergenWarning_Template {
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
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .styleVerticalPositionTo(0.0)
                                    .actionPrintText(
                                        "ALLERGEN WARNING\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                24,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.center)
                                            )
                                    )
                                    .styleHorizontalPositionTo(5.0)
                                    .styleVerticalPositionBy(7.0)
                                    .actionPrintText(
                                        "Item: "
                                    )
                                    .styleUnderLine(true)
                                    .actionPrintText(
                                        "${item}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(14)
                                    )
                                    .styleHorizontalPositionTo(5.0)
                                    .styleUnderLine(false)
                                    .styleVerticalPositionBy(5.0)
                                    .actionPrintText(
                                        "Date: "
                                    )
                                    .styleUnderLine(true)
                                    .actionPrintText(
                                        "${date}\n",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(14)
                                    )
                                    .styleUnderLine(false)
                            )
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 2.0, y: 30.0, width: 4.0, height: 4.0))
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 25.0, y: 30.0, width: 4.0, height: 4.0))
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 48.0, y: 30.0, width: 4.0, height: 4.0))
                            .styleHorizontalPositionTo(3.0)
                            .styleVerticalPositionTo(31.0)
                            .actionPrintText(
                                "${dairy}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Dairy"
                            )
                            .styleHorizontalPositionTo(26.0)
                            .actionPrintText(
                                "${fish}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Fish"
                            )
                            .styleHorizontalPositionTo(49.0)
                            .actionPrintText(
                                "${eggs}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Eggs"
                            )
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 2.0, y: 36.0, width: 4.0, height: 4.0))
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 25.0, y: 36.0, width: 4.0, height: 4.0))
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 48.0, y: 36.0, width: 4.0, height: 4.0))
                            .styleHorizontalPositionTo(3.0)
                            .styleVerticalPositionTo(37.0)
                            .actionPrintText(
                                "${peanuts}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Peanuts"
                            )
                            .styleHorizontalPositionTo(26.0)
                            .actionPrintText(
                                "${shellfish}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Shellfish"
                            )
                            .styleHorizontalPositionTo(49.0)
                            .actionPrintText(
                                "${soy}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Soy"
                            )
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 2.0, y: 42.0, width: 4.0, height: 4.0))
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 25.0, y: 42.0, width: 4.0, height: 4.0))
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 48.0, y: 42.0, width: 4.0, height: 4.0))
                            .styleHorizontalPositionTo(3.0)
                            .styleVerticalPositionTo(43.0)
                            .actionPrintText(
                                "${treenuts}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Tree Nuts")

                            .styleHorizontalPositionTo(26.0)
                            .actionPrintText(
                                "${wheat}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Wheat"
                            )
                            .styleHorizontalPositionTo(49.0)
                            .actionPrintText(
                                "${gluten}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .styleHorizontalPositionBy(4.0)
                            .actionPrintText(
                                "Gluten"
                            )
                            .styleHorizontalPositionTo(9.0)
                            .styleVerticalPositionBy(8.0)
                            .actionPrintText(
                                "Other: "
                            )
                            .styleUnderLine(true)
                            .actionPrintText(
                                "${other}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(32)
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
