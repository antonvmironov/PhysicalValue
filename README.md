# PhysicalValue for Swift

![License](https://img.shields.io/github/license/mashape/apistatus.svg)
![Platform](https://img.shields.io/badge/platform-ios%7Cosx-lighthgrey.svg)
![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)



A Swift based types for expressing/converting physical values in various units.


# What is the point?

code before:
```
struct Shape {
    var points: [Point]
    var roation: Float // is it radians or degrees? What if somebody will not guess
}
```

code after:
```
struct Shape {
    var points: [Point]
    var rotation: Angle
}
```

# How to use?
```
let angle1 = Angle(amount: 90.0, unit: .degree)
// or
let angle2 = Angle(degrees: 90.0)
// or
let angle3: Angle = 90.0.of(.degree)
// or
let angle4: Angle = 90.0 * .degree
```
