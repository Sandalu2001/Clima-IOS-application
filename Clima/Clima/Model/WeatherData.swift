//
//  WeatherData.swift
//  Clima
//
//  Created by Sandalu De Silva on 2023-03-20.
//

import Foundation

//This is used to get data from JSON 

struct WeatherData : Codable{
    let name : String
    let main : Main
    let wind : Speed
    let weather : [Weather]
}


struct Main : Codable{
    let temp : Double
}

struct Speed : Codable{
    let speed: Double
}

struct Weather : Codable{
    let id: Int
}
