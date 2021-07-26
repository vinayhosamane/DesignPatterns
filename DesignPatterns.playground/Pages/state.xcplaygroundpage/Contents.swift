import UIKit

// state pattern is helpful when we want to switch to different behaviors depending on the current selection or state.
enum State {
    case Selection
    case Brush
    // it is open for modification, which means it can grow
}


protocol ToolProvidable {
    func mouseDown()
    func mouseUp()
}

extension ToolProvidable {
    // we can provide default implmentation here.
}

// selection tool
class SelectionTool: ToolProvidable {

    func mouseUp() {
        print("SelectionTool -- mouse up")
    }
    func mouseDown() {
        print("SelectionTool -- mouse down")
    }

}

// Brush tool
class BrushTool: ToolProvidable {

    func mouseUp() {
        print("BrushTool -- mouse up")
    }
    func mouseDown() {
        print("BrushTool -- mouse down")
    }

}

// canvas
class Canvas: ToolProvidable {

    //private var state: State = .Selection // given a default state
    private var tool: ToolProvidable? = nil // now the state is a abstract class rather than enum, if we had used enum, we would have ended up in duplicate code, huge states.
    
    func mouseUp() {
        tool?.mouseUp()
    }
    
    func mouseDown() {
        tool?.mouseDown()
    }
    
    func getCurrentTool() -> ToolProvidable? {
        return tool
    }
    
    func setCurrentTool(with tool: ToolProvidable) {
        self.tool = tool
    }

}

let canvas = Canvas()
canvas.setCurrentTool(with: SelectionTool())

canvas.mouseDown()
canvas.mouseUp()
