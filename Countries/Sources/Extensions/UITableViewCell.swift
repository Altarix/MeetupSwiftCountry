/**
 *    @file UITableViewCell.swift
 *    @namespace Countries
 *
 *    @details Extension of UITableViewCell
 *    @date 23.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import UIKit


extension UITableViewCell {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
}
