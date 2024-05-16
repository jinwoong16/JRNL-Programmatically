//
//  MapViewController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(mapView)
        
        view.backgroundColor = .white
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: global.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: global.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: global.bottomAnchor),
        ])
    }
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            debugPrint(#function, "Could not specify current location.")
            return
        }
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        mapView.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier
            )
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
