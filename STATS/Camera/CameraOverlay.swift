import UIKit

//https://manasaprema04.medium.com/different-way-of-creating-uiviews-in-swift-4aeb1b5d0d6b
class CameraOverlay: UIView {
    var columnCount: Int = 2
    var rowCount: Int = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    //https://stackoverflow.com/questions/7304642/create-grid-lines-and-allow-user-to-on-off-grid-line-view
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setLineWidth(1.0)
            context.setStrokeColor(UIColor.white.cgColor)
            
            let columnWidth = Int(rect.width) / (columnCount + 1)
            
            for i in 1...columnCount {
                var startPoint = CGPoint.zero
                var endPoint = CGPoint.zero
                startPoint.x = CGFloat(columnWidth * i)
                startPoint.y = 0.0
                endPoint.x = startPoint.x
                endPoint.y = frame.size.height
                context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
                context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                context.strokePath()
            }
            
            let rowHeight = Int(rect.height) / (rowCount + 1)
            
            for j in 1...rowCount {
                var startPoint = CGPoint.zero
                var endPoint = CGPoint.zero
                startPoint.x = 0.0
                startPoint.y = CGFloat(rowHeight * j)
                endPoint.x = frame.size.width
                endPoint.y = startPoint.y
                context.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
                context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
                context.strokePath()
            }
        }
    }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
