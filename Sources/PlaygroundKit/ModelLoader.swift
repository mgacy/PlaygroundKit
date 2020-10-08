//
//  X.swift
//  PlaygroundKit
//
//  Created by Mathew Gacy on 10/7/20.
//  Copyright © 2020 Mathew Gacy. All rights reserved.
//

import Foundation

// TODO: make more generic and able to load images / other types

/// Class to load codable model objects from a .json file
public class ModelLoader {

    private let decoder: JSONDecoder

    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    /// Load model specified by enumeration
    /// - Parameter dataFile: enum representing .json files
    ///
    /// Example:
    ///
    ///     enum DataFile {
    ///         case response2  // `/Resources/response2.json`
    ///         case response3  // `/Resources/response3.json`
    ///     }
    ///
    ///     let decoder = JSONDecoder()
    ///     let modelLoader = ModelLoader(decoder: decoder)
    ///     let model = modelLoader.loadModel(dataFile: DataFile.response2)
    ///
    public func loadModel<D: RawRepresentable, M: Decodable>(dataFile: D) -> M? where D.RawValue == String {
        return loadModel(fileName: dataFile.rawValue)
    }

    public func loadModel<M: Decodable>(fileName: String) -> M? {
        guard let data = ModelLoader.loadJSON(from: fileName) else {
            return nil
        }
        do {
            let responseObject = try self.decoder.decode(M.self, from: data)
            return responseObject
        } catch {
            print("ERROR : \(error)")
            return nil
        }
    }

    // MARK: Helper Method

    private static func loadJSON(from fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("ERROR : unable to parse \(fileName).json")
            }
        }
        return nil
    }
}
