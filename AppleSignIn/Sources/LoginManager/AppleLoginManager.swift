// Copyright (c) 2019 Anton Vizgin

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import AuthenticationServices

public typealias AppleLoginCredentialsStateDidChangeCompletion = (AppleLoginManagerCredentialsState?, Error?) -> Void

/// Class that provies all the logic with login with Apple functionality.
@available(iOS 13, *)
public class AppleLoginManager: NSObject {
    
    public var delegate: AppleLoginDelegate?
    
    /// Function used to perform login request.
    ///
    /// - Parameter view: A view that should present Apple ID sign In window.
    @available(iOS 13, *)
    public func performAppleLoginRequest(in view: UIWindow) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])

        controller.delegate = self
        controller.presentationContextProvider = view
        
        controller.performRequests()
    }
    
    /// Function used to check the credential state changes.
    @available(iOS 13, *)
    public func checkLoginCredentialsState(_ userId: String, completion: @escaping AppleLoginCredentialsStateDidChangeCompletion) {
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: userId) {
            if let error = $1 {
                completion(nil, error)
                return
            }
            
            guard let newState = AppleLoginManagerCredentialsState(rawValue: $0.rawValue) else { return }
            
            completion(newState, nil)
        }
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credentials = authorization.credential as? ASAuthorizationAppleIDCredential {
            delegate?.didCompleteAuthorizationWith(user: AppleUser(credentials))
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        delegate?.didCompleteAuthorizationWith(error: error)
    }
}
