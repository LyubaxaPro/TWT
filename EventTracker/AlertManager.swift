//
//  AlertManager.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 10.04.2022.
//

import UIKit
/// Обработчик сообщений об ошибке
final class AlertManager{
    /// Показать сообщение об ошибке
    class func getAlert(description: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: description, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alert.dismiss(animated: true, completion: nil)
         })
        alert.addAction(ok)
        return alert
    }
}

