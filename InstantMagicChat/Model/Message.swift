//
//  Message.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import Foundation
import CloudKitMagicCRUD

struct Message:CKMRecord {
	var recordName: String?
	var sender:String
	var content:String
	var timestamp:Date = Date()
	var id:String {self.recordName ?? String(self.hashValue)}
	var minhamusiquinha:[Data]
}
