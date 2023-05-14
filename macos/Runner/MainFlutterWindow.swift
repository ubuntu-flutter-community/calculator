import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let origin = self.frame.origin
    self.contentViewController = flutterViewController
    self.setFrame(CGRect(x: origin.x, y: origin.y, width: 360, height: 480), display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
