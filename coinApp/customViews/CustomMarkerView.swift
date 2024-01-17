import UIKit
import Charts

class CustomMarkerView: MarkerView {
    var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    private func setupLabel() {
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 2
        addSubview(label)
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let value = entry.y
        label.text = String(format: "₹ %.2f", value)
        label.sizeToFit()
    }

    override func draw(context: CGContext, point: CGPoint) {
        var point = point
        point.x -= bounds.size.width / 2
        point.y -= bounds.size.height + 10
        super.draw(context: context, point: point)
    }
}
