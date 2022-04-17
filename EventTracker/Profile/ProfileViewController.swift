//
//  ProfileViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
    let buttonLogout = UIButton(frame: CGRect(x: 0,
                                            y: 0,
                                            width: 200,
                                            height: 40))

    let changeProfileData = UILabel()

    let nameLabel = UILabel()
    let cityLabel = UILabel()

    init(output: ProfileViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setup()
        output.didLoadView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        output.didLoadView()
    }

    private func setup() {
        buttonLogout.setTitle("Выйти", for: .normal)
        buttonLogout.setTitleColor(.systemGray6,for: .normal)
        buttonLogout.backgroundColor = .systemPink
        buttonLogout.layer.cornerRadius = 12
        buttonLogout.addTarget(self, action: #selector(buttonLogoutAction),
                         for: .touchUpInside)

        changeProfileData.text = "Редактировать профиль"
        changeProfileData.textColor = .systemBlue
        changeProfileData.font = .systemFont(ofSize: 16, weight: .regular)
        changeProfileData.isUserInteractionEnabled = true

        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(didTapChangeProfileData))
        changeProfileData.addGestureRecognizer(gestureRecognizer)

        nameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        nameLabel.textColor = .black
        nameLabel.text = "Здравствуйте, Yniknfjmldvbhjfk"
        nameLabel.isHidden = true

        cityLabel.font = .systemFont(ofSize: 16, weight: .regular)
        cityLabel.textColor = .black
        cityLabel.text = "Ваш город Нижнний Новгород"
        cityLabel.isHidden = true

        [buttonLogout, nameLabel, cityLabel, changeProfileData].forEach {
            view.addSubview($0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        nameLabel.pin
            .top(view.pin.safeArea.top + 60)
            .left(view.pin.safeArea.left + 30)
            .sizeToFit()

        cityLabel.pin
            .below(of: nameLabel)
            .marginTop(30)
            .left(view.pin.safeArea.left + 30)
            .width(600)
            .sizeToFit()

        changeProfileData.pin
            .hCenter()
            .bottom(300)
            .sizeToFit()

        buttonLogout.pin
            .below(of: changeProfileData)
            .marginTop(20)
            .hCenter()
    }

    @objc
    func buttonLogoutAction() {
        self.output.didTapLogout()
    }

    @objc
    func didTapChangeProfileData() {
        output.didTapChange()
    }

    override func viewDidDisappear(_ animated: Bool) {
        output.didLoadView()
    }
}

extension ProfileViewController: ProfileViewInput {
    func reloadData() {
        nameLabel.text = "Здравствуйте, \(output.userInfo.name)"
        nameLabel.isHidden = false
        cityLabel.text = "Ваш город \(output.userInfo.city)"
        cityLabel.isHidden = false
    }
}

