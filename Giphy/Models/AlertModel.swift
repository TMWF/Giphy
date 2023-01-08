//
//  AlertModel.swift
//  Giphy
//
//  Created by Leo Bonhart on 08.01.2023.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (UIAlertAction) -> Void
}
