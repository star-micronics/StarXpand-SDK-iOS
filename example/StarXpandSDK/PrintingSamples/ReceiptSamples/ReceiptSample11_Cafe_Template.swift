//
//  ReceiptSample11_Cafe_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample11_Cafe_Template {
    static func createReceiptTemplate() -> String {
        guard let logoImage = UIImage(named: "receipt_sample16_cafe_template_coffee_cup.png") else {
            print("Failed to load \"receipt_sample16_cafe_template_coffee_cup.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
                    .settingPrintableArea(48.0)
                    .addPrinter(
                        StarXpandCommand.PrinterBuilder()
                            .styleCJKCharacterPriority([.japanese])
                            .styleInternationalCharacter(.japan)
                            .addPageMode(
                                parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.0, height: 120.0),
                                builder: StarXpandCommand.PageModeBuilder()
                                    .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 48.0, height: 120.0)) // 外枠
                                    .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 5.0, y: 5.0, width: 16.0, height: 13.0)) // 収入印紙
                                    .stylePrintDirection(.topToBottom)
                                    .styleHorizontalPositionTo(7.0)
                                    .styleVerticalPositionTo(30.0)
                                    .actionPrintText(
                                        "収　入"
                                    )
                                    .styleHorizontalPositionTo(7.0)
                                    .styleVerticalPositionTo(37.0)
                                    .actionPrintText(
                                        "印　紙"
                                    )
                                    .styleHorizontalPositionTo(0.0)
                                    .styleVerticalPositionTo(5.0)
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .actionPrintText(
                                                "領　収　証",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        19, // 20文字入りますが、中心位置の都合上19としています。
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                            .setWidthType(.full)
                                                    )
                                            )
                                    )
                                    .styleHorizontalPositionTo(100.0)
                                    .styleVerticalPositionTo(3.0)
                                    .actionPrintText(
                                        "No.${number%04d}"
                                    )
                                    .styleHorizontalPositionTo(80.0)
                                    .styleVerticalPositionTo(6.0)
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 1))
                                            .actionPrintText(
                                                "${year%04d}"
                                            )
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                                            .actionPrintText(
                                                "年"
                                            )
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 1))
                                            .actionPrintText(
                                                "${month%02d}"
                                            )
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                                            .actionPrintText(
                                                "月"
                                            )
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 1))
                                            .actionPrintText(
                                                "${day%02d}"
                                            )
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                                            .actionPrintText(
                                                "日"
                                            )
                                    )
                                     .styleHorizontalPositionTo(4.0)
                                    .styleVerticalPositionTo(12.0)
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .actionPrintText(
                                                "${name}",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        7,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setWidthType(.full)
                                                    )
                                            )
                                            .actionPrintText(
                                                "様"
                                            )
                                            .actionPrintRuledLine(
                                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 4.0, yStart: 16.0, xEnd: 53.0, yEnd: 16.0)
                                                    .setThickness(0.2)
                                            )
                                    )
                                    .styleHorizontalPositionTo(76.0)
                                    .styleVerticalPositionTo(18.0)
                                    .actionPrintText(
                                        "但し "
                                    )
                                    .actionPrintText(
                                        "${description}",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                12,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setWidthType(.full)
                                            )
                                    )
                                    .styleHorizontalPositionTo(20.0)
                                    .styleVerticalPositionTo(20.0)
                                    .add(
                                        StarXpandCommand.PageModeBuilder()
                                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                                            .actionPrintText(
                                                "金${price}円",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        9,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.right)
                                                            .setWidthType(.full)
                                                    )
                                            )
                                            .actionPrintRuledLine(
                                                StarXpandCommand.Printer.PageModeRuledLineParameter(xStart: 20.0, yStart: 24.0, xEnd: 75.0, yEnd: 24.0)
                                                    .setThickness(0.2)
                                            )
                                    )
                                    .styleHorizontalPositionTo(24.0)
                                    .styleVerticalPositionTo(26.0)
                                    .actionPrintText(
                                        "上記正に領収いたしました"
                                    )
                                    .styleHorizontalPositionTo(24.0)
                                    .styleVerticalPositionBy(6.0)
                                    .actionPrintText(
                                        "(税抜金額"
                                    )
                                    .actionPrintText(
                                        "\\${excluding_tax})",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                15,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right
                                                    )
                                            )
                                    )
                                    .styleHorizontalPositionTo(24.0)
                                    .styleVerticalPositionBy(4.0)
                                    .actionPrintText(
                                        "(消費税等"
                                    )
                                    .actionPrintText(
                                        "\\${tax})",
                                        StarXpandCommand.Printer.TextParameter()
                                            .setWidth(
                                                15,
                                                StarXpandCommand.Printer.TextWidthParameter()
                                                    .setAlignment(.right)
                                            )
                                    )
                                    .actionPrintImage(StarXpandCommand.Printer.PageModeImageParameter(image: logoImage,x: 65.0,y: 27.0,width: 80 ))
                                    .addPageMode(
                                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 8.0, height: 30.0)
                                            .setX(11.0)
                                            .setY(76.0),
                                        builder: StarXpandCommand.PageModeBuilder()
                                            .styleHorizontalPositionTo(0.0)
                                            .actionPrintText(
                                                "${store_name}\n"
                                            )
                                    )
                                    .addPageMode(
                                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 10.0, height: 44.0)
                                            .setX(0.0)
                                            .setY(62.0),
                                        builder: StarXpandCommand.PageModeBuilder()
                                            .styleHorizontalPositionTo(0.0)
                                            .actionPrintText(
                                                "${address}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        29,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                            .actionPrintText(
                                                "TEL ${telephone_number}\n",
                                                StarXpandCommand.Printer.TextParameter()
                                                    .setWidth(
                                                        29,
                                                        StarXpandCommand.Printer.TextWidthParameter()
                                                            .setAlignment(.center)
                                                    )
                                            )
                                    )
                                    .styleHorizontalPositionTo(110.0)
                                    .styleVerticalPositionTo(35.0)
                                    .actionPrintText(
                                        "印"
                                    )
                            )
                            .actionCut(.partial)
                    )
                )
                
                return builder.getCommands()
            }
        }
