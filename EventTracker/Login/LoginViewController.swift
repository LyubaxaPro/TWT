//
//  LoginViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//  
//

import UIKit

final class LoginViewController: UIViewController {
    private let output: LoginViewOutput
    private let loginView: LoginView

    init(output: LoginViewOutput) {
        self.output = output
        self.loginView = LoginView(output: output)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension LoginViewController: LoginViewInput {
    func showError(description: String) {
        loginView.showError(description: description)
    }

    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    func backToLoginView() {
        loginView.backToLoginView()
    }
}

