//
//  Sample03_NutritionFactsLabel.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample03_NutritionFactsLabel {
    static func createNutritionFactsLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.center)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 3, height: 3))
                            .actionPrintText(
                                "Nutrition Facts\n"
                            )
                    )
                    .styleAlignment(.left)
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "16 servings per container\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "Serving size                        1 Tbsp.(21g)\n"
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                                    .setThickness(4.0)
                            )
                            .actionPrintText(
                                "Amount per serving\n"
                            )
                            .styleMagnification(
                                StarXpandCommand.MagnificationParameter(width: 3, height: 3)
                            )
                            .actionPrintText(
                                "Calories      60\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(2.0)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.right)
                            .styleBold(true)
                            .actionPrintText(
                                "% Daily Value*\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Total Fat 0g                                  0%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleHorizontalPositionBy(3.0)
                            .actionPrintText(
                                "Saturated Fat 0g                            0%\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                        .setThickness(0.1))
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleHorizontalPositionBy(3.0)
                            .actionPrintText(
                                "Trans Fat 0g\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Cholesterol 0mg                               0%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Sodium 0mg                                    0%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Total Carbohydrate 17g                        6%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleHorizontalPositionBy(3.0)
                            .actionPrintText(
                                "Dietary Fiber 0g                            0%\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleHorizontalPositionBy(3.0)
                            .actionPrintText(
                                "Total Sugars 17g\n"
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "                                             34%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Protein 0g\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(4.0)
                    )
                    .actionPrintText(
                        "Vitamin D 0mcg                                0%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Calcium 0mg                                   0%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Iron 0mg                                      0%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "Potassium 0mg                                 0%\n"
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.1)
                    )
                    .actionPrintText(
                        "* The % Daily Value (DV) tells you how much a nutrient in a serving of food contributes to a daily diet. 2,000 calories a day is used for general nutrition advice.\n" +
                        "↑ One Serving adds 17g of sugar to your diet and represents 34% of the daily value for addded sugars.\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
