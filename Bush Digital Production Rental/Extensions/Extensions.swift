//
//  Extensions.swift
//  Preplsy
//
//  Created by Waqas Ali on 8/12/16.
//  Copyright © 2016 dinosoftlabs. All rights reserved.
//

import Foundation
import UIKit
//import CVCalendar

//extension NSError {
//    convenience init(errorMessage:String) {
//        self.init(domain: appDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
//    }
//}
extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
public extension UISearchBar {
    
    public func setTextColor(_ color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
extension Dictionary {
    
    init(_ pairs: [Element]) {
        self.init()
        for (k, v) in pairs {
            self[k] = v
        }
    }
    
    func mapPairs<OutKey: Hashable, OutValue>( transform: (Element) throws -> (OutKey, OutValue)) rethrows -> [OutKey: OutValue] {
        return Dictionary<OutKey, OutValue>(try map(transform))
    }
    
}
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}
extension UIImageView {
    func circulateImage(radius: CGFloat){
        self.layer.masksToBounds = false
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        
    }
}
public extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

    func isValidTextField() -> Bool {
        if self.text?.isEmpty == true {
            return false
        }
        return true
    }
}


extension UIImage {
//    public func urlToImage(urlString: String) -> UIImage{
//        
//        let url = NSURL(string: Variables.SERVER_IP + "/" + urlString)
//        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//        return  UIImage(data: data!)!
//        
//    }
//    
//    public func absoluteURL(ImageUrl: String) -> NSURL{
//        
//        let profileImageUrl = Variables.SERVER_IP + "/" + ImageUrl
//        
//        return NSURL(string: profileImageUrl)!
//        
//    }
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x:0, y:0, width:self.size.width, height:self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        color1.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    var rounded: UIImage? {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = min(size.height/2, size.width/2)
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleToFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
//    func compressImage(imageUrl:String)-> UIImage {
//        let imagenew:UIImage = UIImage().urlToImage(imageUrl)
//        return UIImage.compressImage(imagenew, compressRatio:0.9)
//    }
    
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.setFill()
        UIRectFill(CGRect(x:0, y:size.height, width:size.width,height:size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x:0, y:size.height - lineWidth, width:size.width, height:lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
extension String {
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    var png: Data? { return self.pngData() }
    
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
}

func RBSquareImageTo(_ image: UIImage, size: CGSize) -> UIImage? {
    return RBResizeImage(RBSquareImage(image), targetSize: size)
}

func RBSquareImage(_ image: UIImage) -> UIImage? {
    let originalWidth  = image.size.width
    let originalHeight = image.size.height
    
    var edge: CGFloat
    if originalWidth > originalHeight {
        edge = originalHeight
    } else {
        edge = originalWidth
    }
    
    let posX = (originalWidth  - edge) / 2.0
    let posY = (originalHeight - edge) / 2.0
    
    let cropSquare = CGRect(x: posX, y: posY, width: edge, height: edge)
    
    let imageRef = image.cgImage?.cropping(to: cropSquare);
    return UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
}

func RBResizeImage(_ image: UIImage?, targetSize: CGSize) -> UIImage? {
    if let image = image {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    } else {
        return nil
    }
}

extension String {
    
    func isValidEmail() -> Bool {
        do {
        let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            let range = NSMakeRange(0, self.count)
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:range) != nil
        } catch{return false}
    }

    
    func isEmail() -> Bool
    {
        let EMAIL_REGEX = "^([^@\\s]+)@((?:[-a-z0-9]+\\.)+[a-z]{2,})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        return predicate.evaluate(with: self)
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).uppercased()
        let other = String(self.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}

extension URL {
    
    func isEmpty(_ text:String?) -> Bool
    {
        if text == nil {return true}
        
        if text!.isEmpty == true {return true}
        
        //    if text?.lowercaseString == "null" {return true}
        
        return false
        
    }
    
    func isURLValid(_ urlString:String?) -> Bool
    {
        if isEmpty(urlString) {return false}
        
        let url =  URL(string: urlString!)
        if url == nil {return false}
        
        
        let request = URLRequest(url: url!)
        return NSURLConnection.canHandle(request)
        
    }
}

extension Date {
    //12:18 PM
    static func timeStringFromUnixTime(_ unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    static func dayStringFromTime(_ unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "dd-MMMM"
        return dateFormatter.string(from: date)
    }
    
    //2016-19-18 12:18 PM
    static func timeAndDateFromUnix(_ unixTime:Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "yyyy-dd-MM hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    static func yearFromUnixTime(_ unixTime:Double) -> Date {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "MM dd yyyy"
        let string = dateFormatter.string(from: date)
        return dateFormatter.date(from: string)!
    }
    
    static func yearStringFromUnixTime(_ unixTime:Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
//        return dateFormatter.dateFromString(string)!
    }
    
    static func dateFromStrings(_ stringDate:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = "hh:mm:ss a"
//        dateFormatter.dateStyle = .NoStyle
//        dateFormatter.timeStyle = .ShortStyle
        let date = dateFormatter.date(from: stringDate)
        return date!
    }
    
    static func dateFromStringConvertToString(_ stringDate: String) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat =  "hh:mm a"
        let  newTime =  dateFormatter.string(from: date!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.string(from: date!)
        return newDate + " " + newTime
    }
    
    static func dateFromStringConvertToStringInTuple(_ stringDate: String) -> (newDate:String,newTime:String)  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat =  "hh:mm a"
        let  newTime =  dateFormatter.string(from: date!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.string(from: date!)
        return (newDate,newTime)
    }
    
    static func checkDate(_ date: Date) -> String {
        var returnedDate = ""
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            returnedDate = "Today"
        } else if calendar.isDateInYesterday(date) {
            returnedDate = "Yesterday"
        } else {
            returnedDate = "None"
        }
        return returnedDate
    }
    
}


extension Calendar {
    
}

extension UIImageView {
}

extension Float {
    var round: String {
        return String(format: "%.1f", self)
    }
    var string2: String {
        return String(format: "%.2f", self)
    }
}


//
//extension Double {
//    /// Rounds the double to decimal places value
//    func roundToPlaces(places:Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return (self * 5).rounded() / 5
//    }
//}

//extension CVAuxiliaryView {
//    
//    public func drawShadow() {
//        self.layer.shadowRadius = 8.0
//        self.layer.shadowColor = UIColor(hexString: "#5B75D9").cgColor
//        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        self.layer.shouldRasterize = true
//        self.layer.shadowOpacity = 1.0
//        self.fillColor = UIColor(hexString: "#A2BAD9")
//    }
//    
//}

extension CGSize {
    
    func resizeFill(toSize: CGSize) -> CGSize {
        
        let scale : CGFloat = (self.height / self.width) < (toSize.height / toSize.width) ? (self.height / toSize.height) : (self.width / toSize.width)
        return CGSize(width: (self.width / scale), height: (self.height / scale))
        
    }
}
extension UINavigationController {
        func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        pushViewController(viewController, animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    func popViewController(animated: Bool, completion: @escaping () -> ()) {
        popViewController(animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
extension UINavigationBar {
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}
extension UIViewController {
    func resignAll(){
        self.view.endEditing(true)
        self.view.endEditing(false)
    }

    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func navTitle(titel: String) {
        self.navigationItem.title = titel
    }
    func addBackbutton(title: String) {
        if let nav = self.navigationController,
            let item = nav.navigationBar.topItem {
            item.backBarButtonItem  = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: self, action:
                #selector(self.backButtonAction))
        } else {
            if let nav = self.navigationController,
                let _ = nav.navigationBar.backItem {
                self.navigationController!.navigationBar.backItem!.title = title
            }
        }
    }
}
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}

