//
//  EasySession.swift
//  EasySession
//
//  Created by Lopez Valenciano, Miguel on 5/25/16.
//  Copyright © 2016 mlvhub. All rights reserved.
//

import SwiftKeychainWrapper

public protocol SessionMappable {
    static func keys() -> [String]
    func toDictionary() -> [String: String]
    init(dictionary: [String: String])
}

public class EasySession<Element: SessionMappable> {
    
    public var state: SessionStatus<Element>
    
    public init() {
        let dictionary = EasySession.retrieve()
        if (dictionary.isEmpty) {
            self.state = .Unauthenticated
        } else {
            self.state = .Authenticated(Element(dictionary: dictionary))
        }
    }
    
    public func authenticate(element: Element) -> SessionStatus<Element> {
        if (self.store(element)) {
            self.state = .Authenticated(element)
        } else {
            self.state = .Unauthenticated
        }
        
        return self.state
    }
    
    public func unauthenticate() -> SessionStatus<Element> {
        switch self.state {
        case .Authenticated(let element):
            self.remove(element)
            self.state = .Unauthenticated
            return self.state
        default:
            return self.state
        }
    }
    
    internal class func retrieve() -> [String: String] {
        return EasySession.keysToDict(Element.keys())
    }
    
    private class func keysToDict(arr: [String], dict: [String: String] = [:]) -> [String: String] {
        guard let head = arr.first else {
            return dict
        }
        
        var new_dict = dict
        new_dict[head] = KeychainWrapper.stringForKey(head)
        return keysToDict(Array(arr[1..<arr.count]), dict: new_dict)
    }
    
    public func store(state: Element) -> Bool {
        return state.toDictionary()
            .map { (key, value) in KeychainWrapper.setString(value, forKey: key) }
            .reduce(true, combine: { $0 && $1 })
    }
    
    public func remove(state: Element) -> Bool {
        return state.toDictionary()
            .map { (key, _) in KeychainWrapper.removeObjectForKey(key) }
            .reduce(true, combine: { $0 && $1 })
    }
    
}