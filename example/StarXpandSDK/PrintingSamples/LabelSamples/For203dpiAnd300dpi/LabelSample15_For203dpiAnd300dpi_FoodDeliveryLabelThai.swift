//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample15_For203dpiAnd300dpi_FoodDeliveryLabelThai {
    static func createFoodDeliveryThaiLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleInternationalCharacter(.usa)
                    .styleCharacterSpace(0.0)
                    .styleAlignment(.center)
                    .styleBold(true)
                    .actionPrintText(
                        "สลิปการสั่งซื้อ\n"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "ร้าน STAR EAT  \n" +
                        "Bangkok , Thailand \n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "#0001\n"
                            )
                    )
                    .actionPrintText(
                        "วันที่:ดด/วว/ปปปป  เวลา:HH:MM PM\n" +
                        "--------------------------------\n"
                    )
                    .styleAlignment(.left)
                    .actionPrintText(
                        "ลูกค้า: "
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "Mr. Star Micronics \n"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "ชำระเงินแล้ว \n" +
                        "เวลาที่รับออเดอร์:HH:MM PM\n" +
                        "--------------------------------\n" +
                        "\n"
                    )
                    .actionPrintText(
                        "1X ข้าวผัดปู           59 บาท \n" +
                        "1X ต้มยำกุ้ง          120 บาท  \n" +
                        "2X ก๋วยเตี๋ยวหมูน้ำตก    69 บาท \n" +
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.center)
                            .actionPrintText(
                                "**โปรดเตรียมช้อนส้อมให้ด้วย\n"
                            )
                    )
                    .actionPrintText(
                        "--------------------------------\n" +
                        "รวม                       "
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "248"
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "บาท\n" +
                        "ภาษีมูลค่าเพิ่ม                - \n" +
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
                            .actionPrintText("248 บาท\n")
                    )
                    .actionPrintText(
                        "--------------------------------\n" +
                        "\n" +
                        "Charge " +
                        "Visa XXXX-XXXX-XXXX-0123\n" +
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
                        StarXpandCommand.Printer.QRCodeParameter(content: "https://starmicronics.co.th/en/contact/\n")
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
