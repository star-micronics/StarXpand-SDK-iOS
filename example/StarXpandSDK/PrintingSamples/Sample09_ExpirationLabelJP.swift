//
//  Sample09_ExpirationLabelJP.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample09_ExpirationLabelJP {
    static func createExpirationLabelJP() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
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
                                "＜要冷蔵＞\n"
                            )
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.left)
                            .actionPrintText(
                                "10℃以下で保存し、本日中にお召し上がり下さい。\n" +
                                "　　消費期限\n"
                            )
                    )
                    .styleAlignment(.center)
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                    .actionPrintText(
                        "2010.1.25\n"
                    )
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 1))
                    .actionPrintText(
                        "スターショップ\n" +
                        "静岡　太郎\n" +
                        "XXX県XXX市XXX町123-1\n" +
                        "TEL 1234-567-890\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
