//
//  CustomButtonBuilder.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//

import UIKit

final class CustomButtonBuilder {
    func getCustomButton(title: String) -> UIButton {
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
}

