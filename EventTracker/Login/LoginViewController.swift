//
//  LoginViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import UIKit
/// Контроллер модуля экрана авторизации
final class LoginViewController: UIViewController {
    private let output: LoginViewOutput
    private let loginView: LoginView

    /// Инициализация
    init(output: LoginViewOutput) {
        self.output = output
        self.loginView = LoginView(output: output)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Установка параметров элементов
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
    }

    /// Размещение элементов на экране
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

/// Получение информации от управляющего класса
extension LoginViewController: LoginViewInput {
    /// Показать ошибку
    func showError(description: String) {
        loginView.showError(description: description)
    }

    /// Закрыть модальное окно
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    /// Показать окно авторизации
    func backToLoginView() {
        loginView.backToLoginView()
    }
}

