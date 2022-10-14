//
//  ContentView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI
import UIKit
import CloudKitMagicCRUD
struct ChatView: View {
	@State var myName:String = "Joey Tribbiani"
	@State var messages:[Message]
	@State var newMessageText:String = ""
    
    var body: some View {
        
        NavigationView{
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
                            NavigationLink(destination: MessageDetails(message: message), label: {
                                MessageView(myName: $myName,message: message)
                                    .id(message.id)
                            })
                        }.padding(0)
                    }.padding(0)
                        .animation(.default)
                        .onChange(of: messages, perform: { _ in
                            withAnimation {
                                guard let id = messages.last?.id else{return}
                                scrollView.scrollTo(id)
                            }
                        })
                        .onAppear {
                            receiveMessages()
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
                }
                .animation(.default)
        }.buttonStyle(.plain)
    }
	
	func send(_ message:String) {
        let senders = ["Joey", "Rachel", "Ross", "Monica", "Chandler", "Phoebe", myName]
        let ind = self.messages.count % senders.count
        let sender = senders[ind]
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
	
	
	
	func receiveMessages() {
		Message.ckLoadAll(then: { result in
			switch result {
				case .success(let loadedMessages):
					self.messages = (loadedMessages as? [Message]) ?? self.messages
					self.messages.sort {$0.timestamp < $1.timestamp}
				case .failure(let error):
					debugPrint("Cannot load new messages")
					debugPrint(error)
			}
		})
		
	}
}

//struct ChatView_Previews: PreviewProvider {
//	static var previews: some View {
//		let messages:[Message] = [
//			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "1 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
//			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "2 How YOU doin'? "),
//			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "3 How YOU doin'? "),
//			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "S 1234"),
//			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "4 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
//			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "1 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
//			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "2 How YOU doin'? "),
//			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "3 How YOU doin'? "),
//			Message(recordName:UUID().uuidString, sender: "Ricardo Venieris", content: "S 1234"),
//			Message(recordName:UUID().uuidString, sender: "Joey Tribbiani", content: "4 How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? 1How YOU doin'? "),
//		]
//		ChatView(messages: messages)
//	}
//}
