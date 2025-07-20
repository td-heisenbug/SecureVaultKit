# SecureVaultKit

A lightweight Swift package for secure offline data storage using Apple’s Keychain.  
Stores and retrieves any `Codable` type securely. All operations are performed **locally** on the device.

## Usage

```swift
import SecureVaultKit

struct Card: Codable {
    let number: String
    let exp: String
    let cvv: String
}

let card = Card(number: "1234...", exp: "12/25", cvv: "123")
let success = KS.s.w(card, k: "c1")

let restored: Card? = KS.s.r(Card.self, k: "c1")
let deleted = KS.s.d(k: "c1")
