/// Configuration options and asset definitions for image and
/// video editing tasks.
class Configuration {
  /// Creates a new [Configuration].
  Configuration({
    this.adjustment,
    this.brush,
    this.enableZoom,
    this.export,
    this.filter,
    this.focus,
    this.forceCrop,
    this.frame,
    this.mainCanvasActions,
    this.overlay,
    this.snapping,
    this.sticker,
    this.text,
    this.textdesign,
    this.tools,
    this.transform,
  });

  /// Configuration options for `Tool.adjustment`.
  final AdjustmentOptions adjustment;

  /// Configuration options for `Tool.brush`.
  final BrushOptions brush;

  /// Controls if the user can zoom the preview image.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool enableZoom;

  /// Export configuration options.
  final ExportOptions export;

  /// Configuration options for `Tool.filter`.
  final FilterOptions filter;

  /// Configuration options for `Tool.focus`.
  final FocusOptions focus;

  /// When set to `true`, the user is forced to crop the asset to one of the
  /// allowed crop ratios in `transform.items` before being able to use other
  /// features of the editor.
  /// The transform tool will only be presented if the image does not already
  /// fit one of the allowed aspect ratios. It will be presented automatically,
  /// if the user changes the orientation of the asset
  /// and the result does not match an allowed aspect ratio.
  ///
  /// This property has no effect unless `transform.allowFreeCrop` is set to
  /// `false` or `null`.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool forceCrop;

  /// Configuration options for `Tool.frame`.
  final FrameOptions frame;

  /// Defines all allowed actions for the main screen that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.undo, CanvasAction.redo]`
  /// ```
  final List<MainCanvasAction> mainCanvasActions;

  /// Configuration options for `Tool.overlay`.
  final OverlayOptions overlay;

  /// Global snapping options for all sprites, e.g., stickers, texts,
  /// and text designs.
  final SnappingOptions snapping;

  /// Configuration options for `Tool.sticker`.
  final StickerOptions sticker;

  /// Configuration options for `Tool.text`.
  final TextOptions text;

  /// Configuration options for `Tool.textDesign`.
  final TextDesignOptions textdesign;

  /// The menu items (or tools) to display in the main menu.
  /// ```
  /// // Defaults to:
  /// [Tool.trim, Tool.transform, Tool.filter, Tool.adjustment, Tool.focus,
  /// Tool.sticker, Tool.text, Tool.textDesign, Tool.overlay, Tool.frame,
  /// Tool.brush]
  /// ```
  final List<Tool> tools;

  /// Configuration options for `Tool.transform`.
  final TransformOptions transform;

  /// Converts a [Configuration] to a [Map].
  Map<String, dynamic> toJson() => {
        "adjustment": adjustment == null ? null : adjustment._toJson(),
        "brush": brush == null ? null : brush._toJson(),
        "enableZoom": enableZoom == null ? null : enableZoom,
        "export": export == null ? null : export._toJson(),
        "filter": filter == null ? null : filter._toJson(),
        "focus": focus == null ? null : focus._toJson(),
        "forceCrop": forceCrop == null ? null : forceCrop,
        "frame": frame == null ? null : frame._toJson(),
        "mainCanvasActions": mainCanvasActions == null
            ? null
            : List<dynamic>.from(mainCanvasActions
                .map((x) => _mainCanvasActionValues.reverse[x])),
        "overlay": overlay == null ? null : overlay._toJson(),
        "snapping": snapping == null ? null : snapping._toJson(),
        "sticker": sticker == null ? null : sticker._toJson(),
        "text": text == null ? null : text._toJson(),
        "textdesign": textdesign == null ? null : textdesign._toJson(),
        "tools": tools == null
            ? null
            : List<dynamic>.from(tools.map((x) => _toolValues.reverse[x])),
        "transform": transform == null ? null : transform._toJson(),
      }..removeWhere((key, value) => key == null || value == null);
}

/// Configuration options for `Tool.adjustment`.
class AdjustmentOptions {
  /// Creates new [AdjustmentOptions].
  AdjustmentOptions({
    this.items,
    this.showResetButton,
  });

  /// Defines all allowed adjustment tools. The adjustment tool buttons
  /// are always shown in the given order.
  /// ```
  /// // Defaults to:
  /// [AdjustmentTool.brightness, AdjustmentTool.contrast,
  /// AdjustmentTool.saturation, AdjustmentTool.clarity,
  /// AdjustmentTool.shadows, AdjustmentTool.highlights,
  /// AdjustmentTool.exposure, AdjustmentTool.gamma,
  /// AdjustmentTool.blacks, AdjustmentTool.whites,
  /// AdjustmentTool.temperature, AdjustmentTool.sharpness]
  /// ```
  final List<AdjustmentTool> items;

  /// Whether to show a reset button to reset the applied adjustments.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool showResetButton;

  /// Converts [AdjustmentOptions] to a [Map].
  Map<String, dynamic> _toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(
                items.map((x) => _adjustmentToolValues.reverse[x])),
        "showResetButton": showResetButton == null ? null : showResetButton,
      }..removeWhere((key, value) => key == null || value == null);
}

/// An adjustment tool.
enum AdjustmentTool {
  /// Adjust the blacks of the asset.
  blacks,

  /// Adjust the brightness of the asset.
  brightness,

  /// Adjust the clarity of the asset.
  clarity,

  /// Adjust the contrast of the asset.
  contrast,

  /// Adjust the exposure of the asset.
  exposure,

  /// Adjust the gamma of the asset.
  gamma,

  /// Adjust the highlights of the asset.
  highlights,

  /// Adjust the saturation of the asset.
  saturation,

  /// Adjust the shadows of the asset.
  shadows,

  /// Adjust the sharpness of the asset.
  sharpness,

  /// Adjust the temperature of the asset.
  temperature,

  /// Adjust the whites of the asset.
  whites
}

/// The corresponding values for the adjustment tools.
final _adjustmentToolValues = _EnumValues({
  "blacks": AdjustmentTool.blacks,
  "brightness": AdjustmentTool.brightness,
  "clarity": AdjustmentTool.clarity,
  "contrast": AdjustmentTool.contrast,
  "exposure": AdjustmentTool.exposure,
  "gamma": AdjustmentTool.gamma,
  "highlights": AdjustmentTool.highlights,
  "saturation": AdjustmentTool.saturation,
  "shadows": AdjustmentTool.shadows,
  "sharpness": AdjustmentTool.sharpness,
  "temperature": AdjustmentTool.temperature,
  "whites": AdjustmentTool.whites
});

/// Configuration options for `Tool.brush`.
class BrushOptions {
  /// Creates new [BrushOptions].
  BrushOptions({
    this.actions,
    this.canvasActions,
    this.colors,
    this.defaultColor,
    this.defaultHardness,
    this.defaultSize,
    this.maximumHardness,
    this.maximumSize,
    this.minimumHardness,
    this.minimumSize,
  });

  /// Defines all allowed actions for the brush tool menu. Only buttons for
  /// allowed actions are visible and shown in the given order.
  /// ```
  /// // Defaults to:
  /// [BrushAction.color, BrushAction.size, BrushAction.hardness]
  /// ```
  final List<BrushAction> actions;

  /// Defines all allowed actions for the brush tool that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.delete, CanvasAction.bringToFront,
  /// CanvasAction.undo, CanvasAction.redo]
  final List<BrushCanvasAction> canvasActions;

  /// Defines all available colors that can be applied to the brush.
  /// The color pipette is always added.
  final ColorPalette colors;

  /// The default color.
  final Color defaultColor;

  /// The default hardness factor of the brush.
  /// ```
  /// // Defaults to:
  /// 0.5
  /// ```
  final double defaultHardness;

  /// The default size of the brush. This value is measured in relation to the
  /// smaller side of the image that the user is editing.
  /// ```
  /// // Defaults to:
  /// 0.05
  /// ```
  final double defaultSize;

  /// The maximum hardness factor a brush can have.
  /// ```
  /// // Defaults to:
  /// 1
  /// ```
  final double maximumHardness;

  /// The maximum size that a brush can have. This value is
  /// measured in relation to the smaller side of the asset
  /// that the user is editing.
  /// ```
  /// // Defaults to:
  /// 0.125
  /// ```
  final double maximumSize;

  /// The minimum hardness factor a brush can have.
  /// ```
  /// // Defaults to:
  /// 0
  /// ```
  final double minimumHardness;

  /// The minimum size that a brush can have. This value is measured
  /// in relation to the smaller side of the asset that the user is editing.
  /// If the value is `null` the minimum brush size is set to the absolute
  /// size of a single pixel of the edited image.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final double minimumSize;

