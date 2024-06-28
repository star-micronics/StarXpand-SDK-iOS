//
//  LabelSample08_NutritionFactsLabel_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample08_NutritionFactsLabel_Template {
    static func createNutritionFactsLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
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
                        "${servings_per_container} servings per container\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "Serving size"
                            )
                            .actionPrintText(
                                "${serving_size}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        36,
                                        StarXpandCommand.Printer.TextWidthParameter().setAlignment(.right)
                                    )
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
                                "${amount_per_serving}\n"
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
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                            )
                        .actionPrintRuledLine(
                            StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                                .setThickness(0.1)
                        )
                        .actionPrintText(
                            "${item1_list.name} ${item1_list.amount}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(44)
                        )
                        .actionPrintText(
                            "${item1_list.percentage}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    4,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setAlignment(.right)
                                )
                        )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(4.0)
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                            )
                        .actionPrintText(
                            "${item2_list.name} ${item2_list.amount}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(44)
                        )
                        .actionPrintText(
                            "${item2_list.percentage}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    4,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setAlignment(.right)
                                )
                        )
                        .actionPrintRuledLine(
                            StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                                .setThickness(0.1)
                        )
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
