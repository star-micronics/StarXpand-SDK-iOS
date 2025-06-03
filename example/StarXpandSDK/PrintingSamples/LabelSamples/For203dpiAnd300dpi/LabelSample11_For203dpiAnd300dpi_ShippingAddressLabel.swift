//
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample11_For203dpiAnd300dpi_ShippingAddressLabel {
    static func createShippingAddressLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                    .actionPrintText(
                        "FAO:John Smith\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "Star Clothing Boutique\n"
                            )
                    )
                    .actionPrintText(
                        "123 Star Road, City,\nState 12345\n"
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "U.S.A\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
