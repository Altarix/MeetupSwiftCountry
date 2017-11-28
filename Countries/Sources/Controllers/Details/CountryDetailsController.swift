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

// TODO 6. Есть такая бага, что переходишь с этого экрана без сохранения изменений обратно в список, а изменения все равно сохраняются
class CountryDetailsController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    // TODO 9. Надо переделать логику опциональности, из-за этого падает приложение на добавлении
    var country: CountryEntity!
    var editHandler: ((_:CountryEntity) -> Void)!
    var addHandler: ((_:CountryEntity) -> Void)!
    
    // TODO 9. можно считать избыточным параметром
    var isAdding: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        update()
    }
    
    func update() {
        nameTextField.text = country.name
        codeTextField.text = country.code
        navigationItem.title = country.code
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func editClick(_ sender: Any) {
        update()
        if isAdding
        {
            let code = codeTextField.text ?? ""
            let name = nameTextField.text ?? ""
            let country = CountryEntity(name: name, code: code.uppercased())
            addHandler(country)
        } else {
            editHandler(country)
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
