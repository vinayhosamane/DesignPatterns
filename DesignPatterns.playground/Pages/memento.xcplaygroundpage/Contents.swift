//: [Previous](@previous)

import Foundation

// Memento design pattern

// usually used for undo - redo workflows

// Originator -- who holds the content
// memento -- who holds the state
// history or careTaker -- who is responsible for holding list of states.

// careTaker or history class composes memento
// Originator has dependency on memento (who has state)

class Editor {

    private(set) final var content: String
    
    private var history: History!
    
    init(with content: String = "") {
        self.content = content
        
        self.history = History()
    }
    
    // encapsulation for content
    func getContent() -> String {
        return content
    }
    
    func setContent(with content: String) {
        if !content.isEmpty {
            self.content.append(content)
            
            // add to history
            history.push(createEditorState())
        }
    }
    
    func createEditorState() -> EditorState {
        return EditorState(with: content)
    }
    
    func undo() {
        history.pop()
        content.removeLast()
    }

}

class EditorState {
    private(set) final var content: String
    
    init(with content: String) {
        self.content = content
    }
    
    // encapsulation for content
    func getContent() -> String {
        return content
    }
    
    func setContent(with content: String) {
        if !content.isEmpty {
            self.content = content
        }
    }
}


class History {
    
    private var states = [EditorState]()
    
    func push(_ state: EditorState) {
        states.append(state)
    }
    
    @discardableResult
    func pop() -> EditorState {
        return states.removeLast()
    }

}

class Notepad {
    
    func draw() {
        let editor = Editor()
        
        editor.setContent(with: "a")
        editor.setContent(with: "b")
        editor.setContent(with: "c")
        
        editor.undo()
        
        print(editor.getContent())
    }
    
}

let editor = Notepad()
editor.draw()

//: [Next](@next)
