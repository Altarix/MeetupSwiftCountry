/**
 *    @file Loader.swift
 *    @namespace Countries
 *
 *    @details Data storge utilities
 *    @date 22.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import Foundation

final class Loader {
    
    static var countryFileName = "countries.json"
    
    private class func getURL(_ mockupFile: String) -> String?
    {
        if let resourceURL = Bundle.main.resourceURL?.absoluteString {
            let result = resourceURL + mockupFile
            print("""
                USING the MOCKUP '\(mockupFile)'
                FROM FILE \(result)
                """)
            return result
        }
        return nil
    }
    
    class func loadArray<T>(_ mockupFile: String) -> [T] {
        var result : [T] = []
        guard let stringURL = getURL(mockupFile),
            let url = URL(string: stringURL) else
        {
            print("'\(mockupFile)' not found from resources")
            return result
        }
        
        let decoder = JSONDecoder()
        do {
            let responseData = try Data(contentsOf: url, options: .alwaysMapped)
            result = try decoder.decode([T].self, from: responseData as Data)
        } catch {
            print("""
                error trying to convert data to JSON
                from '\(mockupFile)'
                DETAILS:
                -------
                """)
            print(error)
        }
        return result
    }
    
    class func saveArray<T>(_ mockupFile: String, array: [T]) {
        
        guard let stringURL = getURL(mockupFile),
            let url = URL(string: stringURL) else
        {
            print("'\(mockupFile)' not found from resources")
            return
        }
        
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .deferredToData
        do {
            try FileManager.default.removeItem(at: url)
            let data = try encoder.encode(array)
            let jsonString = String(data: data, encoding: .utf8)
            try jsonString?.write(to: url, atomically: true, encoding: .utf8)
            
        } catch {
            print("""
                error trying save JSON to file
                to '\(mockupFile)'
                DETAILS:
                -------
                """)
            print(error)
        }
    }
    
}
