//
//  ContentView.swift
//  Note
//
//  Created by Hugo López on 23-06-24.
//

import SwiftUI

struct ContentView: View {
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NoteViewModel()
    

    var body: some View {
        VStack {
            VStack{
                TextField(text: $descriptionNote, prompt: Text("Ingresa una nueva tarea").bold()){}
                    .padding()
                    .frame(height: 70)
                    .background(.background1)
                    .cornerRadius(16)
                Button(action: {
                    if descriptionNote != "" {
                            notesViewModel.saveNote(description: descriptionNote)
                            descriptionNote = ""}
                },
                       label: {
                    Text("Crear")
                        .foregroundStyle(.black.opacity(0.6))
                        .padding(20)
                        .background(.color3)
                        .cornerRadius(16)
                })
                Spacer()
            }
            .shadow(radius: 10)
            .frame(maxWidth: .infinity, maxHeight: 125)
            .padding()
            
            Spacer()
            List{
                ForEach($notesViewModel.notes, id: \.id) { $note in
                    HStack(){
                        if note.isFavorite {
                            Image(systemName: "star.fill").scaledToFit().foregroundColor(.blue)
                        }
                        Text(note.description)
                            .foregroundStyle(.black.opacity(0.8))
                        
                    }
                    .swipeActions(edge: .trailing) {
                        Button(action: {notesViewModel.removeNote(withId: note.id)},
                               label: {
                            Image(systemName: "trash.fill")
                        })
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {notesViewModel.updateFavoriteNote(note: $note)}, label: {
                            Image(systemName: "star.fill")
                                
                                
                        })
                    }
                    .tint(.background2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(.background1)
                .cornerRadius(10)
                .listRowBackground(Color.background2)
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.background2)
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("Tareas").bold().foregroundColor(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
