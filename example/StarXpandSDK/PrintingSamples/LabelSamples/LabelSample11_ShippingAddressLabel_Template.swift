//
//  LabelSample11_ShippingAddressLabel_Template.swift
//  StarXpandSDK
//

import UIKit
import StarIO10

class LabelSample11_ShippingAddressLabel_Template {
    static func createShippingAddressLabel() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2))
                    .actionPrintText(
                        "${name}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleBold(true)
                            .actionPrintText(
                                "${company}\n"
                            )
                    )
                    .actionPrintText(
                        "${address}\n"
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "${country}\n"
                    )
                    .actionCut(.partial)
            )
        )
        
        return builder.getCommands()
    }
}
