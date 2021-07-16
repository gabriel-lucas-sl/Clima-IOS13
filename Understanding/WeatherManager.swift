//
//  WeatherManager.swift
//  Clima
//
//  Created by Gabriel Silva on 15/07/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=51d81621da9cdd1723acd2af529ee5cd&units=metric&q=London"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName, weather.temperatureString)
        } catch {
            print(error.localizedDescription, error)
        }
    }
    
    
    
}
