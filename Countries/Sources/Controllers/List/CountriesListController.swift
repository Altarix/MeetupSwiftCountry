/**
 *    @file CountriesListController.swift
 *    @namespace Countries
 *
 *    @details Country list controller
 *    @date 21.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import UIKit

class CountriesListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var allCountries: [CountryEntity] = []
    private var countries: [CountryEntity] = []
    
    fileprivate enum Sections: String
    {
        case allCountry = "All information"
        
        case nameCountry = "Only name of countries"
        
        case codeCountry = "Only code of countries"
        
        // It's finished. That should be end.
        case count
        
        var index : Int { return hashValue }
        var cellID : String { return "\(self)" }
        var title: String { return rawValue }
        
        static func getFrom(index: Int) -> Sections? {
            let values = allValues()
            if index > -1 && index < values.count {
                return values[index]
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CountriesNameListCell.nib, forCellReuseIdentifier: Sections.nameCountry.cellID)
        tableView.register(CountriesCodeListCell.nib, forCellReuseIdentifier: Sections.codeCountry.cellID)
        tableView.register(CountriesListCell.nib, forCellReuseIdentifier: Sections.allCountry.cellID)
        
        /*tableView.register(UINib(nibName: "CountriesNameListCell", bundle: nil), forCellReuseIdentifier: Sections.nameCountry.cellID)
        tableView.register(UINib(nibName: "CountriesCodeListCell", bundle: nil), forCellReuseIdentifier: Sections.codeCountry.cellID)
        tableView.register(UINib(nibName: "CountriesListCell", bundle: nil), forCellReuseIdentifier: Sections.allCountry.cellID)*/
        
        loadCountries()
    }
    
    func loadCountries() {
        allCountries = Loader.loadArray(Loader.countryFileName)
        updateCountries()
    }
    
    func updateCountries() {
        let searchText = searchBar.text ?? ""
        countries = allCountries.filter({(countryEntity : CountryEntity) -> Bool in
            return countryEntity.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndex, animated: true)
        }
    }

}

extension CountriesListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return Sections.count.hashValue
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        guard let cellType = Sections.getFrom(index: section) else {
            return nil
        }
        return cellType.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cellType = Sections.getFrom(index: indexPath.section) else {
            return UITableViewCell()
        }
        
        let entity = countries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellID, for: indexPath)
        
        if let cell = cell as? CountriesListCellProtocol {
            cell.update(from: entity)
        }
        
        return cell
    }
    
}

extension CountriesListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let entity = countries[indexPath.row]
        
        performSegue(withIdentifier: "Details", sender: entity)
    }
    
}

extension CountriesListController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        updateCountries()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension CountriesListController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? CountryDetailsController {
            controller.country = sender as? CountryEntity
            if controller.country != nil {
                controller.editHandler = {[weak self] (countryEntity) in
                    guard var countries = self?.allCountries else {
                        return
                    }
                    
                    for i in 0..<countries.count {
                        if countries[i].code.lowercased() == countryEntity.code.lowercased() {
                            countries[i] = countryEntity
                        }
                    }
                    countries.sort(by: { (first, second) -> Bool in
                        return first.name < second.name
                    })
                    
                    Loader.saveArray(Loader.countryFileName, array: countries)
                    
                    self?.loadCountries()
                }
            } else {
                // it is adding
                controller.addHandler = {[weak self] (countryEntity) in
                    guard var countries = self?.allCountries else {
                        return
                    }
                    
                    countries.append(countryEntity)
                    countries.sort(by: { (first, second) -> Bool in
                        return first.name < second.name
                    })
                    
                    Loader.saveArray(Loader.countryFileName, array: countries)
                    
                    self?.loadCountries()
                }
            }
            
        }
    }
}
