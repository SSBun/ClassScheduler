//
//  DragDropData.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import SwiftUI
import Combine

class DragDropData<DataType: Codable>: NSObject, NSItemProviderWriting, NSItemProviderReading {
    let data: DataType
    
    var itemProvider: NSItemProvider { .init(object: self) }
    
    init(_ data: DataType) {
        self.data = data
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        [kUTTypeData as String]
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
        [kUTTypeData as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        let result = try DataType.unpack(data)
        return DragDropData(result) as! Self
                
    }
}

struct DropDelegator<DataType: Codable>: DropDelegate {
    var isEnabled: Bool
    var isEntered: Binding<Bool>?
    var receiptDataCallback: ((DataType) -> Void)?
    
    init(isEnabled: Bool = true, isEntered: Binding<Bool>? = nil, receiptData: @escaping (DataType) -> Void) {
        self.isEnabled = isEnabled
        self.isEntered = isEntered
        self.receiptDataCallback = receiptData
    }
    
    func validateDrop(info: DropInfo) -> Bool {
        guard isEnabled else { return false }
        return info.hasItemsConforming(to: DragDropData<DataType>.readableTypeIdentifiersForItemProvider)
    }
   
    func dropEntered(info: DropInfo) {
        isEntered?.wrappedValue = true
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if let item = info.itemProviders(for: DragDropData<DataType>.readableTypeIdentifiersForItemProvider).first {
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
