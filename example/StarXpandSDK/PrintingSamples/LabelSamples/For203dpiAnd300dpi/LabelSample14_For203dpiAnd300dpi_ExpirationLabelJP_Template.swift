//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample14_For203dpiAnd300dpi_ExpirationLabelJP_Template {
    static func createExpirationLabelJP() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 48.0 for 203dpi, 34.0 for 300dpi
            .settingPrintableArea(48.0)
            //.settingPrintableArea(34.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    // モデルにより対応する文字エンコーディング指定APIが異なります。
                    // 下記ページのSupported Modelを参照し、ご利用のモデルが対応するAPIを使用してください。
                    // https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-xpand-command/printer-builder/style-cjk-character-priority.html
                    .styleCJKCharacterPriority([.japanese])
                    // https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-xpand-command/printer-builder/style-second-priority-character-encoding.html
                    //.styleSecondPriorityCharacterEncoding(.japanese)

                    .styleAlignment(.center)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${remarks}\n"
                            )
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.left)
                            .actionPrintText(
                                "${note}\n" +
                                "　　消費期限\n"
                            )
                    )
                    .styleAlignment(.center)
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                    .actionPrintText(
                        "${expiry_date}\n"
                    )
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 1))
                    .actionPrintText(
                        "${shop_name}\n" +
                        "${address}\n" +
                        "TEL ${telephone_number}\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
