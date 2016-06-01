//
//  EasySessionTests.swift
//  EasySessionTests
//
//  Created by Lopez Valenciano, Miguel on 5/25/16.
//  Copyright © 2016 mlvhub. All rights reserved.
//

import Quick
import Nimble
@testable import EasySession

class EasySessionSpec: QuickSpec {
    
    override func spec() {
        
        var sut: EasySession<User>!
        
        beforeEach {
            sut = EasySession<User>()
        }
        
        afterEach {
            sut.unauthenticate()
            sut = nil
        }
        
        it("should not have state at the beginning if no previous session exists") {
            expect(sut.state) == SessionStatus.Unauthenticated
        }
        
        it("should authenticate correctly") {
            let user = User(id: 1, email: "john.doe@example.com", name: "John Doe")
            
            sut.authenticate(user)
            
            expect(sut.state) == SessionStatus.Authenticated(user)
        }
        
        it("should unauthenticate correctly") {
            let user = User(id: 1, email: "john.doe@example.com", name: "John Doe")
            
            sut.authenticate(user)
            
            expect(sut.state) == SessionStatus.Authenticated(user)
            
            sut.unauthenticate()
            
            expect(sut.state) == SessionStatus.Unauthenticated
        }
        
        it("should load previous sessions correctly") {
            let user = User(id: 1, email: "john.doe@example.com", name: "John Doe")
            
            sut.authenticate(user)
            
            expect(sut.state) == SessionStatus.Authenticated(user)

            sut = nil
            sut = EasySession<User>()
            
            expect(sut.state) == SessionStatus.Authenticated(user)
        }
        
        it("dummy test to avoid a bug where the last test is not reported") {}
        
    }
    
}

