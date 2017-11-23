/**
 *    @file CountriesListCellProtocol.swift
 *    @namespace Countries
 *
 *    @details Connection different Cells View with model
 *    @date 21.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import UIKit

protocol CountriesListCellProtocol {
    
    func update(from entity: CountryProtocol)

}

extension CountriesListCellProtocol where Self: CountriesListCell {
    
    func update(from entity: CountryProtocol) {
        codeLabel.text = entity.code
        nameLabel.text = entity.name
    }
    
}

extension CountriesListCellProtocol where Self: CountriesCodeListCell {
    
    func update(from entity: CountryProtocol) {
        textLabel?.text = entity.code
    }
    
}

extension CountriesListCellProtocol where Self: CountriesNameListCell {
    
    func update(from entity: CountryProtocol) {
        textLabel?.text = entity.name
    }
    
}
