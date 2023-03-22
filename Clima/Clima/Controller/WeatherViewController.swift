//
//  ViewController.swift
//  Clima
//
//  Created by Sandalu De Silva on 2023-03-21
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController {

    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        
    }
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
        
        
    }
    
    
}






//MARK: - UITextFieldDelegate



//Create extensions and add protocols to that extensions
extension WeatherViewController : UITextFieldDelegate{
    
    
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)  //dismiss the keyboard
    
    }
    
    //If user done with his writting he will press return button on his keyboard.
    //Using this method View Controller will know return button has been pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.endEditing(true)  //dismiss the keyboard
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text! == ""){
            textField.placeholder = "Type something"
            return false
        }
        else{
            return true
            
        }
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
            
        //Use searchTextField.text to get the weather for that city
        searchTextField.text = ""
        
        
    }
}


//MARK: - weatherManagerDelegate

extension WeatherViewController : WeatherManagaterDelegate{
    
    func didUpdateWeather(_ weatherManager :WeatherManager ,weather: WeatherModel) {
        print(weather.cityName)
        
        //You have to add this in dispatchqueue
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempuratureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
        }
    }
    
    
    
    func didFailWithError(error : Error){
        print(error)
    }
    
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude : lat,longitute :lon)
        }
        print("Get the location")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    

}



