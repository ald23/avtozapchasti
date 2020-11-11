
import Foundation
import UIKit

//MARK: - UIFont
extension UIFont {
    static func getMontserratBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size)!
    }
    static func getMontserratRegular(of size: CGFloat) -> UIFont {
         return UIFont(name: "Montserrat-Medium", size: size)!
    }
    static func getMontserratMedium(of size: CGFloat) -> UIFont {
         return UIFont(name: "Montserrat-Medium", size: size)!
    }
}

//MARK: - UIView
extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func removeLayer(layerName: String) {
        for item in self.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }
   
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    public func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    

}


extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}
//MARK: - CALayer

extension CALayer {

  func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

    let border = CALayer()

    switch edge {
    case UIRectEdge.top:
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)

    case UIRectEdge.bottom:
        border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height:thickness)

    case UIRectEdge.left:
        border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)

    case UIRectEdge.right:
        border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)

    default: do {}
    }

    border.backgroundColor = color.cgColor

    addSublayer(border)
 }
}

//MARK: - CAGradientLayer
extension CAGradientLayer {
    static func setGradientBackground(reversed: Bool = false) -> CAGradientLayer {
        let colorTop =  UIColor(red: 0.094, green: 0.157, blue: 0.282, alpha: 1).cgColor
        let colorBottom =   UIColor(red: 0.294, green: 0.424, blue: 0.718, alpha: 1).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        
        if !reversed{
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        else {
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
        }
        
        return gradientLayer
    }
}
//MARK: - UIColor
extension UIColor {
    static let boldTextColor = #colorLiteral(red: 0.1607843137, green: 0.2431372549, blue: 0.4235294118, alpha: 1)
    static let grayForText = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
    static let medium = #colorLiteral(red: 0.09411764706, green: 0.1568627451, blue: 0.2823529412, alpha: 1)
}

//MARK: - UIVIewController
extension UIViewController {
    
    func addSubview(_ view: UIView) -> Void {
        self.view.addSubview(view)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func inNavigation() -> UIViewController {
        return UINavigationController(rootViewController: self)
    }
    
    func showDissmissAlert(title: String, message: String, completion: @escaping (()->())) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let yesAction = UIAlertAction(title: "Ок", style: .cancel) { (action) in
            completion()
        }
        
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }


    func showAlertWithAction(title: String, message: String, completion: @escaping (()->())) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        let yesAction = UIAlertAction(title: "Да", style: .default) { (action) in
            completion()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showErrorAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }


}



//MARK:- UITableViewCell
extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

//MARK:- UICollectionViewCell
extension UICollectionViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
//MARK: - Double

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


//MARK: - String

extension String {

    
    
    var url: URL {
        return URL(string: self)!
    }
    
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        return (self as NSString).substring(with: result.range)
    }

    func estimatedFrame(for font: UIFont) -> CGRect {
        print(self)
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: self).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        print(estimatedFrame)
        
        return estimatedFrame
    }
      func localized() -> String {
        var language = String()

        language = UserDefaults.standard.string(forKey: Key.language) ?? "ru"

        if let url = Bundle.main.url(forResource: "\(language)", withExtension: "strings"), let stringDict = NSDictionary(contentsOf: url) as? [String: String], let localizedString = stringDict[self] {
            return localizedString
        }

        return self
    }
    

}
//MARK: - UIColor
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

////MARK: - UIImagePickerController
//public protocol ImagePickerDelegate: class {
//    func didSelect(image: UIImage?)
//}
//
//open class ImagePicker: NSObject {
//
//    private let pickerController: UIImagePickerController
//    private weak var presentationController: UIViewController?
//    private weak var delegate: ImagePickerDelegate?
//
//    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
//        self.pickerController = UIImagePickerController()
//
//        super.init()
//
//        self.presentationController = presentationController
//        self.delegate = delegate
//
//        self.pickerController.delegate = self
//        self.pickerController.allowsEditing = true
//        self.pickerController.mediaTypes = ["public.image"]
//    }
//
//    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
//        guard UIImagePickerController.isSourceTypeAvailable(type) else {
//            return nil
//        }
//
//        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
//            self.pickerController.sourceType = type
//            self.presentationController?.present(self.pickerController, animated: true)
//        }
//    }
//
//    public func present(from sourceView: UIView) {
//
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        if let action = self.action(for: .camera, title: "Take photo") {
//            alertController.addAction(action)
//        }
//        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
//            alertController.addAction(action)
//        }
//        if let action = self.action(for: .photoLibrary, title: "Photo library") {
//            alertController.addAction(action)
//        }
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            alertController.popoverPresentationController?.sourceView = sourceView
//            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
//            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
//        }
//
//        self.presentationController?.present(alertController, animated: true)
//    }
//
//    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
//        controller.dismiss(animated: true, completion: nil)
//
//        self.delegate?.didSelect(image: image)
//    }
//}
//
//extension ImagePicker: UIImagePickerControllerDelegate {
//
//    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.pickerController(picker, didSelect: nil)
//    }
//
//    public func imagePickerController(_ picker: UIImagePickerController,
//                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        guard let image = info[.editedImage] as? UIImage else {
//            return self.pickerController(picker, didSelect: nil)
//        }
//        self.pickerController(picker, didSelect: image)
//    }
//}
//
//extension ImagePicker: UINavigationControllerDelegate {
//
//}
//
