//
//  Message.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import Foundation

struct Message:Hashable{
	var id:String { String(self.hashValue) }
	var timestamp:Date  = Date()
	var sender:String
	var content:String
	
}
