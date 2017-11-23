/**
 *    @file UITableViewCell.swift
 *    @namespace Countries
 *
 *    @details Extension of UITableView
 *    @date 23.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import UIKit

// MARK: - Simplification of the work with NIBs and ReuseIdentifiers

extension UITableView {
    
    func register<T: UITableViewCell>(cells: [T.Type]) {
        for cell in cells {
            let bundle = Bundle.init(for: cell)
            let nib = UINib(nibName: cell.nibName, bundle: bundle)
            self.register(nib, forCellReuseIdentifier: cell.defaultReuseIdentifier)
        }
    }
    
    func register<T: UITableViewCell>(cell: T.Type) {
        register(cells: [cell])
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cellClass.defaultReuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

