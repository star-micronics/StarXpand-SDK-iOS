//
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample07_Lunch1_Template {
    static func createReceiptTemplate() -> String {
        guard let logoImage = UIImage(named: "logo_01.png") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleCJKCharacterPriority([.japanese])
                    .styleInternationalCharacter(.japan)
                    .actionPrintImage(
                        StarXpandCommand.Printer.ImageParameter(image: logoImage, width: 400)
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "["
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "領収書"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "]\n"
                    )
                    .actionPrintText(
                        "${store_name}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleLineSpace(3.00)
                            .actionPrintText(
                                "${address}"
                            )
                    )
                    .actionPrintText(
                        "\nTEL:${telephone_number}\n" +
                        "登録番号:${registration_number}\n"
                    )
                    .styleAlignment(.left)
                    .actionPrintText(
                        "${datetime}\n" +
                        "レジ:${register_number%04d}" + "    担当:${staff_number%04d}\n" +
                        "人数:${number_of_people}名\n" +
                        "伝票名:${voucher_name}\n" +
                        "取引No:${transaction_number}\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "ご利用ありがとうございます\n"
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
                            "${item_list.name}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    16,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setWidthType(.full)
                                )
                        )
                        .actionPrintText(
                            "\\${item_list.unit_price}  ${item_list.number_of_items}点  \\${item_list.price}\n",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    32,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setAlignment(.right)
                                )
                        )
                    )
                    .actionPrintText(
                        "－－－－－－－－－－－－－－－－\n"
                    )
                    .actionPrintText(
                        "小計"
                    )
                    .actionPrintText(
                        "${total_number_of_items}点  \\${subtotal_price}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                28,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeed(2.0)
                    .actionPrintText(
                        "合計"
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "\\${total_price}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                28,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "(内消費税等"
                    )
                    .actionPrintText(
                        "\\${total_tax})\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                21,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "(10%標準対象"
                    )
                    .actionPrintText(
                        "\\${tax_rate_10_target})\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                20,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "( 内消費税等"
                    )
                    .actionPrintText(
                        "\\${tax_rate_10_tax})\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                20,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "("
                    )
                    .actionPrintText(
                        "${payment_method}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                10,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setWidthType(.full)
                            )
                    )
                    .actionPrintText(
                        "\\${payment_amount})\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                11,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "お預かり"
                    )
                    .actionPrintText(
                        "\\${deposit_amount}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "お釣り"
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "\\${change_amount}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                26,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .styleAlignment(.center)
                    .styleBold(false)
                    .actionFeed(2.0)
                    .actionPrintText(
                        "上記正に領収いたしました\n"
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.left)
                    .actionPrintText(
                        "${note}\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
