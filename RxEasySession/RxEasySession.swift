//
//  RxEasySession.swift
//  EasySession
//
//  Created by Lopez Valenciano, Miguel on 5/25/16.
//  Copyright © 2016 mlvhub. All rights reserved.
//

import EasySession
import RxSwift

import Foundation

public class RxEasySession<Element: SessionMappable> : EasySession<Element> {
 
    public var rx_state: Variable<SessionStatus<Element>>!
    
    public override init() {
        super.init()
        
        self.rx_state = Variable<SessionStatus<Element>>(self.state)
    }
    
    public override func authenticate(element: Element) -> SessionStatus<Element> {
        let result = super.authenticate(element)
        self.rx_state.value = result
        return result
    }
    
    public override func unauthenticate() -> SessionStatus<Element> {
        let result = super.unauthenticate()
        self.rx_state.value = result
        return result
    }
}