import typealias BitmapToImage.BitmapToImage
import struct BitmapToImage.ConvertConfig
import let BitmapToImage.ConvertConfigGray8
import class CoreGraphics.CGColorSpace
import func CoreGraphics.CGColorSpaceCreateDeviceGray
import struct CoreGraphics.CGSize
import class CoreImage.CIContext
import struct CoreImage.CIFormat
import class CoreImage.CIImage
import struct Foundation.Data
import struct Foundation.URL
import func FpUtil.Bind
import typealias FpUtil.IO

public func image2pngFileGray(filename: URL) -> (CIImage) -> IO<Void> {
  let ctx: CIContext = CIContext()
  return {
    let img: CIImage = $0
    return {
      let fmt: CIFormat = .L8
      let color: CGColorSpace = CGColorSpaceCreateDeviceGray()
      return Result(catching: {
        try ctx.writePNGRepresentation(
          of: img,
          to: filename,
          format: fmt,
          colorSpace: color
        )
      })
    }
  }
}

@main
struct BitmapToPng {
  static func main() {
    let sz: CGSize = CGSize(width: 16.0, height: 3.0)
    let cfg: ConvertConfig =
      ConvertConfigGray8
      .withSizeGray(size: sz)
    let conv: BitmapToImage = cfg.toBitmapToImage()

    var bmp: Data = Data(count: 16 * 3)
    for i in 0..<bmp.count {
      bmp[i] = UInt8(i)
    }

    let img: IO<CIImage> = conv(bmp)
    let url: URL = URL(fileURLWithPath: "./out.png")

    let img2png: IO<Void> = Bind(
      img,
      image2pngFileGray(filename: url)
    )

    let res: Result<Void, _> = img2png()

    do {
      try res.get()
    } catch {
      print("\( error )")
    }
  }
}
