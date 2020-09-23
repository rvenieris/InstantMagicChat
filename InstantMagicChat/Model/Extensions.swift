//
//  Extensions.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import Foundation


extension Date {
	var time:String {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		return formatter.string(from: self)
	}
	var day:String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd"
		return formatter.string(from: self)
	}
}
