//
//  ChangeUserProfileViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 17.04.2022.
//  
//

import UIKit

/// Класс, отвечающий за представление редактора профиля
final class ChangeUserProfileViewController: UIViewController {
    private let output: ChangeUserProfileViewOutput
    private var nameField = UITextField()

    private var cityPicker = UIPickerView()
    var pickerData: [String] = []
    var pickerChoose: String = ""
    var acceptButton = UIButton(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 200,
                                              height: 40))

    init(output: ChangeUserProfileViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getCustomTextField (placeholder: String) -> UITextField {
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

        textField.placeholder = placeholder

        return textField
    }

    func setup() {
        nameField = getCustomTextField(placeholder: output.getName())

        pickerData = output.getCitiesData()
        pickerChoose = output.getCity()

        acceptButton.setTitle("Применить", for: .normal)
        acceptButton.setTitleColor(.systemGray6,for: .normal)
        acceptButton.backgroundColor = .systemBlue
        acceptButton.layer.cornerRadius = 12
        acceptButton.addTarget(self, action: #selector(acceptButtonAction),
                         for: .touchUpInside)

        cityPicker.selectRow(output.getCityIndex(), inComponent: 0, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self

        setup()

        view.backgroundColor = .systemBackground
        [nameField, cityPicker, acceptButton].forEach{
            view.addSubview($0)
        }
    }

    override func viewDidLayoutSubviews() {
        nameField.pin
            .top(view.pin.safeArea.top + 30)
            .hCenter()

        cityPicker.pin
            .below(of: nameField)
            .marginTop(30)
            .hCenter()

        acceptButton.pin
            .bottom(view.pin.safeArea.bottom + 100)
            .hCenter()
    }

    /// Вызывается при нажатии на кнопку сохранения информации о пользователе
    @objc
    private func acceptButtonAction() {
        var newName = nameField.text ?? ""
        if newName.isEmpty {
            newName = output.getName()
        }
        output.didTapChangeUserProfile(newCity: pickerChoose, newName: newName)
    }
}

extension ChangeUserProfileViewController: ChangeUserProfileViewInput {
}

extension ChangeUserProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

