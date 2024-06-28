//
//  LabelSample25_OrderLabel_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample25_OrderLabel_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleCJKCharacterPriority([.japanese])
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 60.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 2.0, y: 12.0, width: 40.0, height: 10.0)
                                    .setThickness(0.5)
                            ) // 注文番号
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 44.0, y: 12.0, width: 26.0, height: 10.0)
                                    .setThickness(0.5)
                            ) // 個数
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 2.0, y: 28.0, width: 20.0, height: 10.0)
                                    .setThickness(0.5)
                            ) // 常温
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 26.0, y: 28.0, width: 20.0, height: 10.0)
                                    .setThickness(0.5)
                            ) // 冷蔵
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 50.0, y: 28.0, width: 20.0, height: 10.0)
                                    .setThickness(0.5)
                            ) // 冷凍
                            .actionPrintRectangle(
                                StarXpandCommand.Printer.PageModeRectangleParameter(x: 2.0, y: 44.0, width: 68.0, height: 15.0)
                                    .setThickness(0.5)
                            ) // 備考欄
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 4.0)
                                    .setY(2.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(12.0)
                                    .styleUnderLine(true)
                                    .actionPrintText(
                                        "剥がさずにそのまま配達して下さい\n"
                                    )
                            )
                            .styleHorizontalPositionTo(16.0)
                            .styleVerticalPositionTo(8.0)
                            .actionPrintText(
                                "注文番号"
                            )
                            .styleHorizontalPositionTo(54.0)
                            .actionPrintText(
                                "個数"
                            )
                            .styleHorizontalPositionTo(45.0)
                            .styleVerticalPositionBy(8.0)
                            .actionPrintText(
                                "合計"
                            )
                            .styleHorizontalPositionBy(15.0)
                            .actionPrintText(
                                "袋"
                            )
                            .styleHorizontalPositionTo(9.0)
                            .styleVerticalPositionBy(8.0)
                            .actionPrintText(
                                "常温"
                            )
                            .styleHorizontalPositionBy(18.0)
                            .actionPrintText(
                                "冷蔵"
                            )
                            .styleHorizontalPositionBy(18.0)
                            .actionPrintText(
                                "冷凍"
                            )
                            .styleHorizontalPositionTo(18.0)
                            .styleVerticalPositionBy(8.0)
                            .actionPrintText(
                                "袋"
                            )
                            .styleHorizontalPositionBy(21.0)
                            .actionPrintText(
                                "袋"
                            )
                            .styleHorizontalPositionBy(21.0)
                            .actionPrintText(
                                "袋"
                            )
                            .styleHorizontalPositionTo(4.0)
                            .styleVerticalPositionBy(8.0)
                            .actionPrintText(
                                "備考欄${remarks}"
                            )
                            .add(
                                StarXpandCommand.PageModeBuilder()
                                    .styleHorizontalPositionTo(4.0)
                                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 2))
                                    .styleVerticalPositionTo(17.0)
                                    .actionPrintText(
                                        "${order_number}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                24,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setPrintType(.always)
                                            )
                                    )
                                    .styleHorizontalPositionBy(12.0)
                                    .actionPrintText(
                                        "${total_quantity}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                9,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                                    .setPrintType(.always)
                                            )
                                    )
                                    .styleHorizontalPositionTo(4.0)
                                    .styleVerticalPositionBy(16.0)
                                    .actionPrintText(
                                        "${room_temperature}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                9,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                                    .setPrintType(.always)
                                            )
                                    )
                                    .styleHorizontalPositionBy(10.0)
                                    .actionPrintText(
                                        "${refrigeration}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                9,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                                    .setPrintType(.always)
                                            )
                                    )
                                    .styleHorizontalPositionBy(11.0)
                                    .actionPrintText(
                                        "${frozen}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                9,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                                    .setPrintType(.always)
                                            )
                                    )
                            )
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 64.0, height: 12.0)
                                    .setX(4.0)
                                    .setY(46.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintText(
                                        "${note}"
                                    )
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
