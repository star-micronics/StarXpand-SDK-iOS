//
//  StarXpandSDK
//

import UIKit
import StarIO10

class ReceiptSample03_FoodDelivery1_Template {
    static func createReceiptTemplate() -> String {
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .settingPrintableArea(72.0)
            .addPrinter(
                StarXpandCommand.PrinterBuilder()
                    .styleAlignment(.center)
                    .styleBold(true)
                    .styleMagnification(StarXpandCommand.MagnificationParameter(width: 2,height: 2))
                    .actionPrintText(
                        "${store_name}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                24,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.center)
                            )
                    )
                    .styleAlignment(.left)
                    .styleBold(false)
                    .actionPrintText(
                        "------------------------"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                            .actionPrintText(
                                "Customer Name\n"
                            )
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "${customer_name}\n"
                    )
                    .styleBold(false)
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                            .actionPrintText(
                                "Delivery\n"
                            )
                    )
                    .actionPrintText(
                        "${staff_name}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                            .actionPrintText(
                                "Delivery Pickup Time\n"
                            )
                    )
                    .actionPrintText(
                        "${pickup_time}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                            .actionPrintText(
                                "Order Number\n"
                            )
                    )
                    .actionPrintText(
                        "${order_number}\n"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder()
                            .styleMagnification(StarXpandCommand.MagnificationParameter(width: 1,height: 1))
                            .actionPrintText(
                                "Total Items\n"
                            )
                    )
                    .actionPrintText(
                        "${total_items} items\n"
                    )
                    .actionPrintText(
                        "------------------------"
                    )
                    .add(
                        StarXpandCommand.PrinterBuilder(
                            StarXpandCommand.Printer.PrinterParameter()
                                .setTemplateExtension(
                                    StarXpandCommand.TemplateExtensionParameter()
                                        .setEnableArrayFieldData(true)
                                )
                        )
                            .actionPrintText(
                                "${item_list.quantity}x${item_list.name}",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(18)
                            )
                            .actionPrintText(
                                " "
                            )
                            .actionPrintText(
                                "$${item_list.price%.2f}\n",
                                StarXpandCommand.Printer.TextParameter()
                                    .setWidth(
                                        5,
                                        StarXpandCommand.Printer.TextWidthParameter()
                                            .setAlignment(.right))
                            )
                            .actionPrintText(
                                "${item_list.detail}"
                            )
                            .actionPrintText(
                                "------------------------\n"
                            )
                    )
                    .actionPrintText(
                        "${total_items} totalitems\n"
                    )
                    .actionPrintText(
                        "Subtotal"
                    )
                    .actionPrintText(
                        "$${subtotal%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                16,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .styleBold(true)
                    .actionPrintText(
                        "Total"
                    )
                    .actionPrintText(
                        "$${total%.2f}\n",
                        StarXpandCommand.Printer.TextParameter()
                            .setWidth(
                                19,
                                StarXpandCommand.Printer.TextWidthParameter()
                                    .setAlignment(.right)
                            )
                    )
                    .actionCut(.partial)
            )
        )
        return builder.getCommands()
    }
}
