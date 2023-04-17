//
//  Sample12_JapaneseFoodLabelLunchBox.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class Sample12_JapaneseFoodLabelLunchBox {
    static func createJapaneseFoodLabelLunchBox() -> String {
        guard let plasticImage = UIImage(named: "sample12_japanese_food_label_lunch_box_plastic.png") else {
            print("Failed to load \"sample12_japanese_food_label_lunch_box_plastic.png\".")
            return ""
        }
        
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

                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 72.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 48.0, height: 72.0)
                                    .setRoundCorner(true)
                                    .setCornerRadius(2.0)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 1.0, yStart: 10.0, xEnd: 47.0, yEnd: 10.0)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 1.0, yStart: 27.0, xEnd: 47.0, yEnd: 27.0)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 1.0, yStart: 44.0, xEnd: 47.0, yEnd: 44.0)
                            )
                            .styleHorizontalPositionTo(0.0)
                            .styleVerticalPositionTo(0.0)
                            .actionPrintText(
                                "\n"
                            )
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                                    .actionPrintText(
                                        " 唐 揚 げ 弁 当 "
                                    )
                            )
                            .styleHorizontalPositionTo(1.0)
                            .styleVerticalPositionBy(8.0)
                            .actionPrintText(
                                "消費期限 12. 9. 8   22時\n"
                            )
                            .styleHorizontalPositionBy(2.0)
                            .styleVerticalPositionBy(3.0)
                            .actionPrintBarcode(
                                StarXpandCommand.Printer.BarcodeParameter(content: "2100100114008", symbology: .jan13)
                                    .setBarDots(2)
                                    .setHeight(5.0)
                                    .setPrintHRI(true)
                            )
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(38.0)
                                    .styleVerticalPositionTo(18.0)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                                    .actionPrintText(
                                        "400"
                                    )
                            )
                            .styleHorizontalPositionTo(32.0)
                            .styleVerticalPositionTo(23.0)
                            .actionPrintText(
                                "お値段(円)"
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 20.0)
                                    .setX(1.0)
                                    .setY(28.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "原材料名：ご飯(国内産)、鶏肉、おかず、調味料(アミノ酸等)、着色料(赤102、106、黄4)、(原材料の一部に小麦、大豆を含む)\n"
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 28.0)
                                    .setX(1.0)
                                    .setY(46.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "保存方法：直射日光・高温多湿を\n" +
                                        "　　　　　避けお早めにお召上が\n" +
                                        "　　　　　りください。\n" +
                                        "製造者：スターショップ\n" +
                                        "XXX県XXX市XXX町123-1\n" +
                                        "TEL 1234-567-890\n"
                                    )
                            )
                            .actionPrintImage(
                                StarXpandCommand.Printer.PageModeImageParameter(image: plasticImage, x: 40.0, y: 63.0, width: 48)
                            )
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
