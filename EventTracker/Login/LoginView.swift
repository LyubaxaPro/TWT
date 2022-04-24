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

/// Отображение экрана авторизации
class LoginView: UIView {
    private var output: LoginViewOutput?

    /// Логин при регистрации
    private var loginFieldRegister = UITextField()
    /// Пароль при регистрации
    private var passwordFieldRegister = UITextField()
    /// Имя при регистрации
    private var nameFieldRegister = UITextField()
    /// Город при регистрации
    private var cityPicker = UIPickerView()
    /// Доступные города
    var pickerData: [String] = []
    /// Выбранный город
    var pickerChoose: String = ""
    /// Кнопка регистрации
    private var buttonSignUpRegister = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 200,
                                        height: 40))
    /// Кнопка назад
    private var buttonBack = UIButton()

    /// Контейнер для отображения
    private let containerViewRegister = UIView()
    /// Label для отображения ошибки
    private var registerErrorLabel = UILabel()
    /// Поле логина вход
    private var loginField = UITextField()
    /// Поле пароля вход
    private var passwordField = UITextField()

    /// Кнопка входа в профиль
    var buttonSignIn = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 200,
                                        height: 40))
    /// Сообщение об ошибке при входе
    private var signInErrorLabel = UILabel()

    /// Заголовок входа в профиль
    private let signUpTitleLabel = UILabel(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: 100,
                                                         height: 40))
    /// Кнопка входа
    let buttonSignUp = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 100,
                                        height: 20))

    /// Кнопка выхода
    private let buttonExit = UIButton(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 50,
                                        height: 50))
    /// Контейнер для объединения элементов
    private let containerView = UIView()
    /// Сообщение о возможности восстановления пароля
    private let forgotPasswordLabel = UILabel()

    /// Поле почты для восстановления пароля
    private var emailField = UITextField()
    /// Кнопка восстановления пароля
    private var resetPasswordButton = UIButton()
    /// Контейнер для отображения элементов восстановления пароля
    private let containerForgotPassword = UIView()
    /// Кнопка назал восстановления пароля
    private var buttonBackForgotPassword = UIButton()
    /// Иконка пароля входа
    private var passwordIcon = UIImageView()
    /// Иконка пароля для регистрации
    private var passwordIconRegister = UIImageView()
    /// Ошибка восстановления пароля
    private var resetPasswordError = UILabel()

    /// Инициализация
    init(output: LoginViewOutput) {
        super.init(frame: UIScreen.main.bounds)
        self.output = output
        setup()

        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self

        self.backgroundColor = .white
    }

    /// Создание кастомного поля ввода
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

    /// Создание кастомной кнопки
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

    /// Создание кастомной кнопки назад
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

    /// Иконка пароля
    private func getPasswordIcon() -> UIImageView {
        let icon = UIImageView()
        icon.image = UIImage(named: "passwordIcon")
        icon.isUserInteractionEnabled = true
        icon.alpha = 0.1
        return icon
    }

    /// Сообщение об ошибке
    private func getErrorLabel()-> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .red
        label.text = "   Все поля должны быть заполнены   "
        label.numberOfLines = 0
        label.isHidden = true

        return label
    }

    ///  Установка параметров элементов
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

    /// Размещение на экране
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

    /// Обработка нажатия на кнопку создания аккаунта
    @objc
    func buttonSignUpAction() {
        self.containerView.isHidden = true
        self.containerViewRegister.isHidden = false
        registerErrorLabel.isHidden = true
    }

    /// Обработка нажатия на кнопку регистрации
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

    /// Обработка нажатия на кнопку входа
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

    /// Обработка нажатия на кнопку выхода
    @objc
    func buttonExitAction() {
        self.output?.didTapExitAuth()
    }

    /// Обработка нажатия на кнопку назад
    @objc
    func buttonBackAction() {
        self.containerView.isHidden = false
        signInErrorLabel.isHidden = true
        self.containerViewRegister.isHidden = true
    }

    /// Обработка нажатия на кнопку назад из экрана восстановления пароля
    @objc
    func buttonBackForgotPasswordAction() {
        self.containerView.isHidden = false
        signInErrorLabel.isHidden = true
        self.containerForgotPassword.isHidden = true
    }

    /// Обработка нажатия на кнопку восстановления пароля
    @objc
    func didTapForgotPassword() {
        self.containerView.isHidden = true
        self.containerForgotPassword.isHidden = false
        resetPasswordError.isHidden = true
    }

    /// Обработка нажатия на кнопку сброса пароля
    @objc
    private func didTapResetPassword() {
        let email = emailField.text ?? ""

        if (!email.isEmpty) {
            output?.didTapResetPassword(email: email)
        } else {
            output?.didReceiveError(description: "Все поля должны быть заполнены")
        }
    }

    /// Обработка нажатия на кнопку нажатия иконки пароля (скрыть / показать пароль)
    @objc
    private func didTapPasswordIcon() {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
        if (passwordField.isSecureTextEntry){
            passwordIcon.alpha = 0.1
        } else {
            passwordIcon.alpha = 1
        }
    }

    /// Обработка нажатия на кнопку нажатия иконки пароля (скрыть / показать пароль) при регистрации
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

/// Настройка текстового поля ввода
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

/// Обработка действий пользователя при входе
extension LoginView: LoginViewInputDescription {
    /// Показать ошибку
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

    /// Вернуться к экрану авторизации
    func backToLoginView() {
        buttonBackForgotPasswordAction()
    }
}

/// Работа с пикером данных о городе
extension LoginView: UIPickerViewDelegate, UIPickerViewDataSource {
    /// Количество пикеров
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    /// Количество элементов в пикере
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    /// Данные для пикера
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    /// Обработка выбора элемента из пикера
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerChoose = pickerData[row]
    }
}

