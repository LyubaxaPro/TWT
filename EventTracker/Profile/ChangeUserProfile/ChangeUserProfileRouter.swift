//
//  ChangeUserProfileRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//
import UIKit

/// Класс, отвечающий за навигацию в модуле редактора профиля
final class ChangeUserProfileRouter {
    weak var sourceViewController: UIViewController?
}

extension ChangeUserProfileRouter: ChangeUserProfileRouterInput {
    /// Показывает сообщение об ошибке на экране редактора профиля
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }

    /// Закрыает текущий экран редактора и показывает экран профиля
    func backToProfile() {
        sourceViewController?.navigationController?.popViewController(animated: true)
    }
}
