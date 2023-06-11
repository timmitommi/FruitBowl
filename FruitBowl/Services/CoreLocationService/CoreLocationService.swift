//
//  CoreLocationService.swift
//  FruitBowl
//
//  Created by timas on 2023-06-11.
//

import Foundation
import CoreLocation

protocol CoreLocationServiceProtocol {
    var latestUserCoordinates: Coordinates? { get }
}

final class CoreLocationService: NSObject, CoreLocationServiceProtocol {
    private let locationManager: CLLocationManager
    
    @Published var latestUserCoordinates: Coordinates?
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
    }
}

extension CoreLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations.sorted { $0.timestamp > $1.timestamp}.first
        
        guard let latestLocation else {
            return
        }
        
        latestUserCoordinates = Coordinates(from: latestLocation.coordinate)
    }
}

private extension Coordinates {
    init(from coordinate: CLLocationCoordinate2D) {
        self.lat = coordinate.latitude
        self.lon = coordinate.longitude
    }
}
