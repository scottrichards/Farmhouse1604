//
//  Result.swift
//  TruColoriOS
//
//  Created by Scott Richards on 2/16/22.
//

import Foundation


enum Result<T> {
    case Success(T)
    case Failure(Error)
}
