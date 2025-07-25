//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample19_For203dpiAnd300dpi_PrescriptionLabel_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            // Change the printable area setting for this layout according to the printer resolution.
            // 72.0 for 203dpi, 48.7 for 300dpi
            .settingPrintableArea(72.0)
            //.settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .actionPrintText(
                        "${contents}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 2))
                            .actionPrintText(
                                "Take "
                            )
                            .styleBold(true)
                            .actionPrintText(
                                "${number_of_tablet}"
                            )
                            .styleBold(false)
                            .actionPrintText(
                                " tablet "
                            )
                            .styleBold(true)
                            .actionPrintText(
                                "${number_of_times}"
                            )
                            .styleBold(false)
                            .actionPrintText(
                                " times ${dose_interval}"
                            )
                    )
                    .actionFeed(7.0)
                    .styleBold(true)
                    .actionPrintText(
                        "Warning "
                    )
                    .styleBold(false)
                    .actionPrintText(
                        "${warning1}\n" +
                                "${warning2}\n" +
                                "${warning3}\n"
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "${name}"
                    )
                    .styleBold(false)
                    .styleHorizontalPositionTo(0.0)
                    .actionPrintText(
                        "${date}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                42,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionPrintRuledLine(
                        StarXpandCommand.Printer.RuledLineParameter(width: 72.0)
                            .setThickness(0.4)
                    )
                    .styleLineSpace(3.0)
                    .actionPrintText(
                        "For Advice ${for_advice}\n" +
                                "Keep out of sight and reach of children\n" +
                                "${address}\n"
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
