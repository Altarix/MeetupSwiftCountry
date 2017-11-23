/**
 *    @file UITableViewCell.swift
 *    @namespace Countries
 *
 *    @details Extension of UIView
 *    @date 23.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import UIKit

/// Cast the argument to the infered function return type.
func autocast<T>(_ some: Any) -> T? {
    return some as? T
}

extension UIView {
    
    class var nibName: String {
        get {
            return NSStringFromClass(self).components(separatedBy: ".").last!
        }
    }
    
    class var nib: UINib {
        get {
            return UINib(nibName: self.nibName, bundle: nil)
        }
    }
    
    class func fromNib() -> Self {
        return autocast(Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0])!
    }
    
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> Self? {
        return autocast(UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0])
    }
    
    func loadFromNib() -> UIView {
        let nibName = String(describing: type(of: self))
        let nib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        return nib?.first as! UIView
    }
}

