//
//  Utility.swift
//  OneInChrist
//
//  Created by MAC on 09/20/18.
//  Copyright © 2017 Tapcrew. All rights reserved.
//


import UIKit
import SystemConfiguration
import AVFoundation

class Utility: NSObject {
    
    class func RGB(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    class func RGBA(red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    class func setBorder(view:UIView,corner:CGFloat,border:UIColor) {
        view.layer.cornerRadius = corner
        view.layer.borderWidth = 0.5
        view.layer.borderColor = border.cgColor
        view.layer.masksToBounds = true
    }
    
    class func setRoundBorder(view:UIView,border:UIColor) {
        view.layer.cornerRadius = view.frame.size.width / 2.0
        view.layer.borderWidth = 3.0
        view.layer.borderColor = border.cgColor
        view.layer.masksToBounds = true
    }
    
    class func documentPath() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    class func documentFilePath(file:String) -> String {
        return String(format:"%@/%@",Utility.documentPath(),file)
    }
    
    class func dateFromString(string:String,format:String) -> Date {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = format
        let timeZone = TimeZone.current
        
        let timeZoneSeconds:TimeInterval = Double(timeZone.secondsFromGMT())
        return formatter.date(from: string)!.addingTimeInterval(timeZoneSeconds)
    }
    
    class func dateFromString(string:String,format:String,timeZone:String) -> Date {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = format
        let timeZone = NSTimeZone(name: timeZone)
        let timeZoneSeconds:TimeInterval = Double((timeZone?.secondsFromGMT)!)
        return formatter.date(from: string)!.addingTimeInterval(timeZoneSeconds)
    }
    
    class func stringFromDate(date:Date,format:String) -> String {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date).lowercased()
    }
    
    class func showAlert(title:String,message:String) {
        let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
   
    
    class func dueTimeDiffrence(interval:TimeInterval) -> String{
        let calendar = NSCalendar.current
        var diffrence = ""
        if (interval == 0)  {
            return "Now"
        }
        
        let unitFlags = Set<Calendar.Component>([.hour,.minute])
        let date1 = Date()
        let date2 = Date().addingTimeInterval(interval)
        let components = calendar.dateComponents(unitFlags, from: date1 as Date, to: date2)
       
         if (components.hour! == 0 && components.minute == 0)  {
            diffrence = "Now"
         }
         else if (components.hour! > 0)  {
            if(components.hour == 1) {
                if(components.minute! >= 30) {
                    diffrence = String(format:"%ld.5 Hr",components.hour!)
                } else {
                    diffrence = String(format:"%ld Hr",components.hour!)
                }
            }
            else {
                if(components.minute! >= 30) {
                    diffrence = String(format:"%ld.5 Hrs",components.hour!)
                } else {
                    diffrence = String(format:"%ld Hrs",components.hour!)
                }
            }
        } else if (components.minute! > 0)  {
            if(components.minute == 1) {
                diffrence = String(format:"%ld Min",components.minute!)
            }
            else {
                diffrence = String(format:"%ld Mins",components.minute!)
            }
        }
        
        return diffrence
    }
    
    class func dateDiffrence(date:Date) -> String {
         let calendar = NSCalendar.current
         var diffrence = ""
        
        let unitFlags = Set<Calendar.Component>([.year,.month,.weekOfYear,.day,.hour,.minute])
        
        let components = calendar.dateComponents(unitFlags, from: date as Date, to: Date())
        
        if (components.year! > 0) {
            if(components.year == 1) {
                diffrence = String(format:"%ld %@",components.year!, "Year Ago")
            } else {
                diffrence = String(format:"%ld ",components.year!, "Years Ago")
            }
            
        } else if (components.month! > 0) {
            if(components.month == 1) {
                diffrence = String(format:"%ld %@",components.month!, "Month Ago")
            } else {
                diffrence = String(format:"%ld %@",components.month!, "Months Ago")
            }
            
        } else if (components.weekOfYear! > 0) {
            if(components.weekOfYear == 1) {
                let days = components.weekOfYear! * 7 + components.day!
                diffrence = String(format:"%ld %@",days , "Days Ago")
            }
            else {
                diffrence = String(format:"%ld %@",components.weekOfYear!, "Weeks Ago")
            }
            
        } else if (components.day! > 0) {
            if (components.day! > 1) {
                diffrence = String(format:"%ld %@",components.day!, "Days Ago")
                
            } else {
                diffrence = "Yesterday"
            }
        } else if (components.hour! > 0)  {
            if(components.hour == 1) {
                diffrence = String(format:"%ld %@",components.hour!, "Hour Ago")
            }
            else {
                diffrence = String(format:"%ld %@",components.hour!, "Hours Ago")
                
            }
        } else if (components.minute! > 0)  {
            if(components.minute == 1) {
                diffrence = String(format:"%ld %@",components.minute!, "Min Ago")
            }
            else {
                diffrence = String(format:"%ld %@",components.minute!, "Mins Ago")
            }
        } else {
            diffrence = "Just Now"
        }
        return diffrence
    }
    
    class func expireDateDiffrence(date:Date) -> String {
       
        if date < Date() {
            return "Expired"
        }
        
        let calendar = NSCalendar.current
        var diffrence = ""
        
        let unitFlags = Set<Calendar.Component>([.year,.month,.weekOfYear,.day,.hour,.minute])
        
        let components = calendar.dateComponents(unitFlags, from: Date(), to: date as Date)
        
        if (components.year! > 0) {
            if(components.year == 1) {
                diffrence = String(format:"%ld %@",components.year!, "Year")
            } else {
                diffrence = String(format:"%ld ",components.year!, "Years")
            }
            
        } else if (components.month! > 0) {
            if(components.month == 1) {
                diffrence = String(format:"%ld %@",components.month!, "Month")
            } else {
                diffrence = String(format:"%ld %@",components.month!, "Months")
            }
            
        } else if (components.weekOfYear! > 0) {
            if(components.weekOfYear == 1) {
                let days = components.weekOfYear! * 7 + components.day!
                diffrence = String(format:"%ld %@",days , "Days")
            }
            else {
                diffrence = String(format:"%ld %@",components.weekOfYear!, "Weeks")
            }
            
        } else if (components.day! > 0) {
            if (components.day! > 1) {
                diffrence = String(format:"%ld %@",components.day!, "Days")
                
            } else {
                diffrence = String(format:"%ld %@",components.day!, "Day")
            }
        } else if (components.hour! > 0)  {
            if(components.hour == 1) {
                diffrence = String(format:"%ld %@",components.hour!, "Hour")
            }
            else {
                diffrence = String(format:"%ld %@",components.hour!, "Hours")
                
            }
        } else if (components.minute! > 0)  {
            if(components.minute == 1) {
                diffrence = String(format:"%ld %@",components.minute!, "Min")
            }
            else {
                diffrence = String(format:"%ld %@",components.minute!, "Mins")
            }
        } else {
            diffrence = "Few  Mins"
        }
        
        return String(format:"Expires in %@",diffrence)
    }
    
    class func getRelativeFontForDevice(font:UIFont) -> UIFont {
        var pointSize = font.pointSize
        if(UIScreen.main.bounds.size.width == 320) { // iPhone5
            pointSize -= 2
        } else if(UIScreen.main.bounds.size.width == 375) { // iPhone6
            if(UIScreen.main.bounds.size.height > 667) {
                pointSize += 2
            }
        }
        else { // iPhone 6+
            pointSize += 2
        }
        return UIFont(name: font.fontName, size: pointSize)!
    }
    
//    class func getTextHeight(string:String,withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//
//      //  let style = NSMutableParagraphStyle()
//     //   style.lineBreakMode = .byWordWrapping
//
//        let boundingBox = string.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
//        return ceil(boundingBox.height)
//    }
    
//    class func getTextWidth(string:String,withConstrainedWidth height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        
//        let boundingBox = string.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
//        return ceil(boundingBox.width)
//    }
    
    class func thumbnailForVideoAtURL(url: NSURL) -> UIImage? {
        
        let asset = AVAsset(url: url as URL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("error")
            return nil
        }
    }
    
    class func durationForVideoAtURL(url: URL) ->  Float64{
        let asset = AVAsset(url: url)
        
        let duration = asset.duration
        let durationTime = CMTimeGetSeconds(duration)
        return durationTime
    }
    
//    class func createDefaultImage(name:String) -> UIImage {
//        let trimmedString = name.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        let view = UIView()
//        view.frame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 350.0)
//        view.backgroundColor = UIColor.lightGray
//        
//        let lbl = UILabel()
//        lbl.text = trimmedString.initials.uppercased()
//        lbl.backgroundColor = UIColor.clear
//        lbl.textColor = UIColor.white
//        lbl.frame = CGRect(x: 20.0, y: 30.0, width: 290.0, height: 290.0)
//        lbl.font = UIFont(name: "Avenir-Medium", size: 160.0)
//        lbl.textAlignment = .center
//        lbl.adjustsFontSizeToFitWidth = true
//        view.addSubview(lbl)
//        
//        UIGraphicsBeginImageContext(view.frame.size)
//        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }
    
}


// MARK: -UIImage

extension UIImage {
    
    func fixOrientation() -> UIImage {
        
        if ( self.imageOrientation == UIImageOrientation.up ) {
            return self;
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        if ( self.imageOrientation == UIImageOrientation.down || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }
        
        if ( self.imageOrientation == UIImageOrientation.left || self.imageOrientation == UIImageOrientation.leftMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }
        
        if ( self.imageOrientation == UIImageOrientation.right || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0));
        }
        
        if ( self.imageOrientation == UIImageOrientation.upMirrored || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }
        
        if ( self.imageOrientation == UIImageOrientation.leftMirrored || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!;
        
        ctx.concatenate(transform)
        
        if ( self.imageOrientation == UIImageOrientation.left ||
            self.imageOrientation == UIImageOrientation.leftMirrored ||
            self.imageOrientation == UIImageOrientation.right ||
            self.imageOrientation == UIImageOrientation.rightMirrored ) {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
        } else {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        return UIImage(cgImage: ctx.makeImage()!)
    }
}

// MARK: -UIImageView

extension UIImageView {
    
    /// Find the size of the image, once the parent imageView has been given a contentMode of .scaleAspectFit
    /// Querying the image.size returns the non-scaled size. This helper property is needed for accurate results.
    var aspectFitSize: CGSize {
        guard let image = image else { return CGSize.zero }
        
        var aspectFitSize = CGSize(width: frame.size.width, height: frame.size.height)
        let newWidth: CGFloat = frame.size.width / image.size.width
        let newHeight: CGFloat = frame.size.height / image.size.height
        
        if newHeight < newWidth {
            aspectFitSize.width = newHeight * image.size.width
        } else if newWidth < newHeight {
            aspectFitSize.height = newWidth * image.size.height
        }
        
        return aspectFitSize
    }
    
    /// Find the size of the image, once the parent imageView has been given a contentMode of .scaleAspectFill
    /// Querying the image.size returns the non-scaled, vastly too large size. This helper property is needed for accurate results.
    var aspectFillSize: CGSize {
        guard let image = image else { return CGSize.zero }
        
        var aspectFillSize = CGSize(width: frame.size.width, height: frame.size.height)
        let newWidth: CGFloat = frame.size.width / image.size.width
        let newHeight: CGFloat = frame.size.height / image.size.height
        
        if newHeight > newWidth {
            aspectFillSize.width = newHeight * image.size.width
        } else if newWidth > newHeight {
            aspectFillSize.height = newWidth * image.size.height
        }
        
        return aspectFillSize
    }
    
   
    
}
