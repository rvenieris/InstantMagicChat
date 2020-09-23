//
//  MessageView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI

struct MessageView: View {
	
	@Binding var myName:String
	var message:Message
	
	var itsMe:Bool {
		return message.sender == myName
	}
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.foregroundColor(self.itsMe ? .green : .gray)
			VStack {
				Text(message.sender)
					Text(message.content)
						.font(.system(size: 20))
						.padding(.horizontal)
						.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
						.multilineTextAlignment(.leading)
						.lineLimit(.max)
//						.minimumScaleFactor(1)
				
				
				HStack {
					Text(message.timestamp.day).font(.system(size: 12))
					Spacer()
					Text(message.timestamp.time).font(.system(size: 12))
				}.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
				.padding(.horizontal, 10.0)
			}.minimumScaleFactor(0.1)
		}.padding(itsMe ? .leading :.trailing, 20.0)
		//		.onTapGesture {
		//			self.isExpanded.toggle()
		//		}
		
		
		.minimumScaleFactor(0.1)
		.aspectRatio(contentMode: .fit)
	}
}

struct MessageView_Previews: PreviewProvider {
	@State static var myName:String = "Joey Tribbiani"
    static var previews: some View {
		MessageView(myName: $myName, message:Message(sender: "Joey Tribbiani", content: "How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? "))
    }
}
