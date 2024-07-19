//
//  ApiService.swift
//  MozzartGreek
//
//  Created by Djordje Andric on 18.07.24.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
}

struct APIService {
    static let shared = APIService()
    
    private init() {}
    
    func performRequest<T: Decodable>(endpoint: Endpoint, body: Data? = nil) async throws -> T {
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if endpoint.isAuth {
            if let token = UserDefaults.standard.string(forKey: "token") {
                request.setValue("Basic \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print(error)
            throw URLError(.callIsActive)
        }
        
        
    }
}


struct Endpoint {
    var path: String
    var method: HTTPMethod
    var isAuth: Bool
    var queryItems: [URLQueryItem] = []
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.opap.gr"
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        return components.url
    }
}

extension Endpoint {
    static func greekGames() -> Endpoint {
        return Endpoint(path: "/draws/v3.0/1100/upcoming/20", method: .GET, isAuth: false)
    }
    static func results() -> Endpoint {
        
        let today = TimeFormatter.endpointDate()
        
        return Endpoint(path: "/draws/v3.0/1100/draw-date/\(today)/\(today)", method: .GET, isAuth: false)
    }
}
