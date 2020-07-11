<p align="center">
  <img src="Assets/GenericColor-Logo-Pink.png" width=100%/>
</p>
<p>
  <a href="https://www.bitrise.io">
        <img src="https://app.bitrise.io/app/a3a37bed689bd009/status.svg?token=BxXqBRMIFEZT29jbaixGpA&branch=master" alt="Bitrise"/>
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/Swift-5.3-orange.svg?logo=swift" />
    </a>
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg?style=flat" alt="SwiftPM" />
    </a>
    <img src="https://img.shields.io/badge/Platforms-Mac & Linux-green.svg?style=flat" alt="Mac & Linux" />
    <a href="https://twitter.com/maximkrouk">
        <img src="https://img.shields.io/badge/twitter-@maximkrouk-blue.svg?logo=twitter&style=social" alt="Twitter: @maximkrouk"/>
    </a>
</p>


Platform agnostic color Library.

## Usage

```swift
import GenericColor
```

#### Initialization

```swift
// Initialize with byte value via .byte(_) method
let color1 = Color<RGB>(
    red: .byte(221),
    green: .byte(51),
    blue: .byte(12),
    alpha: .byte(255)
)

// or directly via numeric literals and .raw(_) method for numerics
let alpha = 1
let color2 = Color<RGB>(red: .max, green: 0.2, blue: .byte(12),  alpha: .raw(alpha))

print(color1 == color2) // true

// hex initialization is supported for RGB color space
// - works with "#" prefix and without, case-insensitive
// - works with rgb, rgba, rrggbb, rrggbbaa representations
// - avalible trough .hex and .init(hex:)
Color.hex("FA6878") // Type == Color<RGB>?
Color(hex: "#aaaf") // rgba, the same as #AAAAAAFF

// or use hex literals
Color(rgb: 0xfa6878)
Color(rgba: 0xfa6878ff)
Color.rgb(0xAAAAAA)

// you can also get an rgb hex value of any color
color1.hex()
color2.hex(uppercased: true)
color3.hex(hashTagPrefix: true)

// color literals will work too, but accuracy is not guarantied
let literal: Color<RGB> = #colorLiteral(red: 0.9803921568627451, green: 0.40784313725490196, blue: 0.47058823529411764, alpha: 1)
```

#### ColorSpaces

```swift
let color1 = Color<RGB>()
let color2 = Color<HSB>()
let color3 = Color<CMYK>()

print(color1.map(to: HSB.self) == color2)
print(color1.map(to: CMYK.self) == color3)
print(color2.map(to: RGB.self) == color1)
print(color2.map(to: \.cmyk) == color3)
print(color3.map(to: \.rgb) == color1)
print(color3.map(to: \.hsb) == color2)
```

## Installation

Add the package to Your SwiftPM package dependencies:

```swift
.package(url: "https://github.com/MakeupStudio/GenericColor.git", from: "0.4.0-alpha.1.0")
```

then add `GenericColor` dependency to your target

```swift
.product(name: "GenericColor", package: "GenericColor")
```



## More

See tests for more usage examples.

Check out higher-level framework [Palette](https://github.com/MakeupStudio/Palette) for more.