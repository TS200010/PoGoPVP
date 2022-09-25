import Cocoa

var greeting = "Hello, playground"

/*protocol Drawable {
    func draw(renderer: Renderer)
}
*/

protocol Drawable {
    func isEqualTo(other: Drawable) -> Bool
    func draw()
}

extension Drawable where Self : Equatable {
    func isEqualTo(other: Drawable) -> Bool {
        if let o = other as? Self { return self == o }
        return false
    }
}

struct Polygon : Drawable {
    func draw(renderer: Renderer) {
        renderer.moveTo(corners.last!)
        for p in corners {
            renderer.lineTo(p)
        }
    }
    var corners: [CGPoint] = []
}

struct Diagram : Drawable {
    func draw(renderer: Renderer) {
         for f in elements {
             f.draw(renderer)
         }
    }
    var elements: [Drawable] = []
}

struct Circle : Drawable {
    func draw(renderer: Renderer) {
        renderer.arcAt(center, radius: radius,
               startAngle: 0.0, endAngle: 6.2)
    }
    var center: CGPoint
    var radius: CGFloat
}

func == (lhs: Diagram, rhs: Diagram) -> Bool {
    return lhs.elements.count == rhs.elements.count
        && !zip(lhs.elements, rhs.elements).contains { !$0.isEqualTo($1) }
}


protocol Renderer {
    func moveTo(p: CGPoint)
    func lineTo(p: CGPoint)
    func arcAt(center: CGPoint, radius: CGFloat,
               startAngle: CGFloat, endAngle: CGFloat)
}

struct TestRenderer : Renderer {
    func moveTo(p: CGPoint) { print("moveTo(\(p.x), \(p.y))") }
    func lineTo(p: CGPoint) { print("lineTo(\(p.x), \(p.y))") }
    func arcAt(center: CGPoint, radius: CGFloat,
               startAngle: CGFloat, endAngle: CGFloat) {
        print("arcAt(\(center), radius: \(radius)," +
              " startAngle: \(startAngle), endAngle: \(endAngle))")
    }
}

