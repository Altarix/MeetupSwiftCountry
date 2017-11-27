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

// TODO 3. Реалезуй этот протокол чтобы вытащить из контролера обновление ячеек
// ПРИМЕР: extension CountriesListCellProtocol where Self: YourCell
// Да, и ячейки не забудь укомплектовать этим протоколом
protocol CountriesListCellProtocol {
    
    // TODO 6. абстрогируйся от модели через протокол
    func update(from entity: CountryEntity)

}
