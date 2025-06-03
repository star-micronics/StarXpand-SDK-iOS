//
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample05_PharmacyStore1_Template {
    static func createReceiptTemplate() -> String {
        guard let logoImage = UIImage(named: "logo_01.png") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleLineSpace(3.0)
                    .actionPrintImage(
                        StarXpandCommand.Printer.ImageParameter(image: logoImage, width: 300)
                    )
                    .styleAlignment(.left)
                    .actionPrintText(
                        "I'm ${staff_name}, Thank you for allowing me to serve you today.\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "  270               10    9288   09136  027\n"
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.center)
                    .actionPrintText(
                        "RFN# ${rfn}\n"
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.left)
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                        )
                            .actionPrintText(
                                "${item_list.mark}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(2)
                            )
                            .actionPrintText(
                                "${item_list.name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(27)
                            )
                            .actionPrintText(
                                " "
                            )
                            .actionPrintText(
                                "${item_list.quantity}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        2,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                "${item_list.tax_mark}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(2)
                            )
                            .actionPrintText(
                                "${item_list.price%.2f}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        8,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                "${item_list.remarks}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(6)
                            )
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "   A=0.25% SALES TAX"
                    )
                    .actionPrintText(
                        "${sales_tax%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                22,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "     TOTAL"
                    )
                    .actionPrintText(
                        "${total_price%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                32,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "${payment_method}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                30,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.center)
                            )
                    )
                    .actionPrintText(
                        "${payment_amount%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                12,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "     CASH BACK"
                    )
                    .actionPrintText(
                        "${cash_back%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                28,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "  MAB ADVERTISED SAVINGS:"
                    )
                    .actionPrintText(
                        "${mab_serving%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                23,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "  MFG COUPON SAVINGS:"
                    )
                    .actionPrintText(
                        "${mfg_serving%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                27,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "-----\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                48,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "  YOUR TOTAL SAVINGS:"
                    )
                    .actionPrintText(
                        "${total_serving%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                27,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.center)
                    .actionPrintBarcode(
                        StarXpandCommand.Printer.BarcodeParameter(content: "${barcode}", symbology: .code128)
                            .setBarDots(1)
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.left)
                    .actionPrintText(
                        "${address}\n" +
                        "STORE\t${telephone_number}\n"
                    )
                    .actionFeedLine(2)
                    .actionPrintText(
                        "F=ELIGIBLE FLEX SPEND ACCT ITEM (FSA)\n"
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.center)
                    .actionPrintText(
                        "THANK YOU\n" +
                        "FOR FASTER SERVICE, CALL IN YOUR\n" +
                        "PRESCRIPTION ORDER OR PLACE IT ON\n" +
                        "${host_name} 24 HOURS IN ADVANCE\n"
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.left)
                    .actionPrintText(
                        "   ${date}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "${time}    \n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.center)
                    .actionPrintText(
                        "*********************************************** \n" +
                        "YOUR OPINION COUNTS!\n" +
                        "*********************************************** \n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "ENTER FOR A CHANCE TO WIN $10,000 CASH\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "PLEASE CALL TOLL FREE\n" +
                        "${free_call}\n" +
                        "CR LOGON TO\n" +
                        "${host_name}\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "WITHIN 72 HOURS TO COMPLETE A\n" +
                        "SHORT SURVEY ABOUT YOUR RECENT\n" +
                        "VISIT TO THIS STAR MICRONICS\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "PARTICIPE PARA GANAR\n" +
                        "$10,000 DOLARES IN EFECTIVO!\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "FOR FAVOR LLAME AL NUMERO GRATUITO\n" +
                        "${free_call} 0 VISITENOS EN\n" +
                        "INTERNET EN:\n" +
                        "${host_name}\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "DURANTE LAS PROXIMAS 72 HOURS, PARA\n" +
                        "LLENAR UNA EREVE ENCUESTA ACERCA DE\n" +
                        "SU RECIENTE VISITA A ESTA\n" +
                        "FARMACIA STAR MICRONICS.\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "SERVEY* ${survey_number}\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "SEE STORE FOR CONTEST RULES\n" +
                        "VISITE LA TIENDA PARA DETALLES ACERCA\n" +
                        "DE LOS REGLAS DEL CONCURSO.\n"
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.left)
                    .actionPrintText(
                        "STAR MICRONICS #${number}\n"
                    )
                    .actionPrintText(
                        "SEQ # ${seq_number}\n"
                    )
                    .actionPrintText(
                        "CARD# ${card_number}\n"
                    )
                    .actionPrintText(
                        "SEQ # ${seq_number}  PAYMENT FROM PRIMARY\n"
                    )
                    .actionFeedLine(2)
                    .actionPrintText(
                        "RETAIN THIS RECEIPT FOR YOUR RECORDS\n"
                    )
                    .actionFeedLine(2)
                    .actionPrintText(
                        "   ${date}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "${time}    \n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
