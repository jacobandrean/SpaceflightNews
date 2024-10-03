import Foundation

public protocol Module {
    init()
    func register(for injector: Injector)
}