  /// Converts [BrushOptions] to a [Map].
  Map<String, dynamic> _toJson() => {
        "actions": actions == null
            ? null
            : List<dynamic>.from(
                actions.map((x) => _brushActionValues.reverse[x])),
        "canvasActions": canvasActions == null
            ? null
            : List<dynamic>.from(
                canvasActions.map((x) => _brushCanvasActionValues.reverse[x])),
        "colors": colors == null ? null : colors._toJson(),
        "defaultColor": defaultColor == null ? null : defaultColor._toJson(),
        "defaultHardness": defaultHardness == null ? null : defaultHardness,
        "defaultSize": defaultSize == null ? null : defaultSize,
        "maximumHardness": maximumHardness == null ? null : maximumHardness,
        "maximumSize": maximumSize == null ? null : maximumSize,
        "minimumHardness": minimumHardness == null ? null : minimumHardness,
        "minimumSize": minimumSize == null ? null : minimumSize,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A brush action.
enum BrushAction {
  /// Change the color of the brush.
  color,

  /// Change the hardness of the brush.
  hardness,

  /// Change the size of the brush.
  size
}

/// The corresponding values to the [BrushAction].
final _brushActionValues = _EnumValues({
  "color": BrushAction.color,
  "hardness": BrushAction.hardness,
  "size": BrushAction.size
});

/// A brush canvas action.
enum BrushCanvasAction {
  /// Bring the brush to the front.
  bringToFront,

  /// Delete the brush.
  delete,

  /// Redo action(s).
  redo,

  /// Undo action(s).
  undo
}

/// The corresponding values to the [BrushCanvasAction].
final _brushCanvasActionValues = _EnumValues({
  "bringtofront": BrushCanvasAction.bringToFront,
  "delete": BrushCanvasAction.delete,
  "redo": BrushCanvasAction.redo,
  "undo": BrushCanvasAction.undo
});

/// A color.
class Color {
  /// Creates a new [Color].
  Color(this.color);

  /// A color can be represented as:
  /// - `List<double>`: which encodes a single gray value or a RGB(A)
  ///    tuple of floating point values where
  ///    each channel is defined in the range of `[0, 1]`.
  /// - `String`: which is a hex color code string of a 12-bit RGB,
  ///    24-bit RGB, or 32-bit ARGB color value.
  /// - `double`: which is the the binary representation of a 32-bit
  ///    ARGB color value.
  final dynamic color;

  /// Converts a [Color] for JSON parsing.
  dynamic _toJson() => color == null ? null : color;
}

/// A named color.
class NamedColor {
  /// Creates a new [NamedColor].
  NamedColor(this.color, this.name);

  /// The color itself.
  final Color color;

  /// The name of the color which is also used for accessibility.
  final String name;

  /// Converts a [NamedColor] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "color": color == null ? null : color._toJson(),
        "name": name == null ? null : name
      }..removeWhere((key, value) => key == null || value == null);
}

/// A color palette of named colors.
class ColorPalette {
  /// Creates a new [ColorPalette].
  ColorPalette({this.colors});

  /// The included named colors.
  final List<NamedColor> colors;

  /// Converts a [ColorPalette] for JSON parsing.
  List<Map<String, dynamic>> _toJson() =>
      colors.map((c) => c._toJson()).toList();
}

/// Export configuration options.
class ExportOptions {
  /// Creates new [ExportOptions].
  ExportOptions({
    this.filename,
    this.image,
    this.serialization,
    this.video,
  });

  /// The filename for the exported data if the `exportType` is not
  /// `ImageExportType.dataUrl`.
  /// The correct filename extension will be automatically added
  /// based on the selected export format. It can be an absolute path
  /// or file URL or a relative path.
  /// If some relative path is chosen it will be created in a temporary
  /// system directory and overwritten
  /// if the corresponding file already exists. If the value is `null`
  /// an new temporary file will be created for every export.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String filename;

  /// Image export configuration if the editor supports image editing.
  final ImageOptions image;

  /// Export configuration of the serialized image and video editing
  /// operations that were applied to the input media loaded into the editor.
  /// This also allows to recover these operations the next
  /// time the editor is opened again.
  final SerializationOptions serialization;

  /// Video export configuration if the editor supports video editing.
  final VideoOptions video;

  /// Converts [ExportOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "filename": filename == null ? null : filename,
        "image": image == null ? null : image._toJson(),
        "serialization": serialization == null ? null : serialization._toJson(),
        "video": video == null ? null : video._toJson(),
      }..removeWhere((key, value) => key == null || value == null);
}

/// Image export configuration if the editor supports image editing.
class ImageOptions {
  /// Creates new [ImageOptions].
  ImageOptions({
    this.exportType,
    this.format,
    this.quality,
  });

  /// The image export type.
  /// ```
  /// // Defaults to:
  /// ImageExportType.fileUrl
  /// ```
  final ImageExportType exportType;

  /// The image file format of the generated high resolution image.
  /// ```
  /// // Defaults to:
  /// ImageFormat.jpeg
  /// ```
  final ImageFormat format;

  /// The compression quality to use when creating the output
  /// image with a lossy file format.
  /// ```
  /// // Defaults to:
  /// 0.9
  /// ```
  final double quality;

  /// Converts [ImageOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "exportType": exportType == null
            ? null
            : _imageExportTypeValues.reverse[exportType],
        "format": format == null ? null : _imageFormatValues.reverse[format],
        "quality": quality == null ? null : quality,
      }..removeWhere((key, value) => key == null || value == null);
}

/// An image export type.
enum ImageExportType {
  /// The exported image is returned as a data URL which
  /// encodes the exported image.
  dataUrl,

  /// The exported image is saved to a file and the corresponding
  /// file URL is returned.
  fileUrl
}

/// The corresponding values for the [ImageExportType].
final _imageExportTypeValues = _EnumValues(
    {"data-url": ImageExportType.dataUrl, "file-url": ImageExportType.fileUrl});

/// An image format.
enum ImageFormat {
  /// heif format.
  heif,

  /// jpeg format.
  jpeg,

  /// png format.
  png,

  /// tiff format.
  tiff
}

/// The corresponding values for the [ImageFormat].
final _imageFormatValues = _EnumValues({
  "image/heif": ImageFormat.heif,
  "image/jpeg": ImageFormat.jpeg,
  "image/png": ImageFormat.png,
  "image/tiff": ImageFormat.tiff
});

/// Export configuration of the serialized image and video editing
/// operations that were applied to the input media loaded into the editor.
/// This also allows to recover these operations the next
/// time the editor is opened again.
class SerializationOptions {
  /// Creates new [SerializationOptions].
  SerializationOptions({
    this.embedSourceImage,
    this.enabled,
    this.exportType,
    this.filename,
  });

  /// Whether the serialization data should include the original input
  /// image data.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool embedSourceImage;

  /// Whether the serialization of the editing operations should be exported.
  final bool enabled;

  /// The serialization export type.
  /// ```
  /// // Defaults to:
  /// SerializationExportType.fileUrl
  /// ```
  final SerializationExportType exportType;

  /// The filename for the exported serialization data if the `exportType` is
  /// `SerializationExportType.fileUrl`.
  /// The filename extension for JSON will be automatically added.
  /// It can be an absolute path or file URL or a relative path.
  /// If some relative path is chosen it will be created in a temporary system
  /// directory and overwritten if the corresponding file already exists.
  /// If the value is `null` an new temporary file will be
  /// created for every export based on the filename for the exported image or
  /// video data.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String filename;

  /// Converts [SerializationOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "embedSourceImage": embedSourceImage == null ? null : embedSourceImage,
        "enabled": enabled == null ? null : enabled,
        "exportType": exportType == null
            ? null
            : _serializationExportTypeValues.reverse[exportType],
        "filename": filename == null ? null : filename,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A serialization export type.
enum SerializationExportType {
  /// The exported serialization is saved to a file and the corresponding file
  /// URL is returned.
  fileUrl,

  /// The exported serialization is returned as an object.
  object
}

/// The corresponding values to the [SerializationExportType].
final _serializationExportTypeValues = _EnumValues({
  "file-url": SerializationExportType.fileUrl,
  "object": SerializationExportType.object
});

/// Video export configuration if the editor supports video editing.
class VideoOptions {
  /// Creates new [VideoOptions].
  VideoOptions({
    this.bitRate,
    this.codec,
    this.format,
    this.quality,
  });

  /// The bit rate in bits per second to use when exporting to VideoCodec.H264.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final double bitRate;

