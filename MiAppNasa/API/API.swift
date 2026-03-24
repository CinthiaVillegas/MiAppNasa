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
        let urlRequest = URL(string: "\(url)\(tokenId)&thumbs=true&count=1")!
        
        let (data, _) = try await URLSession.shared.data(from: urlRequest)
        
        let info = try JSONDecoder().decode([Apod].self, from: data)
        
        guard let dataApod = info.first else {
            throw URLError(.cannotParseResponse)
        }
        
        return dataApod
        
    }
    
}
