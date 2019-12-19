# GenericColor

<p>
  <a href="https://www.bitrise.io">
        <img src="https://app.bitrise.io/app/a3a37bed689bd009/status.svg?token=BxXqBRMIFEZT29jbaixGpA&branch=master" alt="Bitrise"/>
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/Swift-5.1-red.svg?logo=swift" />
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
// initialize with byte value via .byte(_) method
let color1 = Color<RGB>(red: .byte(221),
                        green: .byte(51),
                        blue: .byte(12), 
                        alpha: .byte(255))

// or directly via numeric literals and .raw(_) method for numerics
let alpha = 1
let color2 = Color<RGB>(red: 221 / 255, green: 0.2, blue: .byte(12),  alpha: .raw(1))

print(color1 == color2) // true
```

#### ColorSpaces

```swift
let color1 = Color<RGB>()
let color2 = Color<HSB>()
let color2 = Color<CMYK>()

print(color1.mapToHSB() == color2)
```

For now only RGB to HSB conversion is available, but we are working to provide more _(pull requests are welcome)_ 😉.

For now you can use your custom conversions via:

```swift
Color<RGB>().map { color in 
    // Some color mapping
}
```