  /// The video codec to use for the exported video.
  /// ```
  /// // Defaults to:
  /// VideoCodec.h264
  /// ```
  final VideoCodec codec;

  /// The video container format to export.
  /// ```
  /// // Defaults to:
  /// VideoFormat.mp4
  /// ```
  final VideoFormat format;

  /// The compression quality to use when exporting to VideoCodec.hevc.
  /// ```
  /// // Defaults to:
  /// 0.9
  /// ```
  final double quality;

  /// Converts [VideoOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "bitRate": bitRate == null ? null : bitRate,
        "codec": codec == null ? null : _videoCodecValues.reverse[codec],
        "format": format == null ? null : _videoFormatValues.reverse[format],
        "quality": quality == null ? null : quality,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A video codec.
enum VideoCodec {
  /// H264 codec
  h264,

  /// HEVC codec.
  hevc
}

/// The corresponding
final _videoCodecValues =
    _EnumValues({"h264": VideoCodec.h264, "hevc": VideoCodec.hevc});

/// A video format.
enum VideoFormat {
  /// mp4 video format.
  mp4,

  /// quicktime format **(for iOS only)**.
  quicktime
}

/// The corresponding values for [VideoFormat].
final _videoFormatValues = _EnumValues(
    {"video/mp4": VideoFormat.mp4, "video/quicktime": VideoFormat.quicktime});

/// Configuration options for `Tool.filter`.
class FilterOptions {
  /// Creates new [FilterOptions].
  FilterOptions({
    this.categories,
    this.flattenCategories,
  });

  /// Defines all available filters. Each filter must be assigned to a category.
  /// New items and categories can be mixed and matched with existing ones.
  /// `none` is always added.
  /// ```
  /// // Defaults to:
  /// final categories = <FilterCategory>[
  ///  FilterCategory.existing(
  ///      identifier: "imgly_filter_category_duotone",
  ///      items: [
  ///        Filter.existing(identifier: "imgly_duotone_desert"),
  ///        Filter.existing(identifier: "imgly_duotone_peach"),
  ///        Filter.existing(identifier: "imgly_duotone_clash"),
  ///        Filter.existing(identifier: "imgly_duotone_plum"),
  ///        Filter.existing(identifier: "imgly_duotone_breezy"),
  ///        Filter.existing(identifier: "imgly_duotone_deepblue"),
  ///        Filter.existing(identifier: "imgly_duotone_frog"),
  ///        Filter.existing(identifier: "imgly_duotone_sunset"),
  ///      ]),
  ///  FilterCategory.existing(identifier: "imgly_filter_category_bw", items: [
  ///    Filter.existing(identifier: "imgly_lut_ad1920"),
  ///    Filter.existing(identifier: "imgly_lut_bw"),
  ///    Filter.existing(identifier: "imgly_lut_x400"),
  ///    Filter.existing(identifier: "imgly_lut_litho"),
  ///    Filter.existing(identifier: "imgly_lut_sepiahigh"),
  ///    Filter.existing(identifier: "imgly_lut_plate"),
  ///    Filter.existing(identifier: "imgly_lut_sin"),
  ///  ]),
  ///  FilterCategory.existing(
  ///      identifier: "imgly_filter_category_vintage",
  ///      items: [
  ///        Filter.existing(identifier: "imgly_lut_blues"),
  ///        Filter.existing(identifier: "imgly_lut_front"),
  ///        Filter.existing(identifier: "imgly_lut_texas"),
  ///        Filter.existing(identifier: "imgly_lut_celsius"),
  ///        Filter.existing(identifier: "imgly_lut_cool"),
  ///      ]),
  ///  FilterCategory.existing(
  ///      identifier: "imgly_filter_category_smooth",
  ///      items: [
  ///       Filter.existing(identifier: "imgly_lut_chest"),
  ///        Filter.existing(identifier: "imgly_lut_winter"),
  ///        Filter.existing(identifier: "imgly_lut_kdynamic"),
  ///        Filter.existing(identifier: "imgly_lut_fall"),
  ///        Filter.existing(identifier: "imgly_lut_lenin"),
  ///        Filter.existing(identifier: "imgly_lut_pola669"),
  ///      ]),
  // ignore: lines_longer_than_80_chars
  ///  FilterCategory.existing(identifier: "imgly_filter_category_cold", items: [
  ///    Filter.existing(identifier: "imgly_lut_elder"),
  ///    Filter.existing(identifier: "imgly_lut_orchid"),
  ///    Filter.existing(identifier: "imgly_lut_bleached"),
  ///    Filter.existing(identifier: "imgly_lut_bleachedblue"),
  ///    Filter.existing(identifier: "imgly_lut_breeze"),
  ///    Filter.existing(identifier: "imgly_lut_blueshadows"),
  ///  ]),
  // ignore: lines_longer_than_80_chars
  ///  FilterCategory.existing(identifier: "imgly_filter_category_warm", items: [
  ///    Filter.existing(identifier: "imgly_lut_sunset"),
  ///    Filter.existing(identifier: "imgly_lut_eighties"),
  ///    Filter.existing(identifier: "imgly_lut_evening"),
  ///    Filter.existing(identifier: "imgly_lut_k2"),
  ///    Filter.existing(identifier: "imgly_lut_nogreen"),
  ///  ]),
  ///  FilterCategory.existing(
  ///      identifier: "imgly_filter_category_legacy",
  ///      items: [
  ///        Filter.existing(identifier: "imgly_lut_ancient"),
  ///        Filter.existing(identifier: "imgly_lut_cottoncandy"),
  ///        Filter.existing(identifier: "imgly_lut_classic"),
  ///        Filter.existing(identifier: "imgly_lut_colorful"),
  ///        Filter.existing(identifier: "imgly_lut_creamy"),
  ///        Filter.existing(identifier: "imgly_lut_fixie"),
  ///        Filter.existing(identifier: "imgly_lut_food"),
  ///        Filter.existing(identifier: "imgly_lut_fridge"),
  ///        Filter.existing(identifier: "imgly_lut_glam"),
  ///        Filter.existing(identifier: "imgly_lut_gobblin"),
  ///        Filter.existing(identifier: "imgly_lut_highcontrast"),
  ///        Filter.existing(identifier: "imgly_lut_highcarb"),
  ///        Filter.existing(identifier: "imgly_lut_k1"),
  ///        Filter.existing(identifier: "imgly_lut_k6"),
  ///        Filter.existing(identifier: "imgly_lut_keen"),
  ///        Filter.existing(identifier: "imgly_lut_lomo"),
  ///        Filter.existing(identifier: "imgly_lut_lomo100"),
  ///        Filter.existing(identifier: "imgly_lut_lucid"),
  ///        Filter.existing(identifier: "imgly_lut_mellow"),
  ///        Filter.existing(identifier: "imgly_lut_neat"),
  ///        Filter.existing(identifier: "imgly_lut_pale"),
  ///        Filter.existing(identifier: "imgly_lut_pitched"),
  ///        Filter.existing(identifier: "imgly_lut_polasx"),
  ///        Filter.existing(identifier: "imgly_lut_pro400"),
  ///        Filter.existing(identifier: "imgly_lut_quozi"),
  ///        Filter.existing(identifier: "imgly_lut_settled"),
  ///        Filter.existing(identifier: "imgly_lut_seventies"),
  ///        Filter.existing(identifier: "imgly_lut_soft"),
  ///        Filter.existing(identifier: "imgly_lut_steel"),
  ///        Filter.existing(identifier: "imgly_lut_summer"),
  ///        Filter.existing(identifier: "imgly_lut_tender"),
  ///        Filter.existing(identifier: "imgly_lut_twilight"),
  ///     ])
  /// ];
  /// ```
  final List<FilterCategory> categories;

  /// Whether categories should be flattened which effectively hides
  /// the categories. If this is enabled all filters will be shown in
  /// the top-level of the filter selection tool
  /// ordered according to their parent category.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool flattenCategories;

  /// Converts [FilterOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x._toJson())),
        "flattenCategories":
            flattenCategories == null ? null : flattenCategories,
      }..removeWhere((key, value) => key == null || value == null);
}

/// Configuration options for `Tool.focus`.
class FocusOptions {
  /// Creates [FocusOptions].
  FocusOptions({
    this.items,
  });

  /// Defines all allowed focus tools. The focus tool buttons are
  /// shown in the given order.
  /// `none` is always added.
  /// ```
  /// // Defaults to:
  /// [FocusTool.none, FocusTool.radial, FocusTool.mirrored,
  /// FocusTool.linear, FocusTool.gaussian]
  /// ```
  final List<FocusTool> items;

