/**
 *    @file Country.swift
 *    @namespace Countries
 *
 *    @details Data Model of country
 *    @date 21.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import Foundation

protocol CountryProtocol {
    var name: String {get}
    var code: String {get}
}

struct CountryEntity: Codable, CountryProtocol {
    var name: String
    var code: String
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}
