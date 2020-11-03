//
//  ContentView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI
import CloudKitMagicCRUD

struct ChatView: View, CKMRecordObserver {
	
	@State var messages:[Message] = []
	@State var newMessageText:String = ""
	
	@State var myName:String = ["Phebe", "Monica", "Rachel", "Joey", "Ross", "Chandler"]
		.randomElement()!  // Gets a random name for user
	@State var statusText = "No new Messages"
	
	@State var showingAlert = false
	@State var textAlert = "Nothing to say"
	
	
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
					receiveMessages()
					setupNotificationManager()
					scrollView.scrollTo(messages.last?.id)
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
		.alert(isPresented: $showingAlert) {
			Alert(title: Text("Warning"),
				  message: Text(textAlert),
				  dismissButton: .default(Text("👍"))) }
		.onAppear { receiveMessages() }
		
	}
	
	func send(_ text:String) {
		guard !text.isEmpty else {return}
		
		// Create a Message and ckSave it in iCloud ☁️
		Message(sender: myName, content: text)
			.ckSave(then: { result in
				switch result {
					case .success(let savedMessage):
						self.messages.append(savedMessage as! Message)
						
					case .failure(let error):
						self.textAlert = """
									Cannot Save new message
									' \(text) '
									\(error.localizedDescription)
									"""
						self.showingAlert = true
				}
			})
	}
	
	func receiveMessages() {
		
		let lastMessageDate = messages.last?.createdAt ?? Date.distantPast
		let createdAfterLast = NSPredicate(format: "creationDate > %@", lastMessageDate as CVarArg)
		
		Message
			.ckLoadAll(sortedBy: ["creationDate"], 			 			   			  predicate: createdAfterLast,
					   then: { result in
						switch result {
							case .success(let loadedMessages):
								// update messages if ok
								let newMessages = (loadedMessages as! [Message])
								guard newMessages.count > 0 else {
									return
								}
								self.messages.append(contentsOf: newMessages)
								self.statusText = "\(newMessages.count) new messages since \(Date().time)"
								
							case .failure(let error):
								debugPrint(error)
								// show alert if not
								self.textAlert = """
									Cannot load messages
									\(error.localizedDescription)
									"""
								self.showingAlert = true
								self.statusText = "Failure attempt to update at \(Date().time)"
						}
					   })
	}
	
	func setupNotificationManager() {
		CKMDefault.notificationManager
			.createNotification(to: self,
								for: Message.self,
								alertBody: "You have new Messages")
	}
	
	// When a new notification comes
	func onChange(ckRecordtypeName: String) {
		receiveMessages()
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
