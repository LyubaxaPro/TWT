//
//  LoginView.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 13.04.2022.
//

import UIKit
import Kingfisher
import PinLayout

protocol LoginViewInputDescription: AnyObject {
    func showError(description: String)
    func backToLoginView()
}

class LoginView: UIView {
    private var output: LoginViewOutput?

    private var loginFieldRegister = UITextField()
    private var passwordFieldRegister = UITextField()
    private var nameFieldRegister = UITextField()
    private var cityPicker = UIPickerView()
    var pickerData: [String] = []
    var pickerChoose: String = ""
    private var buttonSignUpRegister = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 200,
                                        height: 40))

    private var buttonBack = UIButton()

    private let containerViewRegister = UIView()
    private var registerErrorLabel = UILabel()

    private var loginField = UITextField()
    private var passwordField = UITextField()

    var buttonSignIn = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 200,
                                        height: 40))

    private var signInErrorLabel = UILabel()

    private let signUpTitleLabel = UILabel(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 100,
                                                         height: 40))
    let buttonSignUp = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 100,
                                        height: 20))

    private let buttonExit = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 50,
                                        height: 50))

    private let containerView = UIView()

    private let forgotPasswordLabel = UILabel()

    private var emailField = UITextField()
    private var resetPasswordButton = UIButton()
    private let containerForgotPassword = UIView()

    private var buttonBackForgotPassword = UIButton()

    private var passwordIcon = UIImageView()
    private var passwordIconRegister = UIImageView()

    private var resetPasswordError = UILabel()

    init(output: LoginViewOutput) {
        super.init(frame: UIScreen.main.bounds)
        self.output = output
        setup()

        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self

        self.backgroundColor = .white
    }

    private func getCustomTextField (isPassword: Bool, placeholder: String) -> UITextField {
        let textField =  UITextField(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: 300,
                                                    height: 60))

        textField.font = .systemFont(ofSize: 14, weight: .light)
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.45).cgColor
        textField.layer.borderWidth = 0.25
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = false
        textField.layer.shadowOpacity=0.4
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.indent(size: 10)

        if isPassword {
            textField.isSecureTextEntry = true
        }

        textField.placeholder = placeholder

        return textField
    }

    private func getCustomButton(title: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 200,
                                            height: 40))
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemGray6,for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 12

        return button
    }

    private func getCustomBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 50,
                                            height: 50))
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitleColor(.systemGray6,for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 25

        return button
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getPasswordIcon() -> UIImageView {
        let icon = UIImageView()
        icon.image = UIImage(named: "passwordIcon")
        icon.isUserInteractionEnabled = true
        icon.alpha = 0.1
        return icon
    }

    private func getErrorLabel()-> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .red
        label.text = "   Все поля должны быть заполнены   "
        label.numberOfLines = 0
        label.isHidden = true

        return label
    }

    private func setup() {
        containerView.clipsToBounds = true

        loginField = getCustomTextField(isPassword: false, placeholder: "Введите почту")
        passwordField = getCustomTextField(isPassword: true, placeholder: "Введите пароль")

        buttonSignIn = getCustomButton(title: "Войти")
        buttonSignIn.addTarget(self,action: #selector(buttonSignInAction),
                         for: .touchUpInside)

        signInErrorLabel = getErrorLabel()

        signUpTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        signUpTitleLabel.textColor = .black
        signUpTitleLabel.text = "Нет аккаунта?"

        buttonSignUp.setTitle("Создать", for: .normal)
        buttonSignUp.setTitleColor(.systemTeal,for: .normal)
        buttonSignUp.backgroundColor = self.backgroundColor
        buttonSignUp.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        buttonSignUp.addTarget(self,action: #selector(buttonSignUpAction),
                         for: .touchUpInside)

        buttonExit.setImage(UIImage(systemName: "xmark"), for: .normal)
        buttonExit.setTitleColor(.systemGray6,for: .normal)
        buttonExit.backgroundColor = .systemGray6
        buttonExit.layer.cornerRadius = 25
        buttonExit.addTarget(self,action: #selector(buttonExitAction),
                         for: .touchUpInside)

        forgotPasswordLabel.text = "Не помню пароль"
        forgotPasswordLabel.textColor = .systemTeal
        forgotPasswordLabel.font = .systemFont(ofSize: 14, weight: .regular)
        forgotPasswordLabel.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(didTapForgotPassword))
        forgotPasswordLabel.addGestureRecognizer(gestureRecognizer)

        passwordIcon = getPasswordIcon()
        let gestureRecognizerIcon = UITapGestureRecognizer(target: self, action: #selector(didTapPasswordIcon))
        passwordIcon.addGestureRecognizer(gestureRecognizerIcon)

        [loginField, passwordField, buttonSignIn, signUpTitleLabel, buttonSignUp, buttonExit, forgotPasswordLabel, passwordIcon, signInErrorLabel].forEach {
            containerView.addSubview($0)
        }

        self.addSubview(containerView)

        containerViewRegister.clipsToBounds = true

        loginFieldRegister = getCustomTextField(isPassword: false, placeholder: "Введите почту")
        passwordFieldRegister = getCustomTextField(isPassword: true, placeholder: "Введите пароль")
        nameFieldRegister = getCustomTextField(isPassword: false, placeholder: "Введите имя")
        pickerData = output?.getCitiesData() ?? []
        pickerChoose = pickerData[0]

        buttonSignUpRegister = getCustomButton(title: "Создать")
        buttonSignUpRegister.addTarget(self,action: #selector(buttonSignUpRegisterAction),
                         for: .touchUpInside)

        buttonBack = getCustomBackButton()
        buttonBack.addTarget(self,action: #selector(buttonBackAction),
                         for: .touchUpInside)

        passwordIconRegister = getPasswordIcon()
        let gestureRecognizerIconRegister = UITapGestureRecognizer(target: self, action: #selector(didTapPasswordIconRegister))
        passwordIconRegister.addGestureRecognizer(gestureRecognizerIconRegister)

        registerErrorLabel = getErrorLabel()

        [loginFieldRegister, passwordFieldRegister, nameFieldRegister, cityPicker, buttonSignUpRegister, buttonBack, passwordIconRegister, registerErrorLabel].forEach {
            containerViewRegister.addSubview($0)
        }

        self.addSubview(containerViewRegister)
        self.containerViewRegister.isHidden = true

        emailField = getCustomTextField(isPassword: false, placeholder: "Введите почту")

        resetPasswordButton = getCustomButton(title: "Сбросить пароль")
        resetPasswordButton.addTarget(self, action: #selector(didTapResetPassword), for: .touchUpInside)

        buttonBackForgotPassword = getCustomBackButton()
        buttonBackForgotPassword.addTarget(self,action: #selector(buttonBackForgotPasswordAction),
                         for: .touchUpInside)

        resetPasswordError = getErrorLabel()

        [emailField, resetPasswordButton, buttonBackForgotPassword, resetPasswordError].forEach {
            containerForgotPassword.addSubview($0)
        }

        self.addSubview(containerForgotPassword)
        self.containerForgotPassword.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.pin
            .left(15)
            .right(15)
            .top(100)
            .bottom(8)

        loginField.pin
            .hCenter()
            .top(self.frame.height / 4)

        signInErrorLabel.pin
            .top(self.frame.height / 7)
            .sizeToFit()
            .hCenter()

        passwordField.pin
            .hCenter()
            .below(of: loginField)
            .margin(10)

        buttonSignIn.pin
            .hCenter()
            .below(of: passwordField)
            .margin(20)

        buttonSignUp.pin
            .left(self.frame.width / 2 - 10)
            .below(of: buttonSignIn)
            .margin(10)

        signUpTitleLabel.pin
            .left(self.frame.width / 4)
            .below(of: buttonSignIn)

        forgotPasswordLabel.pin
            .below(of: signUpTitleLabel)
            .left(self.frame.width / 4)
            .sizeToFit()

        passwordIcon.pin
        .below(of: loginField)
        .marginTop(20)
        .size(CGSize(width: 40, height: 40))
        .right(self.frame.width / 6)

        containerViewRegister.pin
            .left(15)
            .right(15)
            .top(100)
            .bottom(8)

        registerErrorLabel.pin
            .top(100)
            .sizeToFit()
            .hCenter()

        nameFieldRegister.pin
            .hCenter()
            .below(of: registerErrorLabel)
            .marginTop(30)

        cityPicker.pin
            .hCenter()
            .below(of: nameFieldRegister)
            .marginTop(10)

        loginFieldRegister.pin
            .hCenter()
            .below(of: cityPicker)
            .marginTop(10)

        passwordFieldRegister.pin
            .hCenter()
            .below(of: loginFieldRegister)
            .margin(10)

        passwordIconRegister.pin
        .below(of: loginFieldRegister)
        .marginTop(20)
        .size(CGSize(width: 40, height: 40))
        .right(self.frame.width / 10)

        buttonSignUpRegister.pin
            .hCenter()
            .below(of: passwordFieldRegister)
            .margin(20)

        containerForgotPassword.pin
            .left(15)
            .right(15)
            .top(100)
            .bottom(8)

        resetPasswordError.pin
            .top(60)
            .hCenter()
            .sizeToFit()

        emailField.pin
            .hCenter()
            .top(self.frame.height / 4)

        resetPasswordButton.pin
            .hCenter()
            .below(of: emailField)
            .margin(20)
    }

    @objc
    func buttonSignUpAction() {
        self.containerView.isHidden = true
        self.containerViewRegister.isHidden = false
        registerErrorLabel.isHidden = true
    }

    @objc
    func buttonSignUpRegisterAction() {
        let login = loginFieldRegister.text ?? ""
        let password = passwordFieldRegister.text ?? ""
        let name = nameFieldRegister.text ?? ""
        let city = pickerChoose

        [login, password, name, city].forEach {
            if $0.isEmpty {
                output?.didReceiveError(description: "Все поля должны быть заполнены")
                return
            }
        }

        self.output?.didTapCreateUser(email: login, password: password, name: name, city: city)
    }

    @objc
    func buttonSignInAction() {
        let login = loginField.text ?? ""
        let password = passwordField.text ?? ""

        if (!login.isEmpty && !password.isEmpty) {
            self.output?.didTapLogin(login: login, password: password)
        } else {
            output?.didReceiveError(description: "Все поля должны быть заполнены")
        }
    }

    @objc
    func buttonExitAction() {
        self.output?.didTapExitAuth()
    }

    @objc
    func buttonBackAction() {
        self.containerView.isHidden = false
        signInErrorLabel.isHidden = true
        self.containerViewRegister.isHidden = true
    }

    @objc
    func buttonBackForgotPasswordAction() {
        self.containerView.isHidden = false
        signInErrorLabel.isHidden = true
        self.containerForgotPassword.isHidden = true
    }

    @objc
    func didTapForgotPassword() {
        self.containerView.isHidden = true
        self.containerForgotPassword.isHidden = false
        resetPasswordError.isHidden = true
    }

    @objc
    private func didTapResetPassword() {
        let email = emailField.text ?? ""

        if (!email.isEmpty) {
            output?.didTapResetPassword(email: email)
        } else {
            output?.didReceiveError(description: "Все поля должны быть заполнены")
        }
    }

    @objc
    private func didTapPasswordIcon() {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        if (passwordField.isSecureTextEntry){
            passwordIcon.alpha = 0.1
        } else {
            passwordIcon.alpha = 1
        }
    }

    @objc
    private func didTapPasswordIconRegister() {
        passwordFieldRegister.isSecureTextEntry = !passwordFieldRegister.isSecureTextEntry
        if (passwordFieldRegister.isSecureTextEntry){
            passwordIconRegister.alpha = 0.1
        } else {
            passwordIconRegister.alpha = 1
        }
    }
}

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension LoginView: LoginViewInputDescription {
    func showError(description: String) {
        if containerView.isHidden == false {
            signInErrorLabel.isHidden = false
            signInErrorLabel.text = description
        }

        if containerViewRegister.isHidden == false {
            registerErrorLabel.isHidden = false
            registerErrorLabel.text = description
        }

        if containerForgotPassword.isHidden == false {
            resetPasswordError.isHidden = false
            resetPasswordError.text = description
        }
    }

    func backToLoginView() {
        buttonBackForgotPasswordAction()
    }
}

extension LoginView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerChoose = pickerData[row]
    }
}

