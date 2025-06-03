//
//  StarXpandSDK
//

import UIKit
import StarIO10

@MainActor class GraphicSample01_GraphicReceipt {
    static func createGraphicReceipt() -> String {
        guard let logo = UIImage(named: "logo_01") else {
            print("Failed to load \"logo_01.png\".")
            return ""
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .styleAlignment(.center)
                .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logo, width: 406))
                .actionPrintImage(Self.createImageParameterFromText(
                    "Star Clothing Boutique\n" +
                    "123 Star Road\n" +
                    "City, State 12345\n" +
                    "\n" +
                    "Date:MM/DD/YYYY  Time:HH:MM PM\n" +
                    "------------------------------\n" +
                    "\n" +
                    "SKU        Description   Total\n" +
                    "300678566  PLAIN T-SHIRT 10.99\n" +
                    "300692003  BLACK DENIM   29.99\n" +
                    "300651148  BLUE DENIM    29.99\n" +
                    "300642980  STRIPED DRESS 49.99\n" +
                    "300638471  BLACK BOOTS   35.99\n" +
                    "\n" +
                    "Subtotal                156.95\n" +
                    "Tax                       0.00\n" +
                    "------------------------------\n" +
                    "\n" +
                    "Total                  $156.95\n" +
                    "\n" +
                    "------------------------------\n" +
                    "\n" +
                    "Charge\n" +
                    "156.95\n" +
                    "Visa XXXX-XXXX-XXXX-0123\n" +
                    "\n"))

                        
                .actionCut(StarXpandCommand.Printer.CutType.partial)
            )
        )
        return builder.getCommands()
    }
    
    static func createImageParameterFromText(_ text: String) -> StarXpandCommand.Printer.ImageParameter{
        let width:Int = 384
        let font: UIFont = UIFont(name: "Menlo", size: 20)!
        let bitmap = createBitmapFromText(text,font:font,width:width)
        return StarXpandCommand.Printer.ImageParameter(image:bitmap, width:width)
    }
  
    
    static func createBitmapFromText(_ text: String, font: UIFont, width:Int) -> UIImage {
        let attributeDic: NSDictionary = NSDictionary(dictionary: [NSAttributedString.Key.font : font])
        let     widthCGF: CGFloat = CGFloat(width);
        let stringDrawingOptions: NSStringDrawingOptions = [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.truncatesLastVisibleLine]
        
        let size: CGSize = (text.boundingRect(with: CGSize(width: widthCGF, height: 10000), options: stringDrawingOptions, attributes: attributeDic as? [NSAttributedString.Key : Any], context: nil)).size
        
        if UIScreen.main.responds(to: #selector((any NSDecimalNumberBehaviors).scale)) {
            if UIScreen.main.scale == 2.0 {
                UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
            } else {
                UIGraphicsBeginImageContext(size)
            }
        } else {
            UIGraphicsBeginImageContext(size)
        }
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        UIColor.white.set()
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width + 1, height: size.height + 1)
        
        context.fill(rect)
        
        let attributes: NSDictionary = NSDictionary(dictionary: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : font])
        
        text.draw(in: rect, withAttributes: attributes as? [NSAttributedString.Key : Any])
        
        let imageToPrint: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return imageToPrint
    }
}
