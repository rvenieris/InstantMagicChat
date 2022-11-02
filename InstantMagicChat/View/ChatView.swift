//
//  ContentView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI
import UIKit
import CloudKitMagicCRUD

struct ChatView: View, CKMRecordObserver {
	@State var myName:String = "Joey Tribbiani"
	@State var messages:[Message]
	@State var newMessageText:String = ""
    
	var body: some View {
		VStack {
			HStack {
				Button(action: { receiveMessages() },
					   label: {
						Image(systemName: "square.and.arrow.down.on.square.fill").font(.title)
					   })
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
						MessageView(myName: $myName, message: message).id(message.id)					}.padding(0)
				}.padding(0)
				.animation(.default)
				.onChange(of: messages, perform: { _ in
					withAnimation {
						scrollView.scrollTo(messages.last?.id)
					}
				})
				.onAppear {
					scrollView.scrollTo(messages.last?.id)
                    Message.register(observer: self)
				}
			}
			
			// Botton message sender
			HStack {
				TextField("say something", text: $newMessageText)
				Button(action: {
					send(self.newMessageText)
					self.newMessageText = ""
				},
				label: {
					Image(systemName: "square.and.arrow.up.fill").font(.title)
				})
			}
			
			
		}.padding(.horizontal)
		.onAppear {
            receiveMessages()
            createNotification()
        }
		.animation(.default)
	}
	
	func send(_ message:String) {
        let sender = myName
        let content = message.isEmpty ? "Hi! I'm \(sender)" : message
		let newMessage = Message(sender: sender, content: content)
//		print(newMessage)
			newMessage.ckSave(then: { result in
				switch result {
					case .success(let savedMessage):
                        guard let savedMessage = savedMessage as? Message else {return}
						self.messages.append(savedMessage)
//                        print(self.messages.count, savedMessage.content)
					case .failure(let error):
						debugPrint("Cannot Save new message \(message)")
						debugPrint(error)
				}
			})
		
	}
	
    func createNotification() {
        CKMDefault.notificationManager.createNotification(to:self, for: Message.self) {
            result in
            switch result {
                case .success( _):
//                    debugPrint(subscription)
                    break
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
	
	func receiveMessages() {
		Message.ckLoadAll(then: { result in
			switch result {
				case .success(let loadedMessages):
					print(loadedMessages)
					self.messages = (loadedMessages as? [Message]) ?? self.messages
					self.messages.sort {$0.createdAt < $1.createdAt}
				case .failure(let error):
					debugPrint("Cannot load new messages")
					debugPrint(error)
			}
		})
		
	}
    
    func onReceive(notification: CloudKitMagicCRUD.CKMNotification) {
        if #available(iOS 15.0, *) {
            print("New Message at \(notification.date.formatted(date: .omitted, time: .complete))")
            print(notification.body, notification.title, notification.userID ?? "")
        } else {
            print("New Message at \(notification.date)")
        }
        
        receiveMessages()
    }

}

struct ChatView_Previews: PreviewProvider {
	static var previews: some View {
		let messages:[Message] = [
			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "1 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "2 How YOU doin'? "),
			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "3 How YOU doin'? "),
			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "S 1234"),
			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "4 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "1 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "2 How YOU doin'? "),
			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "3 How YOU doin'? "),
			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "S 1234"),
			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "4 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
		]
		ChatView(messages: messages)
	}
}
