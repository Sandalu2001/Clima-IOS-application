//
//  WeatherModel.swift
//  Clima
//
//  Created by Sandalu De Silva on 2023-03-21.
//

import Foundation
//Used to interact with model

struct WeatherModel{
    
    //These are stored properties
    let conditionId : Int
    let cityName : String
    let tempurature : Double
    
    
    //This is computated propertie
    var conditionName : String{
        print(conditionId)
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var tempuratureString: String{
        return String(format: "%.0f", tempurature)
    }
}
