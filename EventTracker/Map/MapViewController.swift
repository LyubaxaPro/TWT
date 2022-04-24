//
//  MapViewController.swift
//  EventTracker
//
//  Created by Liubov Prokhorova on 19.03.2022.
//  
//

import UIKit
import MapKit

/// Класс, отвечающий за отображение данных на экране карты
final class MapViewController: UIViewController {
    private let output: MapViewOutput
    private var curPlace: String = ""
    private var mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    /// Начальная локация
    let initialLocation = CLLocation(latitude: 55.751244, longitude: 37.618423)


    init(output: MapViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.centerToLocation(initialLocation)
        mapView.delegate = self
        
        view.addSubview(mapView)
        output.didLoad()
    }
}

extension MapViewController: MapViewInput {
    /// Обновляет экран карты
    func reloadData(with newLocation: Coordinates) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(output.mapPlaces)
        mapView.centerToLocation(CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude))
    }
}

private extension MKMapView {
    /// Отображает на экране карты переданную локацию
    func centerToLocation(
      _ location: CLLocation,
      regionRadius: CLLocationDistance = 1000
    ) {
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MapPlace else {
          return nil
        }
        
        let identifier = "place"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
          withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
          
          view = MKMarkerAnnotationView(
            annotation: annotation,
            reuseIdentifier: identifier)
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let place = view.annotation as! MapPlace
        output.didTapCell(poster: place.poster)
    }
}
