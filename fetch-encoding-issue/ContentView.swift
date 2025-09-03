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
}

#Preview {
    ContentView()
}
