//
//  FilterRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 09.04.2022.
//  
//

import UIKit

final class FilterRouter {
    weak var sourceViewController: UIViewController?
}

extension FilterRouter: FilterRouterInput {
    func closeFilter() {
        sourceViewController?.navigationController?.popViewController(animated: true)
    }
}
