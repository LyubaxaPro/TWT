//
//  ChangeUserProfileRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//
import UIKit

final class ChangeUserProfileRouter {
    weak var sourceViewController: UIViewController?
}

extension ChangeUserProfileRouter: ChangeUserProfileRouterInput {
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }

    func backToProfile() {
        sourceViewController?.navigationController?.popViewController(animated: true)
    }
}
