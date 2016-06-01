//
//  SessionStatus.swift
//  EasySession
//
//  Created by Lopez Valenciano, Miguel on 5/25/16.
//  Copyright © 2016 mlvhub. All rights reserved.
//

import Foundation

public enum SessionStatus<Element: SessionMappable> : Equatable {
    case Authenticated(Element)
    case Unauthenticated
}

public func ==<Element : SessionMappable>(lhs: SessionStatus<Element>, rhs: SessionStatus<Element>) -> Bool {
    switch (lhs, rhs) {
    case (SessionStatus.Authenticated(let e1), SessionStatus.Authenticated(let e2)):
        return e1.toDictionary() == e2.toDictionary()
    case (SessionStatus.Unauthenticated, SessionStatus.Unauthenticated):
        return true
    default:
        return false
    }
}