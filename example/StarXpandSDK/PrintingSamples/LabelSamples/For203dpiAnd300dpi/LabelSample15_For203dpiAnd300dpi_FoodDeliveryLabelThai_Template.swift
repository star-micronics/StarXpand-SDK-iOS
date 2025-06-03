//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample15_For203dpiAnd300dpi_FoodDeliveryLabelThai_Template {
    static func createFoodDeliveryThaiLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 48.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(48.0)
            //.settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    // By setting the base print size of text to x1.5 for 300dpi,
                    // you can print text at the same size as 203dpi.
                    //.styleBaseMagnification(StarXpandCommand.Printer.BaseMagnificationParameter().setText(.x1_5))
                    .styleInternationalCharacter(.usa)
                    .styleCharacterSpace(0.0)
                    .styleAlignment(.center)
                    .styleBold(true)
                    .actionPrintText(
                        "สลิปการสั่งซื้อ\n"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "${store_name}  \n" +
                        "${address} \n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "#${number%04u}\n"
                            )
                    )
                    .actionPrintText(
                        "วันที่:${date}  เวลา:${time}\n" +
                        "--------------------------------\n"
                    )
                    .styleAlignment(.left)
                    .actionPrintText(
                        "ลูกค้า: "
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "${customer_name} \n"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "ชำระเงินแล้ว \n" +
                        "เวลาที่รับออเดอร์:${order_time}\n" +
                        "--------------------------------\n" +
                        "\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                            )
                        .styleHorizontalTabPositions([3, 18, 23])
                        .actionPrintText(
                            "${item_list.number_of_items}X\t${item_list.name}\t"
                        )
                        .actionPrintText(
                            "${item_list.price}",
                            StarXpandCommand.Printer.TextParameter()
                                .setWidth(
                                    4,
                                    StarXpandCommand.Printer.TextWidthParameter()
                                        .setAlignment(.right)
                                )
                        )
                        .actionPrintText(
                            "\tบาท\n"
                        )
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.center)
                            .actionPrintText(
                                "${note}\n"
                            )
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleHorizontalTabPositions([26])
                            .actionPrintText(
                                "รวม\t"
                            )
                            .styleBold(true)
                            .actionPrintText(
                                "${sub_total}"
                            )
                            .styleBold(false)
                            .actionPrintText(
                                "บาท\n"
                            )
                            .actionPrintText(
                                "ภาษีมูลค่าเพิ่ม\t"
                            )
                            .actionPrintText(
                                "${tax}\n"
                            )
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.left)
                            .styleBold(true)
                            .actionPrintText(
                                "รวมทั้งหมด\n"
                            )
                            .styleAlignment(.right)
                            .actionPrintText("${total} บาท\n")
                    )
                    .actionPrintText(
                        "--------------------------------\n" +
                        "\n" +
                        "Charge ${charge}\n" +
                        "\n")
                    .styleAlignment(.center)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleInvert(true)
                            .actionPrintText(
                                "การขอใบกำกับภาษี\n"
                            )
                    )
                    .actionPrintText(
                        "นี่ไม่ใช่ใบเสร็จรับเงินอย่างเป็นทางการ\n" +
                        "และไม่สามารถใช้ในการคืนภาษีได้\n" +
                        "โปรดขอใบกำกับภาษีอย่างเป็นทางการจากผู้ขาย\n" +
                        "\n")
                    .actionFeedLine(1)
                    .actionPrintQRCode(
                        StarXpandCommand.Printer.QRCodeParameter(content: "${store_url}")
                            .setModel(.model2)
                            .setLevel(.l)
                            .setCellSize(8)
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
