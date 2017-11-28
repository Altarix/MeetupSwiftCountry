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

// TODO: 7. избыточное решение для Swift 4
protocol JSONProtocol {
    
    init(json : [String: Any])
    
    var json : [String: Any] {get}
    
}

class CountryEntity: JSONProtocol {
    var name: String
    var code: String
    
    required init(name: String, code: String) {
        self.name = name
        self.code = code
    }
    
    // TODO: 7. Упростить парсинг JSON - Codable
    required convenience init(json : [String: Any]) {
        self.init(name: json["name"] as? String ?? "",
                  code: json["code"] as? String ?? "")
    }
    
    var json : [String: Any] {
        return ["name": name, "code": code]
    }
}
