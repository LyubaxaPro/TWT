//
//  FavoritesViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import UIKit

final class FavoritesViewController: UIViewController {
	private let output: FavoritesViewOutput

    init(output: FavoritesViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()

        view.backgroundColor = .yellow
	}
}

extension FavoritesViewController: FavoritesViewInput {
}
