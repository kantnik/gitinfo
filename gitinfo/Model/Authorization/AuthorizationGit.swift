//
//  AuthorizationGit.swift
//  gitinfo
//
//  Created by Anton on 10/12/22.
//

import Foundation

class AuthorizationGit
{
    public let clientId = "b0c5fd1375398fb7691c"
    public let schemeUrl = "ru.kan.lab"
    public let baseUrl = "https://github.com/"
    public let oauthUrl = "login/oauth/authorize?scope=user:email&client_id="
    private let redirectUrl = "ru.kan.lab://callback"
    private let clientSecret = "2ef5491576aa8e9cc7ca69f34b4ea82c655c94dd"
    private let accessTokenUrl = "login/oauth/access_token"
    private let session = URLSession.shared
    private var token: AccessToken?
    
    func getToken() -> AccessToken?
    {
        return token
    }
    
    func loadAccessToken(code: String) async throws -> Bool
    {
        guard let url = URL(string: baseUrl + accessTokenUrl) else
        {
            throw LoaderErrors.invalidURL
        }
        
        let dataClient = ClientSecret(clientId: clientId,
                                      clientSecret: clientSecret,
                                      code: code,
                                      redirectUrl: redirectUrl)
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonData = try encoder.encode(dataClient)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        let (data, _) = try await session.data(for: request)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        token = try decoder.decode(AccessToken.self, from: data)
        
        return true
    }
}

extension URL
{
    func valueOf(_ parameterName: String) -> String?
    {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == parameterName })?.value
    }
}
