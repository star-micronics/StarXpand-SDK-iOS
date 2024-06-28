//
//  LabelSample18_ShelfLabelForInventory_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample18_ShelfLabelForInventory_Template {
    static func createShelfLabelForInventory() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    // モデルにより対応する文字エンコーディング指定APIが異なります。
                    // 下記ページのSupported Modelを参照し、ご利用のモデルが対応するAPIを使用してください。
                    // https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-xpand-command/printer-builder/style-cjk-character-priority.html
                    .styleCJKCharacterPriority([.japanese])
                    // https://star-m.jp/products/s_print/sdk/starxpand/manual/ja/ios-swift-api-reference/star-xpand-command/printer-builder/style-second-priority-character-encoding.html
                    //.styleSecondPriorityCharacterEncoding(.japanese)
                
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 36.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .styleVerticalPositionTo(6.0)
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                                    .actionPrintText(
                                        "${name}"
                                    )
                            )
                            .styleHorizontalPositionTo(0.0)
                            .styleVerticalPositionTo(15.0)
                            .actionPrintQRCode(
                                StarXpandCommand.Printer.QRCodeParameter(content: "${sku}")
                                    .setCellSize(4)
                                    .setLevel(.l)
                                    .setModel(.model2)
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 35.0, height: 24.0)
                                    .setX(13.0)
                                    .setY(12.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "${company}\n"
                                    )
                                    .actionPrintText(
                                        "${note}\n"
                                    )
                                    .actionPrintText(
                                        "使用材料名:${material}\n"
                                    )
                                    .actionPrintText(
                                        "金型取数:${mold_cavities}\n"
                                    )
                                    .actionPrintText(
                                        "整形場所:${molding_place}\n"
                                    )
                            )
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
