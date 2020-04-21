import XCTest
@testable import GenericColor

final class GenericColorsTests: XCTestCase {
    
    // test default init
    var defaultColor: Color<RGB> = .init(
        red: .byte(250),
        green: .byte(104),
        blue: .byte(120),
        alpha: .byte(255)
    )
    var testableCollection: [(desc: String, color: Color<RGB>)] = []
    
    override func setUp() {
        var color = defaultColor
        testableCollection.append(("{ r: 250, g: 104, b: 120, a: 1 }", color))
        
        color = Color(rgb: 0xfa6878)! // color from 6-digit hex rgb
        testableCollection.append(("Color(rgb: 0xfa6878)", color))
        
        color = Color(rgba: 0xfa6878ff)! // color from 8-digit hex rgb
        testableCollection.append(("Color(rgba: 0xfa6878ff)", color))
        
        color = .hex(rgb: 0xfa6878)! // color from 6-digit hex rgb
        testableCollection.append(("Color.hex(rgb: 0xfa6878)", color))
        
        color = .hex(rgba: 0xfa6878ff)! // color from 8-digit hex rgb
        testableCollection.append(("Color.hex(rgba: 0xfa6878ff)", color))
        
        // case-insensitive string color initializers
        let base = ["fa6878", "fa6878ff", "#fa6878", "#fa6878ff"] // use hash prefix if you want
        let colorStrings = base + base.map{ $0.uppercased() }
        testableCollection += colorStrings.map { ("Color(hex:\($0))", Color(hex: $0)!) }
        testableCollection += colorStrings.map { ("Color.hex(\($0))", .hex($0)!) }
    }
    
    func testInitializers() {
    // let literal: Color<RGB> = #colorLiteral(red: 0.9803921568627451, green: 0.40784313725490196, blue: 0.47058823529411764, alpha: 1)
    // XCTAssertEqual(literal, defaultColor)
        
        // test setup initializers
        testableCollection.forEach { XCTAssertEqual(defaultColor, $0.color, $0.desc) }
        
        // test other initializers
        // color from 3-digit hex rgb
        XCTAssertEqual(Color(hex: "abc"), Color(hex: "abcf"))
        XCTAssertEqual(Color(hex: "abc"), Color(hex: "#abcf"))
        XCTAssertEqual(Color(hex: "abc"), Color(hex: "aabbcc"))
        XCTAssertEqual(Color(hex: "abc"), Color(hex: "#aabbcc"))
        XCTAssertEqual(Color(hex: "abc"), Color(hex: "aabbccff"))
        XCTAssertEqual(Color(hex: "abc"), Color(rgba: 0xaabbccff))
        
        XCTAssertEqual(Color(hex: "#abc"), Color(hex: "ABC"))
        XCTAssertEqual(Color(hex: "#abc"), Color(rgba: 0xAABBCCFF))
    }

    func testRgbToHsb() {
        let color = Color<HSB>(hue: 0.9817351598173516,
                               saturation: 0.584,
                               brightness: 0.9803921568627453952,
                               alpha: 1.0)
        XCTAssertEqual(defaultColor.hsb, color.container)
        XCTAssertEqual(defaultColor.map(\.hsb), color)
        XCTAssertEqual(defaultColor.map(to: HSB.self), color)
    }
    
    func testHsbToRgb() {
        let color = Color<HSB>(hue: 0.9817351598173516,
                               saturation: 0.584,
                               brightness: 0.9803921568627453952,
                               alpha: 1.0)
        XCTAssertEqual(color.rgb, defaultColor.container)
        XCTAssertEqual(color.map(\.rgb), defaultColor)
        XCTAssertEqual(color.map(to: RGB.self), defaultColor)
    }
    
    func testRgbToCmyk() {
        let color = Color<CMYK>(cyan: .zero,
                                magenta: 0.584,
                                yellow: 0.52,
                                key: 0.01960784313725460992,
                                alpha: .max)
        XCTAssertEqual(defaultColor.cmyk, color.container)
        XCTAssertEqual(defaultColor.map(\.cmyk), color)
        XCTAssertEqual(defaultColor.map(to: CMYK.self), color)
    }
    
    func testCmykToRgb() {
        let color = Color<CMYK>(cyan: .zero,
                                magenta: 0.584,
                                yellow: 0.52,
                                key: 0.01960784313725460992,
                                alpha: .max)
        XCTAssertEqual(color.rgb, defaultColor.container)
        XCTAssertEqual(color.map(\.rgb), defaultColor)
        XCTAssertEqual(color.map(to: RGB.self), defaultColor)
    }
    
    func testCoding() {
        guard let data = try? JSONEncoder().encode(defaultColor)
        else { return XCTFail("Could not encode color.") }
        guard let color = try? JSONDecoder().decode(Color<RGB>.self, from: data)
        else { return XCTFail("Could not decode color.") }
        XCTAssertEqual(color, defaultColor)
    }
    
    func testHexStringRepresentation() {
        let color1 = Color<RGB>.hex(rgb: 0x00aabb)!
        let color2 = Color<RGB>.hex(rgba:0x000)!
        let color3 = Color<RGB>.hex(rgb: 0xffffff)!
        let color4 = Color<RGB>.hex(rgba: 0xffffffaa)!
        
        XCTAssertEqual(color1.hex(uppercase: true, hashTagPrefix: true), "#00AABBFF")
        XCTAssertEqual(color2.hex(uppercase: false, hashTagPrefix: false), "00000000")
        XCTAssertEqual(color3.hex(uppercase: false, hashTagPrefix: true), "#ffffffff")
        XCTAssertEqual(color4.hex(), "ffffffaa")
    }
    
    static var allTests = [
        ("testInitializers", testInitializers),
        ("testRgbToHsb", testRgbToHsb),
        ("testHsbToRgb", testHsbToRgb),
        ("testCmykToRgb", testCmykToRgb),
        ("testRgbToCmyk", testRgbToCmyk),
        ("testCoding", testCoding),
        ("testHexStringRepresentation", testHexStringRepresentation)
    ]
}
