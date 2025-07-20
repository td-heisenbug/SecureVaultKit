import Foundation
import Security

public final class KS {

    public static let s = KS()

    private let enc = JSONEncoder()
    private let dec = JSONDecoder()

    @discardableResult
    public func w<T: Encodable>(_ v: T, k: String) -> Bool {
        guard let d = try? enc.encode(v) else { return false }

        let q: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: k,
            kSecValueData as String: d,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]

        SecItemDelete(q as CFDictionary)
        let s = SecItemAdd(q as CFDictionary, nil)
        return s == errSecSuccess
    }

    public func r<T: Decodable>(_ t: T.Type, k: String) -> T? {
        let q: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: k,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var o: AnyObject?
        let s = SecItemCopyMatching(q as CFDictionary, &o)

        guard s == errSecSuccess, let d = o as? Data else { return nil }
        return try? dec.decode(t, from: d)
    }

    @discardableResult
    public func d(k: String) -> Bool {
        let q: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: k
        ]

        return SecItemDelete(q as CFDictionary) == errSecSuccess
    }
}
