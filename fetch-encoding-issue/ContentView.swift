//
//  ContentView.swift
//  fetch-encoding-issue
//
//  Created by Simon Deutsch on 03.09.25.
//

import SwiftUI
import Fetch

struct ContentView: View {
    
    init() {
        APIClient.shared.setup(with: .init(baseURL: URL(string: "https://some-url.com")!))
    }
    
    var body: some View {
        VStack {
            Button("Request Non Encoded", action: requestNonEncoded)
            Button("Request Encoded ", action: requestEncoded)
            Button("Request URLSession ", action: requestURLSession)
        }
    }
    
    
    func requestNonEncoded() {
        let id = "5/7"
        Task {
            try? await Resource<String>(
                method: .get,
                path: "/some-path/\(id)",
            ).requestAsync()
        }
    }
    
    func requestEncoded() {
        let id = "5%2F7"
        Task {
            try? await Resource<String>(
                method: .get,
                path: "/some-path/\(id)",
            ).requestAsync()
        }
    }
    
    func requestURLSession() {
        let id = "5%2F7"
        Task {
            let url = URL(string: "https://some-url.com/some-path/\(id)")!
            let req = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: req)

            if let httpResponse = response as? HTTPURLResponse {
                print("URL:", httpResponse.url?.absoluteString ?? "nil")
            }
        }
    }
}

#Preview {
    ContentView()
}
