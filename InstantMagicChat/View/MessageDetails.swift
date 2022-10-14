//
//  MessageDetails.swift
//  SwiftUIChat
//
//  Created by Pedro Peçanha on 14/10/22.
//

import SwiftUI

struct MessageDetails: View {
    
    var message:Message
    var body: some View {
        VStack{
            List{
                Section(header: Text("Data de Criação")){
                    Text(message.timestamp, style: .date)
                }
                Section(header: Text("Hora de Criação")){
                    Text(message.timestamp, style: .time)
                }
                Section(header: Text("Id da Mensagem")){
                    Text(message.id)
                }
                Section(header: Text("Remetente")){
                    Text(message.sender)
                }
                Section(header: Text("Conteúdo")){
                    Text(message.content)
                }
            }
        }.navigationTitle("Detalhes da Mensagem")
    }
}
