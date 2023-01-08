//
//  AlertPresenter.swift
//  Giphy
//
//  Created by Leo Bonhart on 08.01.2023.
//

import UIKit

struct AlertPresenter: AlertPresenterProtocol {
    weak var controller: UIViewController?
    
    func showAlert(_ alertModel: AlertModel) {
        guard let controller else { return }
        
        let alert = UIAlertController(title: alertModel.title,
                                 message: alertModel.message,
                                 preferredStyle: .alert)

        alert.view.accessibilityIdentifier = "Game results"
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default, handler: alertModel.completion)

        alert.addAction(action)

        controller.present(alert, animated: true, completion: nil)
    }
}