  /// Converts [FocusOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => _focusToolValues.reverse[x])),
      }..removeWhere((key, value) => key == null || value == null);
}

/// A blur tool.
enum FocusTool {
  /// Gaussian focus.
  gaussian,

  /// Linear focus.
  linear,

  /// Mirrored focus.
  mirrored,

  /// No focus.
  none,

  /// Radial focus.
  radial
}

/// The corresponding values for the [FocusTool].
final _focusToolValues = _EnumValues({
  "gaussian": FocusTool.gaussian,
  "linear": FocusTool.linear,
  "mirrored": FocusTool.mirrored,
  "none": FocusTool.none,
  "radial": FocusTool.radial
});

/// Configuration options for `Tool.frame`.
class FrameOptions {
  /// Creates new [FrameOptions].
  FrameOptions({
    this.actions,
    this.items,
  });

  /// Defines all allowed actions for the frame tool menu. Only buttons for
  /// allowed actions are visible and shown in the given order.
  /// ```
  /// // Defaults to:
  /// [FrameAction.replace, FrameAction.width, FrameAction.opacity]
  /// ```
  final List<FrameAction> actions;

  /// Defines all available frames.
  /// New items can be mixed and matched with existing ones.
  /// `none` is always added.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   Frame.existing(identifier: "imgly_frame_dia"),
  ///   Frame.existing(identifier: "imgly_frame_art_decor"),
  ///   Frame.existing(identifier: "imgly_frame_black_passepartout"),
  ///   Frame.existing(identifier: "imgly_frame_wood_passepartout"),
  /// ];
  /// ```
  final List<Frame> items;

  /// Converts [FrameOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "actions": actions == null
            ? null
            : List<dynamic>.from(
                actions.map((x) => _frameActionValues.reverse[x])),
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x._toJson())),
      }..removeWhere((key, value) => key == null || value == null);
}

/// A frame action.
enum FrameAction {
  /// Change the opacity of the frame.
  opacity,

  /// Replace the frame.
  replace,

  /// Change the width of the frame.
  width
}

/// The corresponding values for a [FrameAction].
final _frameActionValues = _EnumValues({
  "opacity": FrameAction.opacity,
  "replace": FrameAction.replace,
  "width": FrameAction.width
});

/// A frame.
class Frame extends _NamedItem {
  /// Creates a new [Frame].
  Frame(
    String identifier,
    String name,
    this.imageGroups,
    this.relativeScale,
    this.thumbnailUri, {
    this.layoutMode,
  }) : super(identifier, name);

  /// Retrieves an existing [Frame] with the given [identifier].
  Frame.existing(String identifier) : this(identifier, null, null, null, null);

  /// Images for the 12-patch layout of a dynamic frame
  /// that automatically adapts to
  /// any output image resolution.
  final ImageGroupSet imageGroups;

  /// The layout mode of the patches of the frame.
  /// ```
  /// // Defaults to:
  /// FrameLayoutMode.horizontalInside
  /// ```
  final FrameLayoutMode layoutMode;

  /// The relative scale of the frame which is defined in relatation
  /// to the shorter side of the resulting output image.
  final double relativeScale;

  /// The source for the thumbnail image of the frame.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  final String thumbnailUri;

  Map<String, dynamic> _toJson() => {
        "identifier": identifier == null ? null : identifier,
        "imageGroups": imageGroups == null ? null : imageGroups._toJson(),
        "layoutMode": layoutMode == null
            ? null
            : _frameLayoutModeValues.reverse[layoutMode],
        "name": name == null ? null : name,
        "relativeScale": relativeScale == null ? null : relativeScale,
        "thumbnailURI": thumbnailUri == null ? null : thumbnailUri,
      }..removeWhere((key, value) => key == null || value == null);
}

/// Images for the 12-patch layout of a dynamic frame that automatically
/// adapts to any output image resolution.
class ImageGroupSet {
  /// Creates a new [ImageGroupSet].
  ImageGroupSet({
    this.bottom,
    this.left,
    this.right,
    this.top,
  });

  /// The bottom image group.
  /// If `null` there is no top group.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final FrameImageGroup bottom;

  /// The left image group.
  /// If `null` there is no top group.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final FrameImageGroup left;

  /// The right image group.
  /// If `null` there is no top group.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final FrameImageGroup right;

  /// The top image group.
  /// If `null` there is no top group.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final FrameImageGroup top;

  /// Converts an [ImageGroupSet] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "bottom": bottom == null ? null : bottom._toJson(),
        "left": left == null ? null : left._toJson(),
        "right": right == null ? null : right._toJson(),
        "top": top == null ? null : top._toJson(),
      }..removeWhere((key, value) => key == null || value == null);
}

/// An image group for the 12-patch layout of a dynamic frame.
class FrameImageGroup {
  /// Creates a new [FrameImageGroup].
  FrameImageGroup(
    this.midUri, {
    this.startUri,
    this.endUri,
    this.midMode,
  });

  /// The source for the end image.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  /// If `null` there is no end image.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String endUri;

  /// The render mode for the middle image.
  /// ```
  /// // Defaults to:
  /// FrameTileMode.repeat
  /// ```
  final FrameTileMode midMode;

  /// The source for the mid image.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  /// If `null` there is no mid image.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String midUri;

  /// The source for start image.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  /// If `null` there is no start image.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String startUri;

  /// Converts a [FrameImageGroup] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "endURI": endUri == null ? null : endUri,
        "midMode":
            midMode == null ? null : _frameTileModeValues.reverse[midMode],
        "midURI": midUri == null ? null : midUri,
        "startURI": startUri == null ? null : startUri,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A frame tile mode.
enum FrameTileMode {
  /// Combines multiple instances of the frame tile
  /// to fit the size of the frame.
  repeat,

  /// Stretches a frame tile in order to fit
  /// the size of the frame.
  stretch
}

/// The corresponding values for a [FrameTileMode].
final _frameTileModeValues = _EnumValues(
    {"repeat": FrameTileMode.repeat, "stretch": FrameTileMode.stretch});

/// A frame layout mode.
enum FrameLayoutMode {
  /// The asset is in the horizontal group.
  /// For further reference, please take a look into our [docs](https://docs.photoeditorsdk.com/guides/ios/v10/features/frames).
  horizontalInside,

  /// The asset is in the vertical group.
  /// For further reference, please take a look into our [docs](https://docs.photoeditorsdk.com/guides/ios/v10/features/frames).
  verticalInside
}

/// The corresponding values for a [FrameLayoutMode].
final _frameLayoutModeValues = _EnumValues({
  "horizontal-inside": FrameLayoutMode.horizontalInside,
  "vertical-inside": FrameLayoutMode.verticalInside
});

/// A main canvas action.
enum MainCanvasAction {
  /// Redo the action(s).
  redo,

  /// Undo the action(s).
  undo
}

/// The corresponding values to the [MainCanvasAction].
final _mainCanvasActionValues =
    _EnumValues({"redo": MainCanvasAction.redo, "undo": MainCanvasAction.undo});

/// Configuration options for `Tool.overlay`.
class OverlayOptions {
  /// Creates new [OverlayOptions].
  OverlayOptions({
    this.blendModes,
    this.items,
  });

  /// Defines all allowed blend modes for the overlays.
  /// ```
  /// // Defaults to:
  /// [BlendMode.normal, BlendMode.multiply, BlendMode.overlay,
  /// BlendMode.screen, BlendMode.lighten, BlendMode.softLight,
  /// BlendMode.hardLight, BlendMode.darken, BlendMode.colorBurn]
  /// ```
  final List<BlendMode> blendModes;

  /// Defines all available overlays.
  /// New items can be mixed and matched with existing ones.
  /// `none` is always added.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   Overlay.existing(identifier: "imgly_overlay_golden"),
  ///   Overlay.existing(identifier: "imgly_overlay_lightleak1"),
  ///   Overlay.existing(identifier: "imgly_overlay_rain"),
  ///   Overlay.existing(identifier: "imgly_overlay_mosaic"),
  ///   Overlay.existing(identifier: "imgly_overlay_vintage"),
  ///   Overlay.existing(identifier: "imgly_overlay_paper"),
  /// ];
  /// ```
  final List<Overlay> items;

  /// Converts [OverlayOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "blendModes": blendModes == null
            ? null
            : List<dynamic>.from(
                blendModes.map((x) => _blendModeValues.reverse[x])),
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x._toJson())),
      }..removeWhere((key, value) => key == null || value == null);
}

/// A blend mode.
enum BlendMode {
  /// ColorBurn mode.
  colorBurn,

  /// Darken mode.
  darken,

  /// HardLight mode.
  hardLight,

  /// Lighten mode.
  lighten,

