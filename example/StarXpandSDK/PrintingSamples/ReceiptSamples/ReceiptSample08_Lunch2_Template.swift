//
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample08_Lunch2_Template {
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
                            .styleAlignment(.right)
                            .actionPrintText(
                                "${number}\n" +
                                        "会計日:${account_day}\n"
                            )
                            .actionFeed(3.0)
                            .styleAlignment(.left)
                            .add(
                                StarXpandCommand.PrinterBuilder()
                                    .styleAlignment(.center)
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .actionPrintText(
                                        "領 収 書\n"
                                    )
                            )
                            .actionFeed(3.0)
                            .styleUnderLine(true)
                            .actionPrintText(
                                "${customer_name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        15,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setWidthType(.full)
                                    )
                            )
                            .actionPrintText(
                                "様\n"
                            )
                            .styleUnderLine(false)
                            .actionFeedLine(2)
                            .actionPrintText(
                                "領収金額\n"
                            )
                            .actionPrintText(
                                "        "
                            )
                            .styleBold(true)
                            .styleUnderLine(true)
                            .actionPrintText(
                                "\\${total_price}-\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        24,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .styleBold(false)
                            .styleUnderLine(false)
                            .actionPrintText(
                                "     (10%標準対象"
                            )
                            .actionPrintText(
                                "\\${tax_rate_10_target})\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        15,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                "     ( 内消費税等"
                            )
                            .actionPrintText(
                                "\\${tax_rate_10_tax})\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        15,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .styleAlignment(.center)
                            .actionFeedLine(1)
                            .actionPrintText(
                                "上記正に領収いたしました\n"
                            )
                            .actionFeedLine(2)
                            .styleAlignment(.left)
                            .styleUnderLine(true)
                            .actionPrintText(
                                "但 "
                            )
                            .actionPrintText(
                                "${description}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        11,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setWidthType(.full)
                                    )
                            )
                            .actionPrintText(
                                " として"
                            )
                            .actionFeedLine(3)
                            .styleUnderLine(false)
                            .add(
                                StarXpandCommand.PrinterBuilder()
                                    .styleBold(true)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                    .actionPrintText(
                                        "${store_name}\n"
                                    )
                            )
                            .actionPrintText(
                                "${address}\n" +
                                        "TEL:${telephone_number}\n" +
                                        "登録番号:${registration_number}\n" +
                                        "\n" +
                                        "担当者:${staff_name}\n" +
                                        "領収書No:\n" +
                                        "${receipt_number}\n"
                            )
                            .actionCut(.partial)
                    )
                )
                
                return builder.getCommands()
            }
        }
