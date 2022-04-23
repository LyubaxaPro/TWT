//
//  MapRouter.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import UIKit

final class MapRouter {
    weak var sourceViewController: UIViewController?
}

extension MapRouter: MapRouterInput {
    func showAlertErrorMessage(with message: String) {
        sourceViewController?.present(AlertManager.getAlert(description: message), animated: true, completion: nil)
    }
    
    func showPoster(with model: PosterViewModel, isInFavorites: Bool, output: MapPresenter) {
        
        let detailContainer = DetailContainer.assemble(with: DetailContext(moduleOutput: output, poster: model, isInFavorites: isInFavorites))
        sourceViewController?.navigationController?.pushViewController(detailContainer.viewController, animated: true)
    }
}
