import class CoreGraphics.CGColorSpace
import func CoreGraphics.CGColorSpaceCreateDeviceGray
import func CoreGraphics.CGColorSpaceCreateDeviceRGB
import struct CoreGraphics.CGSize
import struct CoreImage.CIFormat
import class CoreImage.CIImage
import struct Foundation.Data
import typealias FpUtil.IO

public typealias BitmapToImage = (Data) -> IO<CIImage>

public struct ConvertConfig: Sendable {

  public let bytesPerRow: Int
  public let size: CGSize
  public let format: CIFormat
  public let color: CGColorSpace

  public func toBitmapToImage() -> BitmapToImage {
    return {
      let dat: Data = $0
      return {
        let img: CIImage = CIImage(
          bitmapData: dat,
          bytesPerRow: self.bytesPerRow,
          size: self.size,
          format: self.format,
          colorSpace: self.color
        )
        return .success(img)
      }
    }
  }

  public func withSize(size: CGSize) -> Self {
    Self(
      bytesPerRow: self.bytesPerRow,
      size: size,
      format: self.format,
      color: self.color
    )
  }

  public func withSizeRgba8(size: CGSize) -> Self {
    let width: Int = Int(size.width)
    let bpr: Int = Self.bytesPerRowRgba8(width: width)
    return Self(
      bytesPerRow: bpr,
      size: size,
      format: self.format,
      color: self.color
    )
  }

  public func withSizeGray(size: CGSize) -> Self {
    let width: Int = Int(size.width)
    let bpr: Int = Self.bytesPerRowGray(width: width)
    return Self(
      bytesPerRow: bpr,
      size: size,
      format: self.format,
      color: self.color
    )
  }

  public func withBytesPerRow(bpr: Int) -> Self {
    Self(
      bytesPerRow: bpr,
      size: self.size,
      format: self.format,
      color: self.color
    )
  }

  public static func bytesPerRowRgba8(width: Int) -> Int {
    let bytesPerPixel: Int = 1 * 4  // 32-bit
    return width * bytesPerPixel
  }

  public static func bytesPerRowGray(width: Int) -> Int {
    let bytesPerPixel: Int = 1  // 8-bit
    return width * bytesPerPixel
  }

}

public let ConvertConfigRgba32: ConvertConfig = ConvertConfig(
  bytesPerRow: 0,
  size: CGSize(),
  format: .RGBA8,
  color: CGColorSpaceCreateDeviceRGB()
)

public let ConvertConfigGray8: ConvertConfig = ConvertConfig(
  bytesPerRow: 0,
  size: CGSize(),
  format: .L8,
  color: CGColorSpaceCreateDeviceGray()
)