  /// Multiply mode.
  multiply,

  /// Normal mode.
  normal,

  /// Overlay mode.
  overlay,

  /// Screen mode.
  screen,

  /// SoftLight mode.
  softLight
}

/// The corresponding values to the [BlendMode].
final _blendModeValues = _EnumValues({
  "colorburn": BlendMode.colorBurn,
  "darken": BlendMode.darken,
  "hardlight": BlendMode.hardLight,
  "lighten": BlendMode.lighten,
  "multiply": BlendMode.multiply,
  "normal": BlendMode.normal,
  "overlay": BlendMode.overlay,
  "screen": BlendMode.screen,
  "softlight": BlendMode.softLight
});

/// An overlay.
class Overlay extends _NamedItem {
  /// Creates a new [Overlay].
  Overlay(
    String identifier,
    String name,
    this.defaultBlendMode,
    this.overlayUri, {
    this.thumbnailUri,
  }) : super(identifier, name);

  /// Retrieves an existing [Overlay] with the given [identifier].
  Overlay.existing(String identifier)
      : this(identifier, null, null, null, thumbnailUri: null);

  /// The default blend mode that is used to apply the overlay.
  final BlendMode defaultBlendMode;

  /// The source for the overlay.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  final String overlayUri;

  /// The source for the thumbnail of the overlay.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  /// If `null` the thumbnail will be automatically generated form the
  /// [overlayURI].
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String thumbnailUri;

  /// Converts an [Overlay] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "identifier": identifier == null ? null : identifier,
        "defaultBlendMode": defaultBlendMode == null
            ? null
            : _blendModeValues.reverse[defaultBlendMode],
        "name": name == null ? null : name,
        "overlayURI": overlayUri == null ? null : overlayUri,
        "thumbnailURI": thumbnailUri == null ? null : thumbnailUri,
      }..removeWhere((key, value) => key == null || value == null);
}

/// Global snapping options for all sprites, e.g., stickers, texts,
/// and text designs.
class SnappingOptions {
  /// Creates new [SnappingOptions].
  SnappingOptions({
    this.position,
    this.rotation,
  });

  /// Snapping options for positioning sprites.
  final PositionSnappingOptions position;

  /// Snapping options for rotating sprites.
  final RotationSnappingOptions rotation;

  /// Converts [SnappingOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "position": position == null ? null : position._toJson(),
        "rotation": rotation == null ? null : rotation._toJson(),
      }..removeWhere((key, value) => key == null || value == null);
}

/// Snapping options for positioning sprites.
class PositionSnappingOptions {
  /// Creates new [PositionSnappingOptions].
  PositionSnappingOptions({
    this.enabled,
    this.snapToBottom,
    this.snapToHorizontalCenter,
    this.snapToLeft,
    this.snapToRight,
    this.snapToTop,
    this.snapToVerticalCenter,
    this.threshold,
  });

  /// Whether sprites should snap to specific positions during pan interactions.
  /// This switch enables or disables position snapping.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool enabled;

  /// The bottom side of a sprite's bounding box snaps to a horizontal line
  /// which is shifted from the bottom side of the edited image towards its
  /// center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double snapToBottom;

  /// If enabled a sprite's center snaps to the horizontal line through the
  /// center of the edited image.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool snapToHorizontalCenter;

  /// The bottom side of a sprite's bounding box snaps to a horizontal line
  /// which is shifted from the left side of the edited image towards its
  /// center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double snapToLeft;

  /// The bottom side of a sprite's bounding box snaps to a horizontal
  /// line which is shifted from the right side of the edited image towards
  /// its center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double snapToRight;

  /// The bottom side of a sprite's bounding box snaps to a horizontal line
  /// which is shifted from the right side of the edited image towards its
  /// center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double snapToTop;

  /// If enabled a sprite's center snaps to the vertical line through the
  /// center of the edited image.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool snapToVerticalCenter;

  /// This threshold defines the distance of a pan gesture where snapping
  /// at a snap point occurs. It is measured in points.
  /// ```
  /// // Defaults to:
  /// 20
  /// ```
  final double threshold;

  /// The keys that can explicitly be set to null.
  static const List<String> nullSupported = [
    "snapToLeft",
    "snapToRight",
    "snapToTop",
    "snapToBottom"
  ];

  /// Converts [PositionSnappingOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "enabled": enabled == null ? null : enabled,
        "snapToBottom": snapToBottom == null ? null : snapToBottom,
        "snapToHorizontalCenter":
            snapToHorizontalCenter == null ? null : snapToHorizontalCenter,
        "snapToLeft": snapToLeft == null ? null : snapToLeft,
        "snapToRight": snapToRight == null ? null : snapToRight,
        "snapToTop": snapToTop == null ? null : snapToTop,
        "snapToVerticalCenter":
            snapToVerticalCenter == null ? null : snapToVerticalCenter,
        "threshold": threshold == null ? null : threshold,
      }..removeWhere((key, value) =>
          key == null || value == null && !nullSupported.contains(key));
}

/// Snapping options for rotating sprites.
class RotationSnappingOptions {
  /// Creates new [RotationSnappingOptions].
  RotationSnappingOptions({
    this.enabled,
    this.snapToAngles,
    this.threshold,
  });

  /// Whether sprites should snap to specific orientations during
  /// rotation interactions. This switch enables or disables rotation snapping.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool enabled;

  /// Enabled snapping angles in degrees for rotating a sprite.
  /// The rotation angle is defined clockwise.
  /// ```
  /// // Defaults to:
  /// [0, 45, 90, 135, 180, 225, 270, 315]
  /// ```
  final List<double> snapToAngles;

  /// This threshold defines the arc length of a rotation gesture where
  /// snapping at a snap angle occurs. It is measured in points.
  /// ```
  /// // Defaults to:
  /// 20
  /// ```
  final double threshold;

  /// Converts [RotationSnappingOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "enabled": enabled == null ? null : enabled,
        "snapToAngles": snapToAngles == null
            ? null
            : List<dynamic>.from(snapToAngles.map((x) => x)),
        "threshold": threshold == null ? null : threshold,
      }..removeWhere((key, value) => key == null || value == null);
}

/// Configuration options for `Tool.sticker`.
class StickerOptions {
  /// Creates new [StickerOptions].
  StickerOptions({
    this.actions,
    this.canvasActions,
    this.categories,
    this.colors,
    this.defaultPersonalStickerTintMode,
    this.personalStickers,
  });

  /// Defines all allowed actions for the sticker tool menu. Only buttons for
  /// allowed actions are visible and shown in the given order.
  /// ```
  /// // Defaults to:
  /// [StickerAction.replace, StickerAction.opacity, StickerAction.color]
  /// ```
  final List<StickerAction> actions;

  /// Defines all allowed actions for the sticker tool that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.add, CanvasAction.delete, CanvasAction.flip,
  /// CanvasAction.bringToFront, CanvasAction.undo, CanvasAction.redo]
  /// ```
  final List<StickerCanvasAction> canvasActions;

