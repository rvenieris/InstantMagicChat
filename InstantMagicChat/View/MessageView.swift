//
//  MessageView.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 23/09/20.
//

import SwiftUI

class NamedColor:UIColor {

    static let myColor:UIColor =  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    static let guestColors:[UIColor] = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                                 #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
                                 #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)]
    static var guestNames:[String:UIColor] = [:]
    
    static func color(for name:String, itsMe:Bool)->UIColor {
        if itsMe {return myColor }
        guard let resultColor = guestNames[name] else {
            let resultColor = guestColors[guestNames.count % guestColors.count]
            guestNames[name] = resultColor
            return resultColor
        }
        return resultColor
    }
}

struct MessageView: View {
	
	@Binding var myName:String
	var message:Message
	var itsMe:Bool { return message.sender == myName }
    
	var body: some View {
		
		ZStack {
			
			RoundedRectangle(cornerRadius: 20)
				.foregroundColor(color(for: message.sender))
			VStack {
				Text(message.sender)
					.lineLimit(1)
				Text(message.content)
					.font(.system(size: 20))
					.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
					.fixedSize(horizontal: false, vertical: true)
				HStack {
					Text(message.timestamp.day)
						.font(.system(size: 12))
					Spacer()
					Text(message.timestamp.time)
						.font(.system(size: 12))
				}
				.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
				.padding(.bottom, 10)
			}.minimumScaleFactor(1)
			.padding(.horizontal)
		}.padding(itsMe ? .leading :.trailing, 20.0)
		.minimumScaleFactor(0.1)
		.animation(.default)
	}
    
    func color(for name:String)->Color {
        return Color(NamedColor.color(for: name, itsMe: self.itsMe))
    }
}
//
//struct MessageView_Previews: PreviewProvider {
//	@State static var myName:String = "Joey Tribbiani"
//    static var previews: some View {
//		MessageView(myName: $myName, message:Message(sender: "Joey Tribbiani", content: "How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? How YOU doin'? "))
//    }
//}
