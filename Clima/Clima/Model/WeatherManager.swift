import Foundation
struct WeatherManager{
    
    var delegate : WeatherManagaterDelegate?
    
    //The url should be in https type not in http type .
    //If it is http it will gives you an error.
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b1b94fb561835e9c83ea9deac74dad50&units=metric"
    
    
    //For Textfield input
    func fetchWeather(cityName : String){
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(URLString)
    }
    
    //Current Location
    func fetchWeather(latitude : Double,longitute : Double){
        let URLString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(URLString)
    }
    
    func performRequest(_ urlString :String){
        
        //Create a URL
        if let url = URL(string: urlString){
            //Create a session
            let session = URLSession(configuration: .default)
            
            //Create a task
            //let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            //In this completionHandler gets parameter as a function
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if(error != nil){
                    self.delegate?.didFailWithError(error :error!)
                    return  //Using a return in a void return type function it will break the function
                }
                
                if let safeData = data{
                    if let weather = parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather : weather)
                    }
                }
                
            }
            
            //Start the task
            task.resume()
        }
        
    }
    
    //This is the fuction that used in session.dataTask() as a paramenter
    //    func handle(data : Data?,response : URLResponse?,error : Error?)->Void{
    //
    //        //If there was a error we can display that error
    //
    //        if(error != nil){
    //            print(error!)
    //            return  //Using a return in a void return type function it will break the function
    //        }
    //
    //        if let safeData = data{
    //            let dataString = String(data: safeData, encoding: .utf8)
    //            print(dataString)
    //        }
    //
    //    }
    
    
    func parseJSON(_ weatherData : Data)->WeatherModel?{
        
        //Create instance of JSON object
        let decoder = JSONDecoder()
        
        //Use our decoder to decode
        do{
            //In this we use decodable type (not an object) So to specify weather data type we have to add .self
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)  //To error handle we used try catch
            
            let conditionId = decodeData.weather[0].id
            let cityName = decodeData.name
            let tempurature = decodeData.main.temp
            
            let weather = WeatherModel(conditionId: conditionId, cityName: cityName, tempurature: tempurature)
            
            return weather
            
        }
        catch{
            self.delegate?.didFailWithError(error :error)
            return nil
        }
        
    }
    
    
}


protocol WeatherManagaterDelegate {
    
    func didUpdateWeather(_ weatherManager :WeatherManager ,weather: WeatherModel)
    
    func didFailWithError(error : Error)
}