  /// Defines all available stickers. Each sticker must be assigned to a
  /// category. New items and categories can be mixed and matched with
  /// existing ones.
  /// **If this array is `null` the defaults are used but the sticker category**
  /// **with the identifier `imgly_sticker_category_animated` is only shown**
  /// **when editing videos.**
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   StickerCategory.existing(
  ///       identifier: "imgly_sticker_category_emoticons",
  ///       items: [
  ///         Sticker.existing(identifier: "imgly_smart_sticker_weekday"),
  ///         Sticker.existing(identifier: "imgly_smart_sticker_date"),
  ///         Sticker.existing(identifier: "imgly_smart_sticker_time"),
  ///         Sticker.existing(identifier: "imgly_smart_sticker_time_clock"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_grin"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_laugh"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_smile"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_wink"),
  // ignore: lines_longer_than_80_chars
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_tongue_out_wink"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_angel"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_kisses"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_loving"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_kiss"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_wave"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_nerd"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_cool"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_blush"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_duckface"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_furious"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_angry"),
  // ignore: lines_longer_than_80_chars
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_steaming_furious"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_anxious"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_cry"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_sobbing"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_loud_cry"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_wide_grin"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_impatient"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_tired"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_asleep"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_sleepy"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_deceased"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_attention"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_question"),
  // ignore: lines_longer_than_80_chars
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_not_speaking_to_you"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_sick"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_pumpkin"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_boxer"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_idea"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_smoking"),
  // ignore: lines_longer_than_80_chars
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_skateboard"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_guitar"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_music"),
  // ignore: lines_longer_than_80_chars
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_sunbathing"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_hippie"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_humourous"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_hitman"),
  // ignore: lines_longer_than_80_chars
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_harry_potter"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_business"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_batman"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_skull"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_ninja"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_masked"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_alien"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_wrestler"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_devil"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_star"),
  // ignore: lines_longer_than_80_chars
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_baby_chicken"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_rabbit"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_pig"),
  ///         Sticker.existing(identifier: "imgly_sticker_emoticons_chicken"),
  ///       ]),
  ///   StickerCategory.existing(
  ///       identifier: "imgly_sticker_category_shapes",
  ///       items: [
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_01"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_04"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_12"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_06"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_13"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_36"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_08"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_11"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_35"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_28"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_32"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_15"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_20"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_18"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_badge_19"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_arrow_02"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_arrow_03"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_spray_01"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_spray_04"),
  ///         Sticker.existing(identifier: "imgly_sticker_shapes_spray_03"),
  ///       ]),
  ///   StickerCategory.existing(
  ///       identifier: "imgly_sticker_category_animated",
  ///       items: [
  ///         Sticker.existing(identifier: "imgly_sticker_animated_camera"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_clouds"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_coffee"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_fire"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_flower"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_gift"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_heart"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_movie_clap"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_rainbow"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_stars"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_sun"),
  ///         Sticker.existing(identifier: "imgly_sticker_animated_thumbs_up"),
  ///       ])
  /// ];
  /// ```
  final List<StickerCategory> categories;

  /// Defines all available colors that can be applied to stickers with a
  /// `tintMode` other than `TintMode.none`.
  /// The color pipette is always added.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   NamedColor(color: Color([0.00, 0.00, 0.00, 0]), name: "Transparent"),
  ///   NamedColor(color: Color([1.00, 1.00, 1.00, 1]), name: "White"),
  ///   NamedColor(color: Color([0.49, 0.49, 0.49, 1]), name: "Gray"),
  ///   NamedColor(color: Color([0.00, 0.00, 0.00, 1]), name: "Black"),
  ///   NamedColor(color: Color([0.40, 0.80, 1.00, 1]), name: "Light blue"),
  ///   NamedColor(color: Color([0.40, 0.53, 1.00, 1]), name: "Blue"),
  ///   NamedColor(color: Color([0.53, 0.40, 1.00, 1]), name: "Purple"),
  ///   NamedColor(color: Color([0.87, 0.40, 1.00, 1]), name: "Orchid"),
  ///   NamedColor(color: Color([1.00, 0.40, 0.80, 1]), name: "Pink"),
  ///   NamedColor(color: Color([0.90, 0.31, 0.31, 1]), name: "Red"),
  ///   NamedColor(color: Color([0.95, 0.53, 0.33, 1]), name: "Orange"),
  ///   NamedColor(color: Color([1.00, 0.80, 0.40, 1]), name: "Gold"),
  ///   NamedColor(color: Color([1.00, 0.97, 0.39, 1]), name: "Yellow"),
  ///   NamedColor(color: Color([0.80, 1.00, 0.40, 1]), name: "Olive"),
  ///   NamedColor(color: Color([0.33, 1.00, 0.53, 1]), name: "Green"),
  ///   NamedColor(color: Color([0.33, 1.00, 0.92, 1]), name: "Aquamarin"),
  /// ];
  /// ```
  final ColorPalette colors;

  /// The default tint mode for personal stickers.
  /// ```
  /// // Defaults to:
  /// TintMode.none
  /// ```
  final TintMode defaultPersonalStickerTintMode;

  /// If enabled the user can create personal stickers from the device's photo
  /// library. A button is added as first item in the menu in front of the
  /// sticker categories which modally presents an image selection dialog for
  /// personal sticker creation. Personal stickers will be added to a personal
  /// sticker category with the identifier `"imgly_sticker_category_personal"`
  /// which will be added between the button and the regular sticker categories
  /// if it does not exist.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool personalStickers;

  /// Converts the [StickerOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "actions": actions == null
            ? null
            : List<dynamic>.from(
                actions.map((x) => _stickerActionValues.reverse[x])),
        "canvasActions": canvasActions == null
            ? null
            : List<dynamic>.from(canvasActions
                .map((x) => _stickerCanvasActionValues.reverse[x])),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x._toJson())),
        "colors": colors == null ? null : colors._toJson(),
        "defaultPersonalStickerTintMode": defaultPersonalStickerTintMode == null
            ? null
            : _tintModeValues.reverse[defaultPersonalStickerTintMode],
        "personalStickers": personalStickers == null ? null : personalStickers,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A sticker action.
enum StickerAction {
  /// Change the brightness of the sticker.
  brightness,

  /// Change the color of the sticker.
  color,

  /// Change the contrast of the sticker.
  contrast,

  /// Change the opacity of the sticker.
  opacity,

  /// Replace the sticker.
  replace,

  /// Change the saturation of the sticker.
  saturation,

  /// Straighten the sticker.
  straighten
}

/// The corresponding values to the [StickerAction].
final _stickerActionValues = _EnumValues({
  "brightness": StickerAction.brightness,
  "color": StickerAction.color,
  "contrast": StickerAction.contrast,
  "opacity": StickerAction.opacity,
  "replace": StickerAction.replace,
  "saturation": StickerAction.saturation,
  "straighten": StickerAction.straighten
});

/// A sticker canvas action.
enum StickerCanvasAction {
  /// Add a new sticker.
  add,

  /// Bring the selected sticker to the front.
  bringToFront,

  /// Delete the selected sticker.
  delete,

  /// Flip the selected sticker.
  flip,

  /// Redo the action(s).
  redo,

  /// Undo the action(s).
  undo
}

/// The corresponding values to the [StickerCanvasAction].
final _stickerCanvasActionValues = _EnumValues({
  "add": StickerCanvasAction.add,
  "bringtofront": StickerCanvasAction.bringToFront,
  "delete": StickerCanvasAction.delete,
  "flip": StickerCanvasAction.flip,
  "redo": StickerCanvasAction.redo,
  "undo": StickerCanvasAction.undo
});

/// A tint mode.
enum TintMode {
  /// Colorized tint mode.
  colorized,

  /// No tint mode.
  none,

  /// Solid tint mode.
  solid
}

/// The corresponding values for the [TintMode].
final _tintModeValues = _EnumValues({
  "colorized": TintMode.colorized,
  "none": TintMode.none,
  "solid": TintMode.solid
});

/// Configuration options for `Tool.text`.
class TextOptions {
  /// Creates new [TextOptions].
  TextOptions({
    this.actions,
    this.backgroundColors,
    this.canvasActions,
    this.defaultTextColor,
    this.fonts,
    this.textColors,
  });

  /// Defines all allowed actions for the text tool menu. Only buttons for
  /// allowed actions are visible and shown in the given order.
  /// ```
  /// // Defaults to:
  /// [TextAction.font, TextAction.color,
  /// TextAction.backgroundColor, TextAction.alignment]
  /// ```
  final List<TextAction> actions;

  /// Defines all available colors that can be applied to the background.
  /// The color pipette is always added.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   NamedColor(color: Color([0.00, 0.00, 0.00, 0]), name: "Transparent"),
  ///   NamedColor(color: Color([1.00, 1.00, 1.00, 1]), name: "White"),
  ///   NamedColor(color: Color([0.49, 0.49, 0.49, 1]), name: "Gray"),
  ///   NamedColor(color: Color([0.00, 0.00, 0.00, 1]), name: "Black"),
  ///   NamedColor(color: Color([0.40, 0.80, 1.00, 1]), name: "Light blue"),
  ///   NamedColor(color: Color([0.40, 0.53, 1.00, 1]), name: "Blue"),
  ///   NamedColor(color: Color([0.53, 0.40, 1.00, 1]), name: "Purple"),
  ///   NamedColor(color: Color([0.87, 0.40, 1.00, 1]), name: "Orchid"),
  ///   NamedColor(color: Color([1.00, 0.40, 0.80, 1]), name: "Pink"),
  ///   NamedColor(color: Color([0.90, 0.31, 0.31, 1]), name: "Red"),
  ///   NamedColor(color: Color([0.95, 0.53, 0.33, 1]), name: "Orange"),
  ///   NamedColor(color: Color([1.00, 0.80, 0.40, 1]), name: "Gold"),
  ///   NamedColor(color: Color([1.00, 0.97, 0.39, 1]), name: "Yellow"),
  ///   NamedColor(color: Color([0.80, 1.00, 0.40, 1]), name: "Olive"),
  ///   NamedColor(color: Color([0.33, 1.00, 0.53, 1]), name: "Green"),
  ///   NamedColor(color: Color([0.33, 1.00, 0.92, 1]), name: "Aquamarin"),
  /// ];
  /// ```
  final ColorPalette backgroundColors;

