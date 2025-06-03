//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample13_For203dpi_Sale50PercentOff_Template {
    static func createLabelTemplate() -> String {
        guard let backgroundImage = UIImage(named: "sale_50off_background.png") else {
            print("Failed to load \"sale_50off_background.png\".")
            return ""
        }
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 68.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintImage(StarXpandCommand.Printer.PageModeImageParameter(image: backgroundImage, x: 0.0, y: 0.0, width: 590))
                            .styleHorizontalPositionTo(7.0)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 4,height: 4))
                            .styleVerticalPositionTo(42.0)
                            .actionPrintText(
                                "${note}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        10,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.center)
                                    )
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
