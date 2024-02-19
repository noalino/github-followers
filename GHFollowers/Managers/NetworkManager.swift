//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Noalino on 04/01/2024.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let perPageCount = 100
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()

    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }

    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=\(perPageCount)&page=\(page)"

        guard let url = URL(string: endpoint) else {
            throw GFError.invalidRequest
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }

        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }


    func getUserInfo(for username: String) async throws -> User {
        let endpoint = baseURL + "\(username)"

        guard let url = URL(string: endpoint) else {
            throw GFError.invalidRequest
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }

        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }

    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            return image
        }

        guard let url = URL(string: urlString) else {
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