  /// Defines all allowed actions for the text tool that are displayed as
  /// overlay buttons on the canvas.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.add, CanvasAction.delete,
  /// CanvasAction.bringToFront, CanvasAction.undo,
  /// CanvasAction.redo]
  /// ```
  final List<StickerCanvasAction> canvasActions;

  /// Defines the default text color for newly created text.
  /// ```
  /// // Defaults to:
  /// [1, 1, 1, 1]
  /// ```
  final Color defaultTextColor;

  /// Defines all available fonts.
  /// New items can be mixed and matched with existing ones.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   Font.existing(identifier: "imgly_font_open_sans_bold"),
  ///   Font.existing(identifier: "imgly_font_aleo_bold"),
  ///   Font.existing(identifier: "imgly_font_amaticsc"),
  ///   Font.existing(identifier: "imgly_font_bernier_regular"),
  ///   Font.existing(identifier: "imgly_font_cheque_regular"),
  ///   Font.existing(identifier: "imgly_font_gagalin_regular"),
  ///   Font.existing(identifier: "imgly_font_hagin_caps_thin"),
  ///   Font.existing(identifier: "imgly_font_intro_inline"),
  ///   Font.existing(identifier: "imgly_font_lobster"),
  ///   Font.existing(identifier: "imgly_font_nexa_script"),
  ///   Font.existing(identifier: "imgly_font_ostrich_sans_black"),
  ///   Font.existing(identifier: "imgly_font_ostrich_sans_bold"),
  ///   Font.existing(identifier: "imgly_font_panton_blackitalic_caps"),
  ///   Font.existing(identifier: "imgly_font_panton_lightitalic_caps"),
  ///   Font.existing(identifier: "imgly_font_perfograma"),
  ///   Font.existing(identifier: "imgly_font_trash_hand"),
  /// ];
  /// ```
  final List<Font> fonts;

  /// Defines all available colors that can be applied to the text.
  /// The color pipette is always added.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   NamedColor(color: Color([0.00, 0.00, 0.00, 0]), name: "Transparent"),
  ///   NamedColor(color: Color([1.00, 1.00, 1.00, 1]), name: "White"),
  ///   NamedColor(color: Color([0.49, 0.49, 0.49, 1]), name: "Gray"),
  ///   NamedColor(color: Color([0.00, 0.00, 0.00, 1]), name: "Black"),
  ///   NamedColor(color: Color([0.40, 0.80, 1.00, 1]), name: "Light blue"),
  ///   NamedColor(color: Color([0.40, 0.53, 1.00, 1]), name: "Blue"),
  ///   NamedColor(color: Color([0.53, 0.40, 1.00, 1]), name: "Purple"),
  ///   NamedColor(color: Color([0.87, 0.40, 1.00, 1]), name: "Orchid"),
  ///   NamedColor(color: Color([1.00, 0.40, 0.80, 1]), name: "Pink"),
  ///   NamedColor(color: Color([0.90, 0.31, 0.31, 1]), name: "Red"),
  ///   NamedColor(color: Color([0.95, 0.53, 0.33, 1]), name: "Orange"),
  ///   NamedColor(color: Color([1.00, 0.80, 0.40, 1]), name: "Gold"),
  ///   NamedColor(color: Color([1.00, 0.97, 0.39, 1]), name: "Yellow"),
  ///   NamedColor(color: Color([0.80, 1.00, 0.40, 1]), name: "Olive"),
  ///   NamedColor(color: Color([0.33, 1.00, 0.53, 1]), name: "Green"),
  ///   NamedColor(color: Color([0.33, 1.00, 0.92, 1]), name: "Aquamarin"),
  /// ];
  /// ```
  final ColorPalette textColors;

  /// Converts the [TextOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "actions": actions == null
            ? null
            : List<dynamic>.from(
                actions.map((x) => _textActionValues.reverse[x])),
        "backgroundColors":
            backgroundColors == null ? null : backgroundColors._toJson(),
        "canvasActions": canvasActions == null
            ? null
            : List<dynamic>.from(canvasActions
                .map((x) => _stickerCanvasActionValues.reverse[x])),
        "defaultTextColor":
            defaultTextColor == null ? null : defaultTextColor._toJson(),
        "fonts": fonts == null
            ? null
            : List<dynamic>.from(fonts.map((x) => x._toJson())),
        "textColors": textColors == null ? null : textColors._toJson(),
      }..removeWhere((key, value) => key == null || value == null);
}

/// A text action.
enum TextAction {
  /// Change the text alignment.
  alignment,

  /// Change the background color.
  backgroundColor,

  /// Change the color.
  color,

  /// Change the font.
  font
}

/// The corresponding values for the [TextAction].
final _textActionValues = _EnumValues({
  "alignment": TextAction.alignment,
  "backgroundcolor": TextAction.backgroundColor,
  "color": TextAction.color,
  "font": TextAction.font
});

/// A font.
class Font extends _NamedItem {
  /// Creates a new [Font].
  Font(
    String identifier,
    this.fontName,
    String name, {
    this.fontUri,
  }) : super(identifier, name);

  /// Retrieves an existing [Font] with the given [identifier].
  Font.existing(String identifier)
      : this(identifier, null, null, fontUri: null);

  /// The actual font name or system font name, e.g. `Chalkduster`.
  final String fontName;

  /// The source of the font file. `TTF` and `OTF` fonts are allowed.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  /// If `null` the `fontName` is assumed to be a system font.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String fontUri;

  /// Converts the [Font] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "identifier": identifier == null ? null : identifier,
        "fontName": fontName == null ? null : fontName,
        "fontURI": fontUri == null ? null : fontUri,
        "name": name == null ? null : name,
      }..removeWhere((key, value) => key == null || value == null);
}

/// Configuration options for `Tool.textDesign`.
class TextDesignOptions {
  /// Creates new [TextDesignOptions].
  TextDesignOptions({
    this.canvasActions,
    this.colors,
    this.items,
  });

  /// The available [TextDesignCanvasAction] when a text design
  /// is selected.
  final List<TextDesignCanvasAction> canvasActions;

  /// The available colors to choose from.
  final ColorPalette colors;

  /// The available [TextDesign]s.
  final List<TextDesign> items;

  /// Converts the [TextDesignOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "canvasActions": canvasActions == null
            ? null
            : List<dynamic>.from(canvasActions
                .map((x) => _textDesignCanvasActionValues.reverse[x])),
        "colors": colors == null ? null : colors._toJson(),
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x._toJson())),
      }..removeWhere((key, value) => key == null || value == null);
}

/// A text design canvas action.
enum TextDesignCanvasAction {
  /// Add a new [TextDesign].
  add,

  /// Bring the selected [TextDesign] to the front.
  bringToFront,

  /// Delete the selected [TextDesign].
  delete,

  /// Invert the selected [TextDesign].
  invert,

  /// Redo the action(s).
  redo,

  /// Undo the action(s).
  undo
}

/// The corresponding values to the [TextDesignCanvasAction].
final _textDesignCanvasActionValues = _EnumValues({
  "add": TextDesignCanvasAction.add,
  "bringtofront": TextDesignCanvasAction.bringToFront,
  "delete": TextDesignCanvasAction.delete,
  "invert": TextDesignCanvasAction.invert,
  "redo": TextDesignCanvasAction.redo,
  "undo": TextDesignCanvasAction.undo
});

/// An existing text design.
class TextDesign extends _UniqueItem {
  /// Creates a new existing [TextDesign].
  TextDesign.existing(
    String identifier,
  ) : super(identifier);

  /// Converts the [TextDesign] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "identifier": identifier == null ? null : identifier,
      }..removeWhere((key, value) => key == null || value == null);
}

/// An image and/or video editing tool.
enum Tool {
  /// Adjust tool.
  adjustment,

  /// Brush tool.
  brush,

  /// Filter tool.
  filter,

  /// Focus tool.
  focus,

  /// Frame tool.
  frame,

  /// Overlay tool.
  overlay,

  /// Sticker tool.
  sticker,

  /// Text tool.
  text,

  /// Text design tool.
  textDesign,

  /// Transform tool.
  transform,

  /// Trim tool **(for videoeditor_sdk only)**.
  trim
}

/// The corresponding values to the [Tool].
final _toolValues = _EnumValues({
  "adjustment": Tool.adjustment,
  "brush": Tool.brush,
  "filter": Tool.filter,
  "focus": Tool.focus,
  "frame": Tool.frame,
  "overlay": Tool.overlay,
  "sticker": Tool.sticker,
  "text": Tool.text,
  "textdesign": Tool.textDesign,
  "transform": Tool.transform,
  "trim": Tool.trim
});

