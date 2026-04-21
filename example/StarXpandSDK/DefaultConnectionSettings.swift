import StarIO10

class DefaultConnectionSettings {
    private static let interfaceType: InterfaceType = .lan
    private static let identifier: String = "00:11:62:00:00:00"
//    private static let identifier: String = StarConnectionSettings.FIRST_FOUND_DEVICE
    
    static func get() -> StarConnectionSettings {
        return StarConnectionSettings(
            interfaceType: interfaceType,
            identifier: identifier,
            autoSwitchInterface: false)
    }
}
