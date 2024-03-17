//
//  ViewController.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

import UIKit
import CoreLocation
// MARK: VenuesViewController
final class VenuesViewController: UIViewController {
    let venuesViewModel = VenuesViewModel()
    
    var currentLocation = CLLocationCoordinate2D()
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tblViewVenues: UITableView!
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestLocationUpdates()
        registerNIB()
        tblViewVenues.delegate = self
        tblViewVenues.dataSource = self
        activityIndicatorView.startAnimating()
        venuesViewModel.fetchData()
        venuesViewModel.eventData = { [weak self] event in
            guard let self = self else {
                return
            }
            switch event {
                
             
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.tblViewVenues.reloadData()
                }
                
            case .error(let apiError):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "alert", message: "error", preferredStyle: .alert)
                    self.present(alert, animated: false)
                }
            default:
                break
            }
            
        }
    }
    
    

    private func registerNIB() {
        tblViewVenues.registerCellFromNib(cellIdentifier: VenuesTableViewCell.reuseIdentifier)
    }
}

extension VenuesViewController: CLLocationManagerDelegate {
    
    private func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        default:
            print("Location not determined")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}



