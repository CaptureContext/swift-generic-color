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
    
    // test default init
    var defaultColor: Color<RGB> = .init(red: .byte(250),
                                         green: .byte(104),
                                         blue: .byte(120),
                                         alpha: 1)
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
        // test literal initializers (fails)
        // - { r: 0.9803921580314636, g: 0.40784314274787903, b: 0.47058823704719543 } [Real]
        // vs
        // - { r: 0.9803921568627451, g: 0.40784313725490196, b: 0.47058823529411764 } [Expected]
        
        // let literal: Color<RGB> = #colorLiteral(red: 0.9803921568627451, green: 0.40784313725490196, blue: 0.47058823529411764, alpha: 1)
        // XCTAssertEqual(literal, defaultColor)
        
        func hideWarning(for color: Color<RGB>) {}
        hideWarning(for: #colorLiteral(red: 0.9803921568627451, green: 0.40784313725490196, blue: 0.47058823529411764, alpha: 1))
        
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
                               brightness: 0.9803921568627451,
                               alpha: 1.0)
        testableCollection.forEach {
            let hsb = $0.color.hsb // get hsb container
            XCTAssertEqual(color.hue.test       , hsb.hue.test       , $0.desc)
            XCTAssertEqual(color.saturation.test, hsb.saturation.test, $0.desc)
            XCTAssertEqual(color.brightness.test, hsb.brightness.test, $0.desc)
        }
        testableCollection.forEach {
            let hsba = $0.color.map(to: HSB.self) // get a new hsba color
            XCTAssertEqual(color.hue.test       , hsba.hue.test       , $0.desc)
            XCTAssertEqual(color.saturation.test, hsba.saturation.test, $0.desc)
            XCTAssertEqual(color.brightness.test, hsba.brightness.test, $0.desc)
            XCTAssertEqual(color.alpha.test     , hsba.alpha.test     , $0.desc)
        }
    }
    
    func testHsbToRgb() {
        let color = Color<HSB>(hue: 0.9817351598173516,
                               saturation: 0.584,
                               brightness: 0.9803921568627451,
                               alpha: 1.0)
        let rgba = color.map(to: RGB.self) // map color to rgb
        let rgb = color.rgb // get rgb container
        testableCollection.forEach {
            XCTAssertEqual($0.color.red.test  , rgb.red.test  , $0.desc)
            XCTAssertEqual($0.color.green.test, rgb.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test  , rgb.blue.test, $0.desc)
        }
        testableCollection.forEach {
            XCTAssertEqual($0.color.red.test  , rgba.red.test  , $0.desc)
            XCTAssertEqual($0.color.green.test, rgba.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test , rgba.blue.test , $0.desc)
            XCTAssertEqual($0.color.alpha.test, rgba.alpha.test, $0.desc)
        }
    }
    
    func testCmykToRgb() {
        let color = Color<CMYK>(cyan: 0,
                                magenta: 0.584,
                                yellow: 0.52,
                                key: 0.019607843137254943,
                                alpha: 1)
        let rgba = color.map(to: RGB.self)
        let rgb = color.rgb
        testableCollection.forEach {
            XCTAssertEqual($0.color.red.test  , rgb.red.test  , $0.desc)
            XCTAssertEqual($0.color.green.test, rgb.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test , rgb.blue.test , $0.desc)
        }
        testableCollection.forEach {
            XCTAssertEqual($0.color.red.test  , rgba.red.test  , $0.desc)
            XCTAssertEqual($0.color.green.test, rgba.green.test, $0.desc)
            XCTAssertEqual($0.color.blue.test , rgba.blue.test , $0.desc)
            XCTAssertEqual($0.color.alpha.test, rgba.alpha.test, $0.desc)
        }
    }
    
    func testRgbToCmyk() {
        let color = Color<CMYK>(cyan: 0,
                                magenta: 0.584,
                                yellow: 0.52,
                                key: 0.019607843137254943,
                                alpha: 1)
        testableCollection.forEach {
            let cmyk = $0.color.cmyk
            XCTAssertEqual(cmyk.cyan.test   , color.cyan.test   , $0.desc)
            XCTAssertEqual(cmyk.magenta.test, color.magenta.test, $0.desc)
            XCTAssertEqual(cmyk.yellow.test , color.yellow.test , $0.desc)
            XCTAssertEqual(cmyk.key.test    , color.key.test    , $0.desc)
        }
        testableCollection.forEach {
            let cmyka = $0.color.map(to: CMYK.self)
            XCTAssertEqual(cmyka.cyan.test   , color.cyan.test   , $0.desc)
            XCTAssertEqual(cmyka.magenta.test, color.magenta.test, $0.desc)
            XCTAssertEqual(cmyka.yellow.test , color.yellow.test , $0.desc)
            XCTAssertEqual(cmyka.key.test    , color.key.test    , $0.desc)
            XCTAssertEqual(cmyka.alpha.test  , color.alpha.test  , $0.desc)
        }
    }
    
    func testCoding() {
        guard let data = try? JSONEncoder().encode(defaultColor)
        else { return XCTFail("Could not encode color.") }
        guard let color = try? JSONDecoder().decode(Color<RGB>.self, from: data)
        else { return XCTFail("Could not decode color.") }
        XCTAssertEqual(color, defaultColor)
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
