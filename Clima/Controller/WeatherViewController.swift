 //
 //  ViewController.swift
 //  Clima
 //
 //  Created by Angela Yu on 01/09/2019.
 //  Copyright © 2019 App Brewery. All rights reserved.
 //
 
 import UIKit
 import CoreLocation
 
 class WeatherViewController: UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
    
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()

        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        spinner.startAnimating()
        locationManager.requestLocation()
    }
    
 }
 
 // MARK: - UITextFieldDelegateSection
 
 extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    // You can use it for some validations
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else  {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            spinner.startAnimating()
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
 }
 
 // MARK: - WeatherManagerDelegate
 
 extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.spinner.stopAnimating()
        }
    }
    
    func didFailedWithError(_ error: Error) {
        print(error.localizedDescription, "\n", error)
    }
 }

 // MARK: - CLLocationManagerDelegate
 
 extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        spinner.startAnimating()
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = Int(location.coordinate.latitude)
            let lon = Int(location.coordinate.longitude)
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
 }
