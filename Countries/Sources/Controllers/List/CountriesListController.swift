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
    
    // TODO 2. Сделай каталог всех секций через enum
    fileprivate enum Sections: String
    {
        case allCountry
        //...
        
        // TODO 4. Глянь RawRepresentable используй allValues() для того чтобы реализовать получение значения Sections по индексу, для того чтобы избавится от Switch в делегируемых методах таблицы
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO 4. Ты хорошо сделал, что использовал xib, но надо как то через константы это все регистрировать, глянь extension UIView я добавил в проект и используй созданный тобой enum
        tableView.register(UINib(nibName: "CountriesCodeListCell", bundle: nil), forCellReuseIdentifier: "codeCountry")
        tableView.register(UINib(nibName: "CountriesListCell", bundle: nil), forCellReuseIdentifier: "allCountry")
        
        // TODO 1. Добавь еще в серединку секцию "Only name of countries", его id = "nameCountry" и это ячейка CountriesNameListCell, она уже есть в проекте.
        
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
        return 2 // TODO 2. Используй enum
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        // TODO 2. Используй enum
        switch section {
        case 0:
            return "All information"
        case 1:
            return "Only code of countries"
        default:
            return ""
        }
        // TODO 3. Избавься от Switch
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let entity = countries[indexPath.row]
        
        // TODO 2. Используй enum
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "allCountry", for: indexPath) as! CountriesListCell
            cell.codeLabel.text = entity.code
            cell.nameLabel.text = entity.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "codeCountry", for: indexPath) as! CountriesCodeListCell
            cell.textLabel?.text = entity.code
            return cell
        default:
            return UITableViewCell()
        }
        // TODO 3. Избавься от Switch
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
                controller.isAdding = false
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
                controller.isAdding = true
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
