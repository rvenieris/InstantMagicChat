//
//  ContentView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI
import UIKit

struct ChatView: View {
	
	@State var messages:[Message] = []
	@State var newMessageText:String = ""
	
	@State var myName:String = ["Phebe", "Monica", "Rachel", "Joey", "Ross", "Chandler"]
								.randomElement()!  // Gets a random name for user
	@State var statusText = "No new Messages"
	
	var body: some View {
		VStack {
			
			// Header
			HStack {
				Button(action: { receiveMessages() },
					   label: {
						Image(systemName: "square.and.arrow.down.on.square.fill").font(.title)
					   })
				Text(statusText).font(.system(size: 10))
				TextField("What's your name", text: $myName).multilineTextAlignment(.trailing)
				ZStack {
					Text("◉").font(.largeTitle).foregroundColor(.green)
					Text(String(myName.first ?? "-"))
				}
			}
			
			
			// Message feed
			ScrollViewReader { scrollView in
				ScrollView {
					ForEach(messages, id: \.self) { message in
						MessageView(myName: $myName, message: message)
					}
				}//.animation(.default)
				.onChange(of: messages, perform: { _ in
					withAnimation {
						scrollView.scrollTo(messages.last?.id)
					}
				})
				.onAppear {
					scrollView.scrollTo(messages.last?.id)
				}
			}
			
			// Botton message sender
			HStack {
				TextField("say something", text: $newMessageText)
				Button(action: {
					send(self.newMessageText)
				},
				label: {
					Image(systemName: "square.and.arrow.up.fill").font(.title)
				})
			}
			
			
		}.padding(.horizontal)
		.onAppear { receiveMessages() }
	}
	
	func send(_ text:String) {
		guard !text.isEmpty else {return}
		
		let newMessage = Message(sender: myName, content: text)
		self.messages.append(newMessage)

	}
	
	func receiveMessages() {
		
		self.messages = mockMessages
	}
	
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
	static var previews: some View {
		let devices = [ //"iPhone 8",
					   "iPhone 12 Pro Max"]
		Group {
			ForEach(devices, id: \.self) { device in
				ChatView()
					.previewDevice(PreviewDevice(rawValue: device))
					.previewDisplayName(device)
			}
		}
	}
}
#endif
