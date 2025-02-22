import Foundation

extension TimeInterval {
    public var minutes: Int {
        Int(self / 60)
    }
    
    public static func minutes(_ count: Int) -> TimeInterval {
        TimeInterval(count * 60)
    }
}
