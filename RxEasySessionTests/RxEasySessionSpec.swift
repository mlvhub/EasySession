//
//  RxEasySessionSpec.swift
//  EasySession
//
//  Created by Lopez Valenciano, Miguel on 5/27/16.
//  Copyright © 2016 mlvhub. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import RxSwift
import RxCocoa
import RxTests
import EasySession
@testable import RxEasySession

class RxEasySessionSpec: QuickSpec {
    
    override func spec() {
        
        var sut: RxEasySession<User>!
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            driveOnScheduler(scheduler) {
                sut = RxEasySession<User>()
            }
            disposeBag = DisposeBag()
        }
        
        afterEach {
            scheduler = nil
            sut.unauthenticate()
            sut = nil
            disposeBag = nil
        }
        
        it("should not have state at the beginning if no previous session exists test") {
            
            let observer = scheduler.createObserver(SessionStatus<User>)
            
            sut.rx_state.asObservable().subscribe(observer).addDisposableTo(disposeBag)
            
            scheduler.start()
            
            let expectedEvents: [Recorded<Event<SessionStatus<User>>>] = [
                next(0, SessionStatus.Unauthenticated)
            ]
            
            XCTAssertEqual(observer.events, expectedEvents)
            
        }
        
        it("should sent events correctly when authentication is performed") {
            let user = User(id: 1, email: "john.doe@example.com", name: "John Doe")
            
            let observer = scheduler.createObserver(SessionStatus<User>)
            
            sut.rx_state.asObservable().subscribe(observer).addDisposableTo(disposeBag)
            
            
            scheduler.scheduleAt(200) {
                sut.authenticate(user)
            }
            
            scheduler.start()
            
            let expectedEvents: [Recorded<Event<SessionStatus<User>>>] = [
                next(0, SessionStatus.Unauthenticated),
                next(200, SessionStatus.Authenticated(user))
            ]
            
            XCTAssertEqual(observer.events, expectedEvents)

        }
        
        it("dummy test to avoid a bug where the last test is not reported") {}
        
    }
    
}

