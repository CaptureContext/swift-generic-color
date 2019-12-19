import XCTest
@testable import GenericColor

final class GenericColorsTests: XCTestCase {
    
    var colors: [(desc: String, color: Color<RGB>)] =
        [("Default initializer", .init(red: .byte(250), green: .byte(104), blue: .byte(120), alpha: 1))]
    
    override func setUp() {
        let base = ["fa6878", "fa6878ff", "#fa6878", "#fa6878ff"]
        let colorStrings = base + base.map{ $0.uppercased() }
        
        colors.append(("Color(rgb: 0xfa6878)", Color(rgb: 0xfa6878)!))
        colors.append(("Color(rgb: 0xfa6878)", Color(rgb: 0xfa6878)!))
        colors.append(("Color(rgba: 0xfa6878ff)", Color(rgba: 0xfa6878ff)!))
        colors.append(("Color.hex(rgb: 0xfa6878)", Color.hex(rgb: 0xfa6878)!))
        colors.append(("Color.hex(rgba: 0xfa6878ff)", Color.hex(rgba: 0xfa6878ff)!))
        
        colors += colorStrings.map { ("Color(hex: \($0))", Color(hex: $0)!) }
        colors += colorStrings.map { ("Color.hex(\($0))", Color.hex($0)!) }
    }
    
    func testInitializers() {
        let color = colors.first!.color
        colors.forEach { XCTAssertEqual(color, $0.color, $0.desc) }
    }

    func testHsb() {
        let hsba = (hue: 0.9817351598173516, saturation: 0.584, brightness: 0.9803921568627451, alpha: 1.0)
        colors.forEach {
            XCTAssertEqual(hsba.hue, $0.color.hsb.hue.value, $0.desc)
            XCTAssertEqual(hsba.saturation, $0.color.hsb.saturation.value, $0.desc)
            XCTAssertEqual(hsba.brightness, $0.color.hsb.brightness.value, $0.desc)
        }
    }
    
    func testCoding() {
        let color = colors.first!.color
        guard let data = try? JSONEncoder().encode(color)
        else { return XCTFail("Could not encode color.") }
        guard let color1 = try? JSONDecoder().decode(Color<RGB>.self, from: data)
        else { return XCTFail("Could not decode color.") }
        XCTAssertEqual(color, color1)
    }
    
    static var allTests = [
        ("testInitializers", testInitializers),
        ("testHsb", testHsb),
        ("testCoding", testCoding)
    ]
}






























