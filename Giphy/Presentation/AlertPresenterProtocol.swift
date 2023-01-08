//
//  AlertPresenterProtocol.swift
//  Giphy
//
//  Created by Leo Bonhart on 08.01.2023.
//

import UIKit

protocol AlertPresenterProtocol {
    var controller: UIViewController? {get set}
    func showAlert(_ alertModel: AlertModel)
}
