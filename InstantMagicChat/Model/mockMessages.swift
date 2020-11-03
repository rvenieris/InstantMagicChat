//
//  mockMessages.swift
//  InstantMagicChat
//
//  Created by Ricardo Venieris on 29/10/20.
//

import Foundation


let mockMessages:[Message] = {
	let dialog =
		"""
		Joey: Oh-oh-oh-oh, how I do it is, I look a woman up and down and say, "Hey, how you doin’?"

		Phoebe: Oh, please!

		Joey: Hey, how you doin’?

		Jill: He has the most amazing Porsche under there!

		Joey: I’d love to show ya, but I just tucked her in. She’s sleeping. (The women both laugh) Hey uh, would you two girls like to go for a drink? (Just then the same guy with the football dives to make a catch, lands on the car cover, and collapses it. It turns out that Joey set up a bunch of boxes to make it look like a Porsche.)

		Jill: Hi, is Rachel here? I’m her sister.

		Rachel: Oh my God, Jill!

		Jill: Oh my God, Rachel!

		Chandler: Oh my God, introduce us!

		Rachel: This is Chandler. (Points at him.)

		Jill: Hi!

		Rachel: And you know Monica and Ross!
		""".split(separator: "\n").filter {!$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
	
	return dialog.map { text in
		let line = text.split(separator: ":", maxSplits: 2)
		return Message(sender: String(line[0]),
					   content: String(line[1]))
	}
}()
