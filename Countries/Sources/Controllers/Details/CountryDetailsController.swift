/**
 *    @file CountryDetailsController.swift
 *    @namespace Countries
 *
 *    @details Details of country with editing and adding function
 *    @date 21.11.2017
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/Altarix/MeetupSwiftCountry.git
 *    @copyright Apache-2.0 License https://opensource.org/licenses/Apache-2.0
 *     Copyright (c) 2017 Altarix. See http://altarix.ru
 */

import UIKit

class CountryDetailsController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var country: CountryEntity?
    
    var editHandler: ((_:CountryEntity) -> Void)?
    
    var addHandler: ((_:CountryEntity) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        update()
    }
    
    func update() {
        guard let country = country else {
            return
        }
        nameTextField.text = country.name
        codeTextField.text = country.code
        navigationItem.title = country.code
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func editClick(_ sender: Any) {
        update()
        if let country = country
        {
            editHandler?(country)
        } else {
            let code = codeTextField.text ?? ""
            let name = nameTextField.text ?? ""
            let country = CountryEntity(name: name, code: code.uppercased())
            addHandler?(country)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func codeEdit(_ sender: Any) {
        country?.code = codeTextField.text ?? ""
        update()
    }
    
    @IBAction func nameEdit(_ sender: Any) {
        country?.name = nameTextField.text ?? ""
        update()
    }
    
}
