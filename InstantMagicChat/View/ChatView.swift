//
//  ContentView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI

struct ChatView: View {
	@State var myName:String = "Joey Tribbiani"
	@State var messages:[Message] = [
		Message(sender: "Joey Tribbiani", content: "How YOU doin'? "),
		Message(sender: "Ricardo Venieris", content: "How YOU doin'? "),
		Message(sender: "Joey Tribbiani", content: "How YOU doin'? "),
	]
	
	var body: some View {
		VStack {
			TextField("What's your name", text: $myName)
			List {
				ForEach(messages, id: \.self) { message in
					MessageView(myName: $myName, message: message)
				}.padding(0)
			}.padding(0)
			.onTapGesture{
				messages.append(Message(sender: "Ricardo Venieris", content: "How YOU doin'? "))
				messages.append(Message(sender: "Joey Tribbiani", content: "How YOU doin'? "))
			}
			.animation(.default)
			TextField("say something", text: $myName)

			
		}
	}
}

struct ChatView_Previews: PreviewProvider {
	static var previews: some View {
		ChatView()
	}
}
