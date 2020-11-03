//
//  MessageView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI

struct MessageView: View {
	
	static let othersColors:[Color] =  [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)].map{Color($0)}
	
	static var peopleColor:[String:Color] = [:]
	
	@Binding var myName:String
	var message:Message
	var itsMe:Bool { return message.sender == myName }
	
	var body: some View {
		
		ZStack {
			
			RoundedRectangle(cornerRadius: 20)
				.foregroundColor(self.itsMe ? .green : peopleColor(self.message.sender))
			VStack {
				Text(message.sender)
					.lineLimit(1)
				Text(message.content)
					.font(.system(size: 20))
					.frame(maxWidth: .infinity, alignment: .leading)
					.fixedSize(horizontal: false, vertical: true)
				HStack {
					Text(message.timestamp.day)
						.font(.system(size: 12))
					Spacer()
					Text(message.timestamp.time)
						.font(.system(size: 12))
				}
				.frame(maxWidth: .infinity, alignment: .trailing)
				.padding(.bottom, 10)
			}
			.minimumScaleFactor(1)
			.padding(.horizontal)
		}
		.padding(itsMe ? .leading :.trailing, 20.0)
		.minimumScaleFactor(0.1)
		.animation(.default)
		.id(message.id)
	}
	
	
	func peopleColor(_ name:String)->Color {
		Self.peopleColor[name] = Self.peopleColor[name] ?? Self.othersColors[Self.peopleColor.count % Self.othersColors.count]
		return Self.peopleColor[name]!
	}
}

struct MessageView_Previews: PreviewProvider {
	@State static var myName:String = "Joey"
    static var previews: some View {
		
		ScrollView(.vertical) {
			MessageView(myName: $myName, message:Message(sender: "Joey", content: "How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? "))
			MessageView(myName: $myName, message:Message(sender: "Monica", content: "How YOU doin'?"))
			MessageView(myName: $myName, message:Message(sender: "Chandler", content: "How YOU doin'?"))
			MessageView(myName: $myName, message:Message(sender: "Ross", content: "How YOU doin'?"))

		}
    }
}
