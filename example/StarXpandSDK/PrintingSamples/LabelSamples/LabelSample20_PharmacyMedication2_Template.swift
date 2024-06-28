//
//  LabelSample20_PharmacyMedication2_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample20_PharmacyMedication2_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleCJKCharacterPriority([.japanese])
                    .actionPrintText(
                        "${patient_name} 様",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "処方日 ${prescription_date}  \n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "調剤日 ${dispensing_date}  \n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                48,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "${hospital_name}:\n"
                    )
                    .actionFeedLine(1)
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                        )
                        .actionPrintText(
                            "  ${item_list1.name}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    17,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setWidthType(.full)
                                )
                        )
                        .actionPrintText(
                            "${item_list1.take_the_medicine}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(5)
                        )
                        .actionPrintText(
                            "${item_list1.dosage}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(9)
                        )
                    )
                    .actionPrintText(
                        "  ----------------------------------------------\n"
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
                            "  ${item_list2.name}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    17,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setWidthType(.full)
                                )
                        )
                        .actionPrintText(
                            "${item_list2.take_the_medicine}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(5)
                        )
                        .actionPrintText(
                            "${item_list2.dosage}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(9)
                        )
                        .actionPrintText(
                            "　${item_list2.note}\n"
                        )
                    )
                    .actionPrintText(
                        "  ----------------------------------------------\n"
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
                            "  ${item_list3.name}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    17,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setWidthType(.full)
                                )
                        )
                        .actionPrintText(
                            "${item_list3.take_the_medicine}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(5)
                        )
                        .actionPrintText(
                            "${item_list3.dosage}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(9)
                        )
                        .actionPrintText(
                            "　${item_list3.note}\n"
                        )
                    )
                    .actionPrintText(
                        "  ----------------------------------------------\n"
                    )
                    .actionPrintText(
                        "${store_name}  TEL ${telephone_number}\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
