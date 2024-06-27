//
//  ViewModel.swift
//  Note
//
//  Created by Hugo López on 23-06-24.
//

import Foundation
import SwiftUI

class NoteViewModel:ObservableObject {
    @Published var notes: [NoteModel] = []
    
    init() {
        notes = getAllNotes()
    }
    func saveNote(description: String) {
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNote()
    }
    
    private func encodeAndSaveAllNote() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel] {
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
            }
        }
        return []
    }
    
    func removeNote(withId id: String) {
        notes.removeAll(where: { $0.id == id})
        encodeAndSaveAllNote()
    }
    
    func updateFavoriteNote(note: Binding<NoteModel>) {
        note.wrappedValue.isFavorite = !note.wrappedValue.isFavorite
        encodeAndSaveAllNote()
    }
    
    func numberOfNotes() -> String{
        "\(notes.count)"
    }
}
