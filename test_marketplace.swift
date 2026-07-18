import Foundation

struct VSMarketplaceResponse: Codable {
    let results: [VSMarketplaceResult]?
}
struct VSMarketplaceResult: Codable {
    let extensions: [VSMarketplaceExtension]?
}
struct VSMarketplaceExtension: Codable, Identifiable {
    var id: String { extensionId }
    let extensionId: String
    let extensionName: String
    let versions: [VSMarketplaceVersion]?
    struct VSMarketplaceVersion: Codable {
        let version: String
        let files: [VSMarketplaceFile]?
    }
    struct VSMarketplaceFile: Codable {
        let assetType: String
        let source: String
    }
}

func searchThemes(query: String) async throws -> [VSMarketplaceExtension] {
    let url = URL(string: "https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json;api-version=3.0-preview.1", forHTTPHeaderField: "Accept")
    
    let payload: [String: Any] = [
        "filters": [
            [
                "criteria": [
                    ["filterType": 8, "value": "Microsoft.VisualStudio.Code"],
                    ["filterType": 10, "value": query],
                    ["filterType": 5, "value": "Themes"]
                ],
                "pageSize": 5,
                "pageNumber": 1
            ]
        ],
        "flags": 914
    ]
    
    request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
    let (data, _) = try await URLSession.shared.data(for: request)
    let decoder = JSONDecoder()
    let marketplaceResponse = try decoder.decode(VSMarketplaceResponse.self, from: data)
    return marketplaceResponse.results?.first?.extensions ?? []
}

Task {
    do {
        let results = try await searchThemes(query: "dracula")
        for ext in results {
            print(ext.extensionName)
        }
    } catch {
        print(error)
    }
    exit(0)
}
RunLoop.main.run()
