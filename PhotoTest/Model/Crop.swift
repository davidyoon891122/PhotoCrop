//
//  Crop.swift
//  PhotoTest
//
//  Created by Jiwon Yoon on 4/1/25.
//

import Foundation

enum Crop: Equatable {
    case circle
    case rectangle
    case square
    case custom(CGSize)
}

extension Crop {

    func name() -> String {
        switch self {
        case .circle:
            "Cricle"
        case .rectangle:
            "Rectangle"
        case .square:
            "Square"
        case .custom(let cGSize):
            "Custom \(Int(cGSize.width))X\(Int(cGSize.height))"
        }
    }

    func size() -> CGSize {
        switch self {
        case .circle:
            .init(width: 300, height: 300)
        case .rectangle:
            .init(width: 300, height: 500)
        case .square:
            .init(width: 300, height: 300)
        case .custom(let cGSize):
            cGSize
        }
    }

}


