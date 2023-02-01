//
//  WeatherManager.swift
//  Clima
//
//  Created by Eser Lodhia on 29/09/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3e31f4742ac610cecf9c6c92807caf85&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //        create a url
        
        if let url = URL(string: urlString) {
            
            //          create a urlSession
            
            let session = URLSession(configuration: .default)
            
            //          give the urlSession a task using closures(check closures lesson)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData) {
                        _ = WeatherViewController()
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            //          start the task
            
            task.resume()
            
        }
        
        func parseJSON(weatherData: Data) -> WeatherModel? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                
                let weather = WeatherModel(cityName: name, conditionId: id, temperature: temp)
                //print(weather.conditionName, weather.tempString)
                print("\(decodedData.name) is currently sitting at \(decodedData.main.temp) celcious and \(decodedData.weather[0].description)", "with wind speed of \(decodedData.wind.speed)")
                
                return weather
                
                
                               
            } catch {
                print(error)
                return nil
            }
        }
        
        
        
    }
}


