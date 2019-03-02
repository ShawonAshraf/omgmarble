#  OMGMarbles
> A somewhat reworked version of Paul Hudsons  game shown on Swift on Sundays

## What it does...
Basically you have to pop the bubbles but in a combination or chain. The longer combinations you can break the higher your score will be. The score is determined by

```swift
score += Int( pow( 2, min( matchedBalls.count, 16 ) ) )

// matchedBalls is a set that contains all the balls or marbles you matched
// in your combo
```

## Device Support
`iPad` with fixed orientation

## Running the app
- Clone the repo
- Open in Xcode
- Deploy to your device
- Don't even think of running on a Simulator unless you want to see unplayable framerates

## Screenshots
> Taken from an iPad Air 2

![img](./Screenshots/IMG_1972.png)


![img](./Screenshots/IMG_1972.png)


