//
//  Extensions.swift
//  AyanMain
//
//  Created by Aldiyar Massimkhanov on 8/24/20.
//  Copyright © 2020 Bakdaulet Myrzakerov. All rights reserved.
//

import UIKit

//  MARK: - message alert type
enum AlertMessageType: String {
    case error = "Ошибка"
    case deleteSuccess = "Удалено"
    case none  = "Внимание"
}

//  MARK: - view controller
extension UIViewController{
    func add(_ child: UIViewController, onView aView: UIView) {
        addChild(child)
        aView.addSubview(child.view)
        child.view.snp.makeConstraints { (make) in
            make.edges.equalTo(aView)
        }
        child.didMove(toParent: self)
    }
    func remove() {
        guard parent != nil else {return}
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    func showSubmitMessage(messageType: AlertMessageType, _ message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: messageType.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default) { (action) in
            if let completionHandler = completion {
                self.dismiss(animated: true, completion: nil)
                completionHandler()
            }
        }

        let cancelAction = UIAlertAction(title: "Нет", style: .default, handler: nil)

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    func showErrorMessage(messageType: AlertMessageType, _ message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: messageType.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let completionHandler = completion {
                self.dismiss(animated: true, completion: nil)
                completionHandler()
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showSuccessMessage(completion: (() -> ())? = nil) -> Void {
        let alertController = UIAlertController(title: "Успешно", message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                alertController.dismiss(animated: true) {
                    if let completionHandler = completion {
                        completionHandler()
                    }
                }
            }
        })
    }
}




//  MARK: - uiview
extension UIView {
    func addTapGesture(target: Any, action: Selector) {
      let tap = UITapGestureRecognizer(target: target, action: action)
      addGestureRecognizer(tap)
      isUserInteractionEnabled = true
    }
    func addShadow(_ radius: CGFloat = 20.0) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.7
    }
    func addSubviews(_ views : [UIView]) -> Void {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
    func addShadow(with color: UIColor, radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.8
        layer.cornerRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
    }
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


// MARK: - formatter
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        return formatter
    }()
}


//  MARK: - string
extension String {
    var serverUrlString: String {
        return "http://37.46.133.192:8093/" + self
    }
    var asUrl: URL {
        if let url = URL(string: self) {
            return url
        } else {
            return URL(string: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png")!
        }
    }
    
}


//  MARK: - dare
extension Date {
    
    var generalDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = dateFormatter.string(from: self)

        return string
    }
    
    var defaultDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let string = dateFormatter.string(from: self)

        return string
    }
    
    var currentTime: (hour: Int, minute: Int, time: String) {
        let date = Date()

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        let hourString = hour > 9 ? String(hour) : "0\(hour)"
        let minuteString = minute > 9 ? String(minute) : "0\(minute)"

        return (hour, minute, "\(hourString):\(minuteString)")
    }
}


