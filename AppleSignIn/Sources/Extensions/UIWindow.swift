//
//  UIWindows.swift
//  AppleSignIn
//
//  Created by Anton Vizgin on 6/11/19.
//  Copyright © 2019 Apple Sign In. All rights reserved.
//

import Foundation

extension UIWindow: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self
    }
}
