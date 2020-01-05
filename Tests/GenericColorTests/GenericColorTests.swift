import XCTest
@testable import GenericColor

extension ColorComponent {
    // Reducing accuracy
    var test: Double {
        let precision: Double = pow(10, 10)
        return .init(floor(value * precision)) / precision
    }
}

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

    func testRgbToHsb() {
        let color = Color<HSB>(hue: 0.9817351598173516, saturation: 0.584, brightness: 0.9803921568627451, alpha: 1.0)
        colors.forEach {
            let hsb = $0.color.hsb
            XCTAssertEqual(color.hue.test, hsb.hue.test, $0.desc)
            XCTAssertEqual(color.saturation.test, hsb.saturation.test, $0.desc)
            XCTAssertEqual(color.brightness.test, hsb.brightness.test, $0.desc)
        }
        colors.forEach {
            let hsba = $0.color.map(to: HSB.self)
            XCTAssertEqual(color.hue.test, hsba.hue.test, $0.desc)
            XCTAssertEqual(color.saturation.test, hsba.saturation.test, $0.desc)
            XCTAssertEqual(color.brightness.test, hsba.brightness.test, $0.desc)
            XCTAssertEqual(color.alpha.test, hsba.alpha.test, $0.desc)
        }
    }
    
    func testHsbToRgb() {
        let color = Color<HSB>(hue: 0.9817351598173516, saturation: 0.584, brightness: 0.9803921568627451, alpha: 1.0)
        let rgba = color.map(to: RGB.self)
        let rgb = color.rgb
        colors.forEach {
            XCTAssertEqual($0.color.red.test, rgb.red.test, $0.desc)
            XCTAssertEqual($0.color.green.test, rgb.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test, rgb.blue.test, $0.desc)
        }
        colors.forEach {
            XCTAssertEqual($0.color.red.test, rgba.red.test, $0.desc)
            XCTAssertEqual($0.color.green.test, rgba.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test, rgba.blue.test, $0.desc)
            XCTAssertEqual($0.color.alpha.test, rgba.alpha.test, $0.desc)
        }
    }
    
    func testCmykToRgb() {
        let color = Color<CMYK>(cyan: 0, magenta: 0.584, yellow: 0.52, key: 0.019607843137254943, alpha: 1)
        let rgba = color.map(to: RGB.self)
        let rgb = color.rgb
        colors.forEach {
            XCTAssertEqual($0.color.red.test, rgb.red.test, $0.desc)
            XCTAssertEqual($0.color.green.test, rgb.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test, rgb.blue.test, $0.desc)
        }
        colors.forEach {
            XCTAssertEqual($0.color.red.test, rgba.red.test, $0.desc)
            XCTAssertEqual($0.color.green.test, rgba.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test, rgba.blue.test, $0.desc)
            XCTAssertEqual($0.color.alpha.test, rgba.alpha.test, $0.desc)
        }
    }
    
    func testRgbToCmyk() {
        let color = Color<CMYK>(cyan: 0, magenta: 0.584, yellow: 0.52, key: 0.019607843137254943, alpha: 1)
        colors.forEach {
            let cmyk = $0.color.cmyk
            XCTAssertEqual(cmyk.cyan.test, color.cyan.test, $0.desc)
            XCTAssertEqual(cmyk.magenta.test, color.magenta.test, $0.desc)
            XCTAssertEqual(cmyk.yellow.test, color.yellow.test, $0.desc)
            XCTAssertEqual(cmyk.key.test, color.key.test, $0.desc)
        }
        colors.forEach {
            let cmyka = $0.color.map(to: CMYK.self)
            XCTAssertEqual(cmyka.cyan.test, color.cyan.test, $0.desc)
            XCTAssertEqual(cmyka.magenta.test, color.magenta.test, $0.desc)
            XCTAssertEqual(cmyka.yellow.test, color.yellow.test, $0.desc)
            XCTAssertEqual(cmyka.key.test, color.key.test, $0.desc)
            XCTAssertEqual(cmyka.alpha.test, color.alpha.test, $0.desc)
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
        ("testRgbToHsb", testRgbToHsb),
        ("testHsbToRgb", testHsbToRgb),
        ("testCmykToRgb", testCmykToRgb),
        ("testRgbToCmyk", testRgbToCmyk),
        ("testCoding", testCoding)
    ]
}






























