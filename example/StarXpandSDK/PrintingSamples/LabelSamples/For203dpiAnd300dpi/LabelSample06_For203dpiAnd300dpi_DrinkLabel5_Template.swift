//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample06_For203dpiAnd300dpi_DrinkLabel5_Template {
    static func createLabelTemplate() -> String {
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
                    .styleAlignment(.center)
                    .styleLineSpace(1.0)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleInvert(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${header}\n"
                            )
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${order_types}\n"
                            )
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "#${order_number%04d}\n"
                            )
                    )
                    .actionPrintText(
                        "${time}\n"
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleAlignment(.left)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1, height: 2))
                            .actionPrintText(
                                "${product_name}\n"
                            )
                            .add(
                                StarXpandCommand.PrinterBuilder(
                                    StarXpandCommand.Printer.PrinterParameter()
                                        .setTemplateExtension(
                                            StarXpandCommand.TemplateExtensionParameter()
                                                .setEnableArrayFieldData(true)
                                        )
                                )
                                    .styleHorizontalPositionTo(3.0)
                                    .actionPrintText(
                                        "${item_list.detail}\n"
                                    )
                            )
                    )
                    .actionPrintText(
                        "--------------------------------\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleInvert(true)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                            .actionPrintText(
                                "${footer}\n"
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
