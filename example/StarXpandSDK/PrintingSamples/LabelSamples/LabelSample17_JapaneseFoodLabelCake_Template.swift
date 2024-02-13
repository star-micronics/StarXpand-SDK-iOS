//
//  LabelSample17_JapaneseFoodLabelCake_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample17_JapaneseFoodLabelCake_Template {
    static func createJapaneseFoodLabelCake() -> String {
        guard let plasticImage = UIImage(named: "label_sample17_japanese_food_label_lunch_cake_plastic.png") else {
            print("Failed to load \"label_sample17_japanese_food_label_lunch_cake_plastic.png\".")
            return ""
        }
        
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
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 56.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 3.5, width: 40.0, height: 52.0)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 7.5, xEnd: 40.0, yEnd: 7.5)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 23.5, xEnd: 40.0, yEnd: 23.5)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 27.5, xEnd: 40.0, yEnd: 27.5)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 31.5, xEnd: 40.0, yEnd: 31.5)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 0.0, yStart: 43.5, xEnd: 40.0, yEnd: 43.5)
                            )
                            .actionPrintRuledLine(
                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 12.5, yStart: 3.5, xEnd: 12.5, yEnd: 55.5)
                            )
                            .styleHorizontalPositionTo(0.5)
                            .styleVerticalPositionTo(0.0)
                            .actionPrintText(
                                "品　名"
                            )
                            .styleHorizontalPositionTo(17.0)
                            .actionPrintText(
                                "${name}\n"
                            )
                            .styleHorizontalPositionTo(0.5)
                            .actionPrintText(
                                "名　称"
                            )
                            .styleHorizontalPositionTo(22.0)
                            .actionPrintText(
                                "${classification}\n"
                            )
                            .styleHorizontalPositionTo(0.5)
                            .actionPrintText(
                                "原材料名"
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 26.0, height: 16.0)
                                    .setX(13.0)
                                    .setY(8.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText("${ingredients}\n")
                            )
                            .styleHorizontalPositionTo(0.5)
                            .styleVerticalPositionTo(24.0)
                            .actionPrintText(
                                "内容量"
                            )
                            .styleHorizontalPositionTo(23.0)
                            .actionPrintText(
                                "${contents}\n"
                            )
                            .styleHorizontalPositionTo(0.5)
                            .actionPrintText(
                                "消費期限"
                            )
                            .styleHorizontalPositionTo(13.0)
                            .actionPrintText(
                                "${expiry_date}\n"
                            )
                            .styleHorizontalPositionTo(0.5)
                            .actionPrintText(
                                "保存方法"
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 26.0, height: 12.0)
                                    .setX(13.0)
                                    .setY(32.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "${preservation_method}"
                                    )
                            )
                            .styleHorizontalPositionTo(0.5)
                            .styleVerticalPositionTo(44.0)
                            .actionPrintText(
                                "製造者"
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 26.0, height: 12.0)
                                    .setX(13.0)
                                    .setY(44.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "${manufacturer}"
                                    )
                            )
                            .actionPrintImage(
                                StarXpandCommand.Printer.PageModeImageParameter(image: plasticImage, x: 41.0, y: 0.0, width: 48)
                            )
                            .stylePrintDirection(.bottomToTop)
                            .styleHorizontalPositionTo(6.0)
                            .styleVerticalPositionTo(42.0)
                            .actionPrintBarcode(
                                StarXpandCommand.Printer.BarcodeParameter(content: "${sku}", symbology: .jan13)
                                    .setBarDots(3)
                                    .setHeight(3.0)
                                    .setPrintHRI(true)
                            )
                        
                        
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
