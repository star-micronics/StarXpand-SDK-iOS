//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample04_For300dpi_Sale50PercentOff_Template {
    static func createLabelTemplate() -> String {
        guard let backgroundImage = UIImage(named: "sale_50off_background.png") else {
            print("Failed to load \"sale_50off_background.png\".")
            return ""
        }
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(48.7)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 48.7, height: 46.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintImage(StarXpandCommand.Printer.PageModeImageParameter(image: backgroundImage, x: 0.0, y: 0.0, width: 576))
                            .styleHorizontalPositionTo(4.0)
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 4,height: 4))
                            .styleVerticalPositionTo(27.0)
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
