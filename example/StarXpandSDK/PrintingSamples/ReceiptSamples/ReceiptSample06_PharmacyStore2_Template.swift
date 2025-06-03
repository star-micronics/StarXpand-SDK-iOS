//
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample06_PharmacyStore2_Template {
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
                    .actionPrintText(
                        "${address}\n" +
                        "${telephone_number}"
                    )
                    .styleAlignment(.left)
                    .actionFeedLine(1)
                    .actionPrintText(
                        "208            7820   0021"
                    )
                    .styleHorizontalPositionTo(0.0)
                    .actionPrintText(
                        "${datetime}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                48,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.center)
                    .styleBold(true)
                    .actionPrintText(
                        "<< BUY 1 GET 1 EQUAL/LESS VALUE 50% OFF >>\n"
                    )
                    .styleAlignment(.left)
                    .styleBold(false)
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                        )
                            .actionPrintText(
                                "${item_list1.name}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(48)
                            )
                            .actionPrintText(
                                "    ${item_list1.product_number}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(30)
                            )
                            .actionPrintText(
                                " "
                            )
                            .actionPrintText(
                                "${item_list1.tax_mark}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .actionPrintText(
                                "${item_list1.price%.2f}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        10,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                " ${item_list1.remarks}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(6)
                            )
                            .actionPrintText(
                                "${item_list1.detail1}" +
                                "${item_list1.detail2}" +
                                "${item_list1.detail3}"
                            )
                    )
                    .actionPrintText(
                        "************************************************\n"
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
                                "${item_list2.name}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(48)
                            )
                            .actionPrintText(
                                "    ${item_list2.product_number}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(30)
                            )
                            .actionPrintText(
                                " "
                            )
                            .actionPrintText(
                                "${item_list2.tax_mark}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(1)
                            )
                            .actionPrintText(
                                "${item_list2.price%.2f}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        10,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right)
                                    )
                            )
                            .actionPrintText(
                                " ${item_list2.remarks}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(6)
                            )
                            .actionPrintText(
                                "${item_list2.detail1}" +
                                "${item_list2.detail2}" +
                                "${item_list2.detail3}" +
                                "${item_list2.detail4}"
                            )
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "    SUBTOTAL"
                    )
                    .actionPrintText(
                        "${subtotal%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                30,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "    SALES TAX A=6.75%"
                    )
                    .actionPrintText(
                        "${sales_tax%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                21,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "    TOTAL"
                    )
                    .actionPrintText(
                        "${total_price%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                33,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "    ${payment_method}",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(24)
                    )
                    .actionPrintText(
                        "${payment_amount%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                18,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "    CHANGE"
                    )
                    .actionPrintText(
                        "${change%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                32,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(3)
                    .actionPrintText(
                        "MYSTAR SAVINGS"
                    )
                    .actionPrintText(
                        "${my_serving%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                28,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintText(
                        "MFG COUPON SAVINGS"
                    )
                    .actionPrintText(
                        "${mfg_serving%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "THANK YOU FOR SHOPPING AT STAR SHOP\n"
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "${note}\n"
                    )
                    .actionFeedLine(1)
                    .styleAlignment(.center)
                    .actionPrintText(
                        "RFN# ${rfn}\n"
                    )
                    .actionPrintBarcode(
                        StarXpandCommand.Printer.BarcodeParameter(content: "${barcode}", symbology: .code128)
                            .setBarDots(1)
                    )
                    .actionFeedLine(1)
                    .actionPrintText(
                        "************************************************\n"
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
