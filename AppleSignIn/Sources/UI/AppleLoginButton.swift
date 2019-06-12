// Copyright (c) 2019 Anton Vizgin

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import AuthenticationServices

/// Application login button.
/// Used for all login process.
@available(iOS 13, *)
public class AppleLoginButton: ASAuthorizationAppleIDButton {
    
    public var delegate: AppleLoginButtonDelegate?
    
    private lazy var loginManager = AppleLoginManager()
    
    /// Initialization.
    ///
    /// - Parameters:
    ///     - authorizationButtonType: Button type. See `AppleLoginButtonType`. Default is `.signUp`.
    ///     - authorizationButtonStyle: Button style. See `AppleLoginButtonStyle`. Default is `.white`.
    public init(authorizationButtonType type: AppleLoginButtonType = .signUp, authorizationButtonStyle style: AppleLoginButtonStyle = .white) {
        super.init(authorizationButtonType: ButtonType(rawValue: type.rawValue) ?? .default, authorizationButtonStyle: ButtonStyle(rawValue: style.rawValue) ?? .white)
        
        addTarget(self, action: #selector(AppleLoginButton.performAppleLogin), for: .touchUpInside)
        
        loginManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Performs login
    @objc public func performAppleLogin() {
        guard let window = superview?.window else { return }
        
        loginManager.performAppleLoginRequest(in: window)
    }
    
    //MARK: - Check current login state
    @available(iOS 13, *)
    public func checkLoginCredentialsState(_ userId: String, completion: @escaping AppleLoginCredentialsStateDidChangeCompletion) {
        loginManager.checkLoginCredentialsState(userId, completion: completion)
    }
}

//MARK: - AppleLoginManagerDelegate
extension AppleLoginButton: AppleLoginManagerDelegate {
    public func didCompleteAuthorizationWith(user: AppleUser) {
        delegate?.didCompleteAuthorizationWith(user: user)
    }
    
    public func didCompleteAuthorizationWith(error: Error) {
        delegate?.didCompleteAuthorizationWith(error: error)
    }
}
