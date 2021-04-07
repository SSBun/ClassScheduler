//
//  DragDropData.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import SwiftUI
import Combine
import UniformTypeIdentifiers

protocol DragDropAvailable: Codable {
    static var dataIdentifier: String { get }
}

extension DragDropAvailable {
    static var uttypeIdentifiers: [String] { [UTType(filenameExtension: dataIdentifier)!.identifier] }
}

extension Sequence where Element == DragDropAvailable.Type {
    var uttypeIdentifiers: [String] { self.flatMap({ $0.uttypeIdentifiers }) }
}

class DragDropData<DataType: DragDropAvailable>: NSObject, NSItemProviderWriting, NSItemProviderReading {
    let data: DataType
    
    var itemProvider: NSItemProvider { .init(object: self) }
    
    init(_ data: DataType) {
        self.data = data
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        DataType.uttypeIdentifiers
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        do {
            let result = try data.pack()
            completionHandler(result, nil)
        } catch(let error) {
            completionHandler(nil, error)
        }
        return nil
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        DataType.uttypeIdentifiers
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        let result = try DataType.unpack(data)
        return DragDropData(result) as! Self
        
    }
}

/// A drop delegator that can receipt one type data.
struct DropDelegator<DataType: DragDropAvailable>: DropDelegate {
    var isEnabled: Bool
    var isEntered: Binding<Bool>?
    var receiptDataCallback: ((DataType) -> Void)?
    var types: [DragDropAvailable.Type] = []
    
    init(isEnabled: Bool = true, isEntered: Binding<Bool>? = nil, receiptData: @escaping (DataType) -> Void) {
        self.isEnabled = isEnabled
        self.isEntered = isEntered
        self.receiptDataCallback = receiptData
    }
    
    func validateDrop(info: DropInfo) -> Bool {
        guard isEnabled else { return false }
        return info.hasItemsConforming(to: DataType.uttypeIdentifiers)
    }
    
    func dropEntered(info: DropInfo) {
        isEntered?.wrappedValue = true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if let item = info.itemProviders(for: DataType.uttypeIdentifiers).first {
            item.loadObject(ofClass: DragDropData<DataType>.self) { (item, error) in
                if let result = item as? DragDropData<DataType> {
                    receiptDataCallback?(result.data)
                }
            }
        }
        return true
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return nil
    }
    
    func dropExited(info: DropInfo) {
        isEntered?.wrappedValue = false
    }
}

/// A drop delegator that can receipt multiple types data.
struct DropGroupDelegator: DropDelegate {
    typealias Callback = (NSItemProviderReading) -> Void
    var isEnabled: Bool
    var isEntered: Binding<Bool>?
    private var callbacks: [(DragDropAvailable.Type, NSItemProviderReading.Type, Callback)]
    let dataUTTtypes: [String]
    
    init(isEnabled: Bool = true, isEntered: Binding<Bool>? = nil, dropCallbacks: (DragDropAvailable.Type, NSItemProviderReading.Type, Callback)...) {
        self.isEnabled = isEnabled
        self.isEntered = isEntered
        callbacks = dropCallbacks
        dataUTTtypes = callbacks.flatMap { $0.0.uttypeIdentifiers }
    }
    
    func validateDrop(info: DropInfo) -> Bool {
        guard isEnabled else { return false }
        return info.hasItemsConforming(to: dataUTTtypes)
    }
    
    func dropEntered(info: DropInfo) {
        isEntered?.wrappedValue = true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if let item = info.itemProviders(for: dataUTTtypes).first {
            for (_, providerType, callback) in callbacks {
                item.loadObject(ofClass: providerType) { (item, error) in
                    if let result = item {
                        callback(result)
                    }
                }
            }
        }
        return true
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return nil
    }
    
    func dropExited(info: DropInfo) {
        isEntered?.wrappedValue = false
    }
}

extension View {
    func onDrop(_ delegator: DropGroupDelegator) -> some View {
        self
            .onDrop(of: delegator.dataUTTtypes, delegate: delegator)
    }
}
