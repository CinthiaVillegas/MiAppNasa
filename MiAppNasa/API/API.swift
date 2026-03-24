//
//  API.swift
//  MiAppNasa
//
//  Created by Cinthia Villegas on 23/03/26.
//
import Foundation

class ApiNetwork {
    
    let tokenId: String = "XBPj5dNcEayI5BeJ3todCQ3ZHuRTJi8kEJa3svLd"
    let url: String = "https://api.nasa.gov/planetary/apod?api_key="
    
    func getInfoOfDay() async throws -> Apod {
        guard let urlRequest = URL(string: "\(url)\(tokenId)&thumbs=true&count=1") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
       
        let info = try JSONDecoder().decode([Apod].self, from: data)
        
        guard let dataApod = info.first else {
            throw URLError(.cannotParseResponse)
        }
        
        return dataApod
        
    }
    
}
