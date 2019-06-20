[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AppleSignIn.svg)](https://cocoapods.org/pods/AppleSignIn)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/AppleSignIn.svg?style=flat)](https://github.com/AntonReality/AppleSignIn)
[![Facebook](https://img.shields.io/badge/facebook-@antonvofficial-blue.svg?style=flat)](https://facebook.com/antonvofficial)
[![Open Source Helpers](https://www.codetriage.com/antonreality/applesignin/badges/users.svg)](https://www.codetriage.com/antonreality/applesignin)

**AppleSignIn** is the fast and easy way to implement ***Sign in with Apple*** introduced on Apple WWDC 2019.

**⚠️⚠️⚠️ WARNING ⚠️⚠️⚠️** **Sign in with Apple** is still in **BETA**. Everything in this library is tested and working but still can have unexpected results. Please, be careful.

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Contribution](#contribution)
- [License](#license)

## Features

- [x] Initialization `Sign in with Apple` button from code.
- [ ] Initialization `Sign in with Apple` from storyboard or xib.
- [x] Login with `default` button.
- [x] Login with `custom` button.
- [x] Add `Cocoapods` support.
- [x] Add `Cartage` support.

## Requirements

- iOS 13.0+
- Xcode 11.0+
- Swift 5+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate AppleSignIn into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'AppleSignIn'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate AppleSignIn into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "AntonReality/AppleSignIn" "0.0.1"
```

### Manually

If you prefer not to use any of the dependency mentioned above, you can integrate AppleSignIn into your project manually. Just drag & drop the `Sources` folder to your project.

## Usage

**Pre-requirments**:
- Set your development team in the **Signing & Capabilities** tab so Xcode can create a provisioning profile that uses the Sign In with Apple capability.
- Add **Sign In with Apple** capability.
- Choose a target device that you’re signed into with an Apple ID that uses Two-Factor Authentication.

### Adding ***Sign in with Apple*** with default button.

```swift
import AppleSignIn

let button = AppleLoginButton()
button.delegate = self

view.addSubview(button)
```

Implement delegate methods to receive user and handle errors.
```swift
func didCompleteAuthorizationWith(user: AppleUser) {
    // Do any additional stuff with your backend.
}

func didCompleteAuthorizationWith(error: Error) {
    // Handle error.
}
```

### Adding ***Sign in with Apple*** with a custom action/button.

```swift
import AppleSignIn

guard let window = view.window else { return }

let appleLoginManager = AppleLoginManager()
appleLoginManager.delegate = self

appleLoginManager.performAppleLoginRequest(in: window)
```

`performAppleLoginRequest` requires to specify `window` where **Apple Sign In** screen should be presented.

Implement delegate methods to receive user and handle errors.
```swift
func didCompleteAuthorizationWith(user: AppleUser) {
    // Do any additional stuff with your backend.
}

func didCompleteAuthorizationWith(error: Error) {
    // Handle error.
}
```

### That's it!

Easy right? For more details check `ExampleProject`.

## Contribution

Feel free to add your comments/commits/pull requests. Any additional help is appreciated.

## License

AppleSignIn is released under the MIT license. [See LICENSE](https://github.com/AntonReality/AppleSignIn/blob/master/LICENSE) for details.
