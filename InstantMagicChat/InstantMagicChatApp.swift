//
//  InstantMagicChatApp.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI
import CloudKitMagicCRUD

@main
struct InstantMagicChatApp: App {
	@Environment(\.scenePhase) private var scenePhase
    init() {
        CKMDefault.containerIdentifier = "iCloud.ADA_Test_Projects"
//        CKMDefault.containerIdentifier = "iCloud.ADALab_Device_Controller"
            //"iCloud.PUC.CloudTest"
        
    }
    
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
