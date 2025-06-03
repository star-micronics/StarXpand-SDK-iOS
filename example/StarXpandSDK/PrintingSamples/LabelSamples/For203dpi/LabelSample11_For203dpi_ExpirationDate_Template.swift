//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample11_For203dpi_ExpirationDate_Template {
    static func createLabelTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .addPageMode(
                        parameter: StarXpandCommand.Printer.PageModeAreaParameter(width: 72.0, height: 35.0),
                        builder: StarXpandCommand.PageModeBuilder()
                            .actionPrintRectangle(StarXpandCommand.Printer.PageModeRectangleParameter(x: 0.0, y: 0.0, width: 72.0, height: 35.0))
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 3,height: 3))
                            .styleVerticalPositionTo(5.0)
                            .actionPrintText(
                                "Expiration Date:\n"
                            )
                            .styleHorizontalPositionTo(2.0)
                            .styleVerticalPositionBy(10.0)
                            .styleUnderLine(true)
                            .actionPrintText(
                                "${expiration_date}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        15,
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