/// Configuration options for `Tool.transform`.
class TransformOptions {
  /// Creates new [TransformOptions].
  TransformOptions({
    this.allowFreeCrop,
    this.items,
    this.showResetButton,
  });

  /// Whether to allow free cropping. If this is enabled, free cropping is
  /// always the first available option.
  /// ```
  /// // Default to:
  /// true
  /// ```
  final bool allowFreeCrop;

  /// Defines all allowed crop aspect ratios. The crop ratio buttons are shown
  /// in the given order.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   CropRatio(width: 1, height: 1, name: "Square"),
  ///   CropRatio(width: 16, height: 9, toggleable: true),
  ///   CropRatio(width: 4, height: 3, toggleable: true),
  ///   CropRatio(width: 3, height: 2, toggleable: true),
  /// ];
  /// ```
  final List<CropRatio> items;

  /// Whether to show a reset button to reset the applied crop, rotation and
  /// tilt angle.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool showResetButton;

  /// Converts [TransformOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "allowFreeCrop": allowFreeCrop == null ? null : allowFreeCrop,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x._toJson())),
        "showResetButton": showResetButton == null ? null : showResetButton,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A crop aspect ratio.
class CropRatio {
  /// Creates a new [CropRatio].
  CropRatio(
    this.width,
    this.height, {
    this.name,
    this.toggleable,
  });

  /// The height of the ratio.
  final double height;

  /// A displayable name for the item which is also used for accessibility.
  /// If `null` the name is automatically generated from the `width` and
  /// `height` values and the name will always be overwritten by this
  /// auto-generated name if the user toggles the
  /// aspect when `toggleable` is enabled.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String name;

  /// If enabled the `width` and `height` of a ratio can be toggled in the UI.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool toggleable;

  /// The width of the ratio.
  final double width;

  /// Converts the [CropRatio] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "height": height == null ? null : height,
        "name": name == null ? null : name,
        "toggleable": toggleable == null ? null : toggleable,
        "width": width == null ? null : width,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A filter category.
class FilterCategory extends _NamedItem {
  /// Creates a new [FilterCategory].
  FilterCategory(
    String identifier,
    String name, {
    this.items,
    this.thumbnailUri,
  }) : super(identifier, name);

  /// Retrieves an existing [FilterCategory] with the given [identifier].
  /// You can further modify which existing [items] should be included.
  FilterCategory.existing(String identifier, {List<Filter> items})
      : this(identifier, null, items: items, thumbnailUri: null);

  /// Items of the category which can be existing or new defined filters.
  /// If `null` an empty category will be created.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final List<Filter> items;

  /// The source for the thumbnail image of the filter.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  /// If `null` the category will not have a thumbnail
  /// image which won't be required if `flattenCategories` is enabled
  /// for the `Tool.filter`.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String thumbnailUri;

  /// Converts the [FilterCategory] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "identifier": identifier == null ? null : identifier,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x._toJson())),
        "name": name == null ? null : name,
        "thumbnailURI": thumbnailUri == null ? null : thumbnailUri,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A Filter.
class Filter extends _NamedItem {
  /// Creates a new [Filter].
  Filter(String identifier, String name) : super(identifier, name);

  /// Retrieves an existing [Filter] with the given [identifier].
  Filter.existing(String identifier) : super.existing(identifier);

  /// Converts the [Filter] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "identifier": identifier == null ? null : identifier,
        "name": name == null ? null : name
      }..removeWhere((key, value) => key == null || value == null);
}

/// A look up table (LUT) image filter.
class LutFilter extends Filter {
  /// Creates a new [LutFilter].
  LutFilter(
    String identifier,
    String name,
    this.lutUri, {
    this.horizontalTileCount,
    this.verticalTileCount,
  }) : super(identifier, name);

  /// The source of the look up table (LUT) image.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  final String lutUri;

  /// The number of horizontal tiles in the LUT image.
  /// ```
  /// // Defaults to:
  /// 5
  /// ```
  final double horizontalTileCount;

  /// The number of vertical tiles in the LUT image.
  /// ```
  /// // Defaults to:
  /// 5
  /// ```
  final double verticalTileCount;

  /// Converts a [LutFilter] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() => {
        "horizontalTileCount":
            horizontalTileCount == null ? null : horizontalTileCount,
        "identifier": identifier == null ? null : identifier,
        "lutURI": lutUri == null ? null : lutUri,
        "name": name == null ? null : name,
        "verticalTileCount":
            verticalTileCount == null ? null : verticalTileCount,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A duoTone image filter.
class DuoToneFilter extends Filter {
  /// Creates a new [DuoToneFilter].
  DuoToneFilter(
    String identifier,
    String name,
    this.darkColor,
    this.lightColor,
  ) : super(identifier, name);

  /// The duoTone color that is mapped to dark colors of the input image.
  final Color darkColor;

  /// The duoTone color that is mapped to light colors of the input image
  final Color lightColor;

  /// Converts a [DuoToneFilter] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() => {
        "darkColor": darkColor == null ? null : darkColor._toJson(),
        "identifier": identifier == null ? null : identifier,
        "lightColor": lightColor == null ? null : lightColor._toJson(),
        "name": name == null ? null : name,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A sticker category.
class StickerCategory extends _NamedItem {
  /// Creates a new [StickerCategory].
  StickerCategory(
    String identifier,
    String name,
    this.thumbnailUri, {
    this.items,
  }) : super(identifier, name);

  /// Retrieves an existing [StickerCategory] with the given [identifier].
  /// You can further modify which [items] should be included.
  StickerCategory.existing(String identifier, {List<Sticker> items})
      : this(identifier, null, null, items: items);

  /// Items of the category which can be existing or new defined stickers.
  /// If `null` an empty category will be created.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final List<Sticker> items;

  /// The source of the thumbnail image of the category.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  final String thumbnailUri;

  /// Converts a [StickerCategory] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "identifier": identifier == null ? null : identifier,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x._toJson())),
        "name": name == null ? null : name,
        "thumbnailURI": thumbnailUri == null ? null : thumbnailUri,
      }..removeWhere((key, value) => key == null || value == null);
}

/// A sticker.
class Sticker extends _NamedItem {
  /// Creates a new [Sticker].
  Sticker(
    String identifier,
    String name,
    this.stickerUri, {
    this.adjustments,
    this.thumbnailUri,
    this.tintMode,
  }) : super(identifier, name);

  /// Retrieves an existing [Sticker] with the given [identifier].
  Sticker.existing(String identifier)
      : this(identifier, null, null,
            adjustments: null, thumbnailUri: null, tintMode: null);

  /// If enabled the brightness, contrast, and saturation of a sticker can
  /// be changed if the corresponding `StickerAction`s in the `Tool.sticker`
  /// are enabled.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool adjustments;

  /// The source of the sticker image.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  final String stickerUri;

  /// The source of the thumbnail image of the sticker.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  /// If `null` the thumbnail will be automatically
  /// generated from the `stickerURI`.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String thumbnailUri;

  /// The sticker tint mode.
  /// ```
  /// // Defaults to:
  /// TintMode.none
  /// ```
  final TintMode tintMode;

  /// Converts a [Sticker] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "adjustments": adjustments == null ? null : adjustments,
        "identifier": identifier == null ? null : identifier,
        "name": name == null ? null : name,
        "stickerURI": stickerUri == null ? null : stickerUri,
        "thumbnailURI": thumbnailUri == null ? null : thumbnailUri,
        "tintMode": tintMode == null ? null : _tintModeValues.reverse[tintMode],
      }..removeWhere((key, value) => key == null || value == null);
}

/// A unique identifiable item.
class _UniqueItem {
  /// Creates a new [_UniqueItem].
  _UniqueItem(this.identifier);

  /// The identifier of the item.
  final String identifier;
}

/// A named and unique identifiable item.
class _NamedItem extends _UniqueItem {
  /// Creates a new [_NamedItem].
  _NamedItem(
    String identifier,
    this.name,
  ) : super(identifier);

  /// Retrieves an existing item.
  _NamedItem.existing(String identifier) : this(identifier, null);

  /// The name of the item.
  final String name;
}

/// Maps the corresponding values to the enum.
class _EnumValues<T> {
  /// The map.
  final Map<String, T> map;

  /// The reversed map.
  Map<T, String> reverseMap;

  /// Creates new [_EnumValues].
  _EnumValues(this.map);

  /// Gets the reverse.
  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
