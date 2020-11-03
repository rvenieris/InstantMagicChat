//
//  InstantMagicChatApp.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI

@main
struct InstantMagicChatApp: App {
	@Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
			ChatView(messages: [])
		}
		.onChange(of: scenePhase) { phase in
			switch phase {
				
				case .background:
					break
				case .inactive:
					break
				case .active:
					break
				@unknown default:
					break
			}
		}
    }
}
