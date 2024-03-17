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
    var miles: String = "10mi"
    var count: Int = 10
    @IBOutlet private weak var slider: UISlider!
    let venuesViewModel = VenuesViewModel()
    private var latitude: Double?
    private var longitude: Double?
    var currentLocation = CLLocationCoordinate2D()  {
        didSet {
            
            latitude = currentLocation.latitude
            longitude = currentLocation.longitude
            if latitude != nil  {
                getDataFromViewModel()
            }
            
        }
    }
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tblViewVenues: UITableView!
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    func getDataFromViewModel() {
        venuesViewModel.fetchData("\(latitude ?? 0.0)", "\(longitude ?? 0.0)", miles, count)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestLocationUpdates()
        slider.minimumValue = 0
        slider.maximumValue = 1000
        registerNIB()
        tblViewVenues.delegate = self
        tblViewVenues.dataSource = self
        activityIndicatorView.startAnimating()
    }
    
    
    @IBAction private func slideAction(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        let intValue = Int(roundedValue)
        miles = "\(intValue)mi"
        getDataFromViewModel()
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
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}



