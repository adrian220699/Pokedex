//
//  ViewState.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/22/26.
//

import Foundation

enum ViewState<T> {

    case idle

    case loading

    case success(T)

    case error(Error)
}
