/// Configuration options and asset definitions for image and
/// video editing tasks.
class Configuration {
  /// Creates a new [Configuration].
  Configuration(
      {this.adjustment,
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
      this.audio,
      this.composition,
      this.trim});

  /// Configuration options for `Tool.adjustment`.
  final AdjustmentOptions? adjustment;

  /// Configuration options for `Tool.audio`.
  final AudioOptions? audio;

  /// Configuration options for `Tool.brush`.
  final BrushOptions? brush;

  /// Controls if the user can zoom the preview image.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool? enableZoom;

  /// Configuration options for `Tool.composition`.
  final CompositionOptions? composition;

  /// Export configuration options.
  final ExportOptions? export;

  /// Configuration options for `Tool.filter`.
  final FilterOptions? filter;

  /// Configuration options for `Tool.focus`.
  final FocusOptions? focus;

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
  final bool? forceCrop;

  /// Configuration options for `Tool.frame`.
  final FrameOptions? frame;

  /// Defines all allowed actions for the main screen that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.undo, CanvasAction.redo]`
  /// ```
  final List<MainCanvasAction>? mainCanvasActions;

  /// Configuration options for `Tool.overlay`.
  final OverlayOptions? overlay;

  /// Global snapping options for all sprites, e.g., stickers, texts,
  /// and text designs.
  final SnappingOptions? snapping;

  /// Configuration options for `Tool.sticker`.
  final StickerOptions? sticker;

  /// Configuration options for `Tool.text`.
  final TextOptions? text;

  /// Configuration options for `Tool.textDesign`.
  final TextDesignOptions? textdesign;

  /// The menu items (or tools) to display in the main menu.
  /// ```
  /// // Defaults to:
  /// [Tool.composition, Tool.transform, Tool.filter, Tool.adjustment,
  /// Tool.focus, Tool.sticker, Tool.text, Tool.textDesign, Tool.overlay,
  /// Tool.frame, Tool.brush]
  /// // or if your license does not include Tool.composition:
  /// [Tool.trim, Tool.transform, Tool.filter, Tool.adjustment, Tool.focus,
  /// Tool.sticker, Tool.text, Tool.textDesign, Tool.overlay, Tool.frame,
  /// Tool.brush]
  /// ```
  final List<Tool>? tools;

  /// Configuration options for `Tool.transform`.
  final TransformOptions? transform;

  /// Configuration options for `Tool.trim`.
  final TrimOptions? trim;

  /// Converts a [Configuration] to a [Map].
  Map<String, dynamic> toJson() {
    final _canvasActions = mainCanvasActions;
    final _tools = tools;

    return {
      "adjustment": adjustment?._toJson(),
      "audio": audio?._toJson(),
      "brush": brush?._toJson(),
      "composition": composition?._toJson(),
      "enableZoom": enableZoom,
      "export": export?._toJson(),
      "filter": filter?._toJson(),
      "focus": focus?._toJson(),
      "forceCrop": forceCrop,
      "frame": frame?._toJson(),
      "mainCanvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(
              _canvasActions.map((x) => _mainCanvasActionValues.reverse[x])),
      "overlay": overlay?._toJson(),
      "snapping": snapping?._toJson(),
      "sticker": sticker?._toJson(),
      "text": text?._toJson(),
      "textdesign": textdesign?._toJson(),
      "tools": _tools == null
          ? null
          : List<dynamic>.from(_tools.map((x) => _toolValues.reverse[x])),
      "transform": transform?._toJson(),
      "trim": trim?._toJson(),
    }..removeWhere((key, value) => value == null);
  }
}

/// Configuration options for `Tool.composition`.
class CompositionOptions {
  /// Creates new [CompositionOptions].
  CompositionOptions(
      {this.categories,
      this.personalVideoClips,
      this.clipTrimOptions,
      this.canvasActions});

  /// Defines all available video clips in the video clip library. Each video
  /// clip must be assigned to a category.
  ///
  /// If this array is `null` the defaults are used. If this array is empty the
  /// video clip library won't be shown when the user taps the add button in
  /// the composition menu instead the device's media library will be shown
  /// directly when `personalVideoClips` is enabled.
  /// If `personalVideoClips` is disabled in this case the add button in the
  /// composition menu won't be shown at all.
  /// ```
  /// // Defaults to:
  /// []
  /// ```
  final List<VideoClipCategory>? categories;

  /// Defines all allowed actions for the composition tool that are displayed
  /// as overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  /// ```
  /// // Defaults to:
  /// [CompositionCanvasAction.playPause]
  /// ```
  final List<CompositionCanvasAction>? canvasActions;

  /// If enabled the user can add personal video clips from the device's media
  /// library. A button is added as last item in the composition menu or as
  /// first item in the video clip library menu in front of the video clip
  /// categories if any `categories` are defined.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool? personalVideoClips;

  /// Configuration options for trimming individual video clips of the
  /// video composition.
  final ClipTrimOptions? clipTrimOptions;

  /// Converts a [CompositionOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _categories = categories;
    final _canvasActions = canvasActions;

    return {
      "personalVideoClips": personalVideoClips,
      "categories": _categories == null
          ? null
          : List<dynamic>.from(_categories.map((e) => e._toJson())),
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(_canvasActions
              .map((x) => _compositionCanvasActionValues.reverse[x])),
      "clipTrim": clipTrimOptions?._toJson()
    }..removeWhere((key, value) => value == null);
  }
}

/// A composition canvas action.
enum CompositionCanvasAction {
  /// Play/pause the video playback.
  playPause
}

/// The corresponding values to the [CompositionCanvasAction].
final _compositionCanvasActionValues =
    _EnumValues({"playpause": CompositionCanvasAction.playPause});

/// Configuration options for trimming individual video clips of the video
/// composition.
class ClipTrimOptions {
  /// Creates new [ClipTrimOptions].
  ClipTrimOptions({this.canvasActions});

  /// Defines all allowed actions for the trim tool that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  final List<ClipTrimCanvasAction>? canvasActions;

  /// Converts a [ClipTrimOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _canvasActions = canvasActions;

    return {
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(_canvasActions
              .map((x) => _clipTrimCanvasActionValues.reverse[x])),
    }..removeWhere((key, value) => value == null);
  }
}

/// A canvas action for [ClipTrimOptions].
enum ClipTrimCanvasAction {
  /// Delete the video clip.
  delete,

  /// Play/pause the video playback.
  playPause
}

/// The corresponding values to the [ClipTrimCanvasAction].
final _clipTrimCanvasActionValues = _EnumValues({
  "delete": ClipTrimCanvasAction.delete,
  "playpause": ClipTrimCanvasAction.playPause
});

/// Configuration options for `Tool.trim`.
class TrimOptions {
  /// Creates new [TrimOptions].
  TrimOptions(
      {this.canvasActions,
      this.minimumDuration,
      this.maximumDuration,
      this.forceMode});

  /// Defines all allowed actions for the trim tool that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  final List<TrimCanvasAction>? canvasActions;

  /// Enforces a minimum allowed duration in seconds for the edited video for
  /// the trim and composition tool. The minimum allowed value is 0.5 seconds.
  /// See [forceMode] for additional options.
  /// ```
  /// // Defaults to:
  /// 0.5
  /// ```
  final double? minimumDuration;

  /// Enforces a maximum allowed duration in seconds for the edited video for
  /// the trim and composition tool if set to a value different from `null`.
  /// See [forceMode] for additional options.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final double? maximumDuration;

  /// With the force trim option, you're able to enforce a [minimumDuration]
  /// and [maximumDuration] for a video composition in the composition tool
  /// and/or a single video in the trim tool. Thus users will not be able to
  /// export videos, which are not within the defined video duration limits.
  /// This feature is implemented as part of the user interface only.
  /// To be able to use this feature your subscription must include the trim
  /// feature.
  /// ```
  /// // Defaults to:
  /// ForceTrimMode.silent
  /// ```
  final ForceTrimMode? forceMode;

  /// Converts a [TrimOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _canvasActions = canvasActions;

    return {
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(
              _canvasActions.map((x) => _trimCanvasActionValues.reverse[x])),
      "minimumDuration": minimumDuration,
      "maximumDuration": maximumDuration,
      "forceMode": _forceTrimModeValues.reverse[forceMode]
    }..removeWhere((key, value) => value == null);
  }
}

/// A canvas action for [TrimOptions].
enum TrimCanvasAction {
  /// Play/pause the video playback.
  playPause
}

/// The corresponding values to the [TrimCanvasAction].
final _trimCanvasActionValues =
    _EnumValues({"playpause": TrimCanvasAction.playPause});

/// A force trim mode.
enum ForceTrimMode {
  /// Will always automatically present the composition tool or the trim tool
  /// after opening the editor and force your users to change the length of
  /// the video(s).
  ///
  /// The composition tool will only be used if it is included in your
  /// subscription and if it is included in [Configuration.tools] or if both
  /// the composition and trim tool are not included in [Configuration.tools].
  /// Otherwise, the trim tool is used if it is included in your subscription.
  always,

  /// Will automatically present the composition or trim tool if needed.
  /// Will only present:
  /// - the composition tool, if your initial composition is longer than
  ///   [TrimOptions.maximumDuration] or shorter than
  ///   [TrimOptions.minimumDuration], or
  /// - the trim tool, if your initial video is longer than
  ///   [TrimOptions.maximumDuration]. If the video is shorter than
  ///   [TrimOptions.minimumDuration] an alert
  ///   is displayed as soon as the editor is opened and after dismissing the
  ///   alert, the editor is closed.
  ///
  /// The composition tool will only be used if it is included in your
  /// subscription and if it is included in [Configuration.tools]
  /// or if both the composition and trim tool are not included in
  /// [Configuration.tools]. Otherwise, the trim tool is used if it is included
  /// in your subscription.
  ifNeeded,

  /// Will automatically trim the video to [TrimOptions.maximumDuration] without
  /// opening any tool. If the length of the initially loaded video(s) is
  /// shorter than [TrimOptions.minimumDuration] and the user has the option to add
  /// more videos (because of composition), an alert will be shown when tapping
  /// the export button and after dismissing the alert, the composition tool
  /// will automatically open. If no additional videos can be added, an alert
  /// is displayed as soon as the editor is opened and after dismissing the
  /// alert, the editor is closed.
  silent
}

/// The corresponding values to the [ForceTrimMode].
final _forceTrimModeValues = _EnumValues({
  "always": ForceTrimMode.always,
  "ifneeded": ForceTrimMode.ifNeeded,
  "silent": ForceTrimMode.silent
});

/// Configuration options for `Tool.audio`.
class AudioOptions {
  /// Creates new [AudioOptions].
  AudioOptions({this.categories, this.canvasActions});

  /// Defines all available audio clips in the audio clip library. Each audio
  /// clip must be assigned to a category.
  /// ```
  /// // Defaults to:
  /// []
  /// ```
  final List<AudioClipCategory>? categories;

  /// Defines all allowed actions for the audio tool that are displayed as
  /// overlay buttons on the canvas. Only buttons for allowed actions are
  /// visible.
  /// ```
  /// // Defaults to:
  /// [AudioCanvasAction.delete]
  /// ```
  final List<AudioCanvasAction>? canvasActions;

  /// Converts a [AudioOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _canvasActions = canvasActions;
    final _categories = categories;

    return {
      "categories": _categories == null
          ? null
          : List<dynamic>.from(_categories.map((e) => e._toJson())),
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(
              _canvasActions.map((e) => _audioCanvasActionValues.reverse[e]))
    }..removeWhere((key, value) => value == null);
  }
}

/// An audio canvas action.
enum AudioCanvasAction {
  /// Delete the audio clip.
  delete,

  /// Play/pause the audio playback.
  playPause
}

/// The corresponding values to the [AudioCanvasAction].
final _audioCanvasActionValues = _EnumValues({
  "delete": AudioCanvasAction.delete,
  "playpause": AudioCanvasAction.playPause
});

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
  final List<AdjustmentTool>? items;

  /// Whether to show a reset button to reset the applied adjustments.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool? showResetButton;

  /// Converts [AdjustmentOptions] to a [Map].
  Map<String, dynamic> _toJson() {
    final _items = items;

    return {
      "items": _items == null
          ? null
          : List<dynamic>.from(
              _items.map((x) => _adjustmentToolValues.reverse[x])),
      "showResetButton": showResetButton == null ? null : showResetButton,
    }..removeWhere((key, value) => value == null);
  }
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
  final List<BrushAction>? actions;

  /// Defines all allowed actions for the brush tool that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.delete, CanvasAction.bringToFront,
  /// CanvasAction.undo, CanvasAction.redo]
  final List<BrushCanvasAction>? canvasActions;

  /// Defines all available colors that can be applied to the brush.
  /// The color pipette is always added.
  final ColorPalette? colors;

  /// The default color.
  final Color? defaultColor;

  /// The default hardness factor of the brush.
  /// ```
  /// // Defaults to:
  /// 0.5
  /// ```
  final double? defaultHardness;

  /// The default size of the brush. This value is measured in relation to the
  /// smaller side of the image that the user is editing.
  /// ```
  /// // Defaults to:
  /// 0.05
  /// ```
  final double? defaultSize;

  /// The maximum hardness factor a brush can have.
  /// ```
  /// // Defaults to:
  /// 1
  /// ```
  final double? maximumHardness;

  /// The maximum size that a brush can have. This value is
  /// measured in relation to the smaller side of the asset
  /// that the user is editing.
  /// ```
  /// // Defaults to:
  /// 0.125
  /// ```
  final double? maximumSize;

  /// The minimum hardness factor a brush can have.
  /// ```
  /// // Defaults to:
  /// 0
  /// ```
  final double? minimumHardness;

  /// The minimum size that a brush can have. This value is measured
  /// in relation to the smaller side of the asset that the user is editing.
  /// If the value is `null` the minimum brush size is set to the absolute
  /// size of a single pixel of the edited image.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final double? minimumSize;

  /// Converts [BrushOptions] to a [Map].
  Map<String, dynamic> _toJson() {
    final _actions = actions;
    final _canvasActions = canvasActions;

    return {
      "actions": _actions == null
          ? null
          : List<dynamic>.from(
              _actions.map((x) => _brushActionValues.reverse[x])),
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(
              _canvasActions.map((x) => _brushCanvasActionValues.reverse[x])),
      "colors": colors?._toJson(),
      "defaultColor": defaultColor?._toJson(),
      "defaultHardness": defaultHardness,
      "defaultSize": defaultSize,
      "maximumHardness": maximumHardness,
      "maximumSize": maximumSize,
      "minimumHardness": minimumHardness,
      "minimumSize": minimumSize,
    }..removeWhere((key, value) => value == null);
  }
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
  dynamic _toJson() => color;
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
  Map<String, dynamic> _toJson() => {"color": color._toJson(), "name": name};
}

/// A color palette of named colors.
class ColorPalette {
  /// Creates a new [ColorPalette].
  ColorPalette({required this.colors});

  /// The included named colors.
  final List<NamedColor> colors;

  /// Converts a [ColorPalette] for JSON parsing.
  List<Map<String, dynamic>> _toJson() =>
      colors.map((c) => c._toJson()).toList();
}

/// Export configuration options.
class ExportOptions {
  /// Creates new [ExportOptions].
  ExportOptions(
      {this.filename,
      this.image,
      this.serialization,
      this.video,
      this.forceExport});

  /// The filename for the exported data if the [ImageOptions.exportType] is not
  /// [ImageExportType.dataUrl].
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
  final String? filename;

  /// If enabled, the photo/video will be rendered and exported in the
  /// defined output format even if no changes have been applied.
  /// Otherwise, the input asset will be passed through and might
  /// not match the defined output format.
  final bool? forceExport;

  /// Image export configuration if the editor supports image editing.
  final ImageOptions? image;

  /// Export configuration of the serialized image and video editing
  /// operations that were applied to the input media loaded into the editor.
  /// This also allows to recover these operations the next
  /// time the editor is opened again.
  final SerializationOptions? serialization;

  /// Video export configuration if the editor supports video editing.
  final VideoOptions? video;

  /// Converts [ExportOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "filename": filename,
        "image": image?._toJson(),
        "serialization": serialization?._toJson(),
        "video": video?._toJson(),
        "force": forceExport
      }..removeWhere((key, value) => value == null);
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
  final ImageExportType? exportType;

  /// The image file format of the generated high resolution image.
  /// ```
  /// // Defaults to:
  /// ImageFormat.jpeg
  /// ```
  final ImageFormat? format;

  /// The compression quality to use when creating the output
  /// image with a lossy file format.
  /// ```
  /// // Defaults to:
  /// 0.9
  /// ```
  final double? quality;

  /// Converts [ImageOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "exportType": exportType == null
            ? null
            : _imageExportTypeValues.reverse[exportType],
        "format": format == null ? null : _imageFormatValues.reverse[format],
        "quality": quality,
      }..removeWhere((key, value) => value == null);
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
  final bool? embedSourceImage;

  /// Whether the serialization of the editing operations should be exported.
  final bool? enabled;

  /// The serialization export type.
  /// ```
  /// // Defaults to:
  /// SerializationExportType.fileUrl
  /// ```
  final SerializationExportType? exportType;

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
  final String? filename;

  /// Converts [SerializationOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "embedSourceImage": embedSourceImage,
        "enabled": enabled,
        "exportType": exportType == null
            ? null
            : _serializationExportTypeValues.reverse[exportType],
        "filename": filename,
      }..removeWhere((key, value) => value == null);
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
  final double? bitRate;

  /// The video codec to use for the exported video.
  /// ```
  /// // Defaults to:
  /// VideoCodec.h264
  /// ```
  final VideoCodec? codec;

  /// The video container format to export.
  /// ```
  /// // Defaults to:
  /// VideoFormat.mp4
  /// ```
  final VideoFormat? format;

  /// The compression quality to use when exporting to VideoCodec.hevc.
  /// ```
  /// // Defaults to:
  /// 0.9
  /// ```
  final double? quality;

  /// Converts [VideoOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "bitRate": bitRate,
        "codec": codec == null ? null : _videoCodecValues.reverse[codec],
        "format": format == null ? null : _videoFormatValues.reverse[format],
        "quality": quality,
      }..removeWhere((key, value) => value == null);
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
  ///  FilterCategory.existing("imgly_filter_category_duotone",
  ///      items: [
  ///        Filter.existing("imgly_duotone_desert"),
  ///        Filter.existing("imgly_duotone_peach"),
  ///        Filter.existing("imgly_duotone_clash"),
  ///        Filter.existing("imgly_duotone_plum"),
  ///        Filter.existing("imgly_duotone_breezy"),
  ///        Filter.existing("imgly_duotone_deepblue"),
  ///        Filter.existing("imgly_duotone_frog"),
  ///        Filter.existing("imgly_duotone_sunset"),
  ///      ]),
  ///  FilterCategory.existing("imgly_filter_category_bw", items: [
  ///    Filter.existing("imgly_lut_ad1920"),
  ///    Filter.existing("imgly_lut_bw"),
  ///    Filter.existing("imgly_lut_x400"),
  ///    Filter.existing("imgly_lut_litho"),
  ///    Filter.existing("imgly_lut_sepiahigh"),
  ///    Filter.existing("imgly_lut_plate"),
  ///    Filter.existing("imgly_lut_sin"),
  ///  ]),
  ///  FilterCategory.existing("imgly_filter_category_vintage",
  ///      items: [
  ///        Filter.existing("imgly_lut_blues"),
  ///        Filter.existing("imgly_lut_front"),
  ///        Filter.existing("imgly_lut_texas"),
  ///        Filter.existing("imgly_lut_celsius"),
  ///        Filter.existing("imgly_lut_cool"),
  ///      ]),
  ///  FilterCategory.existing("imgly_filter_category_smooth",
  ///      items: [
  ///       Filter.existing("imgly_lut_chest"),
  ///        Filter.existing("imgly_lut_winter"),
  ///        Filter.existing("imgly_lut_kdynamic"),
  ///        Filter.existing("imgly_lut_fall"),
  ///        Filter.existing("imgly_lut_lenin"),
  ///        Filter.existing("imgly_lut_pola669"),
  ///      ]),
  ///  FilterCategory.existing("imgly_filter_category_cold", items: [
  ///    Filter.existing("imgly_lut_elder"),
  ///    Filter.existing("imgly_lut_orchid"),
  ///    Filter.existing("imgly_lut_bleached"),
  ///    Filter.existing("imgly_lut_bleachedblue"),
  ///    Filter.existing("imgly_lut_breeze"),
  ///    Filter.existing("imgly_lut_blueshadows"),
  ///  ]),
  ///  FilterCategory.existing("imgly_filter_category_warm", items: [
  ///    Filter.existing("imgly_lut_sunset"),
  ///    Filter.existing("imgly_lut_eighties"),
  ///    Filter.existing("imgly_lut_evening"),
  ///    Filter.existing("imgly_lut_k2"),
  ///    Filter.existing("imgly_lut_nogreen"),
  ///  ]),
  ///  FilterCategory.existing("imgly_filter_category_legacy",
  ///      items: [
  ///        Filter.existing("imgly_lut_ancient"),
  ///        Filter.existing("imgly_lut_cottoncandy"),
  ///        Filter.existing("imgly_lut_classic"),
  ///        Filter.existing("imgly_lut_colorful"),
  ///        Filter.existing("imgly_lut_creamy"),
  ///        Filter.existing("imgly_lut_fixie"),
  ///        Filter.existing("imgly_lut_food"),
  ///        Filter.existing("imgly_lut_fridge"),
  ///        Filter.existing("imgly_lut_glam"),
  ///        Filter.existing("imgly_lut_gobblin"),
  ///        Filter.existing("imgly_lut_highcontrast"),
  ///        Filter.existing("imgly_lut_highcarb"),
  ///        Filter.existing("imgly_lut_k1"),
  ///        Filter.existing("imgly_lut_k6"),
  ///        Filter.existing("imgly_lut_keen"),
  ///        Filter.existing("imgly_lut_lomo"),
  ///        Filter.existing("imgly_lut_lomo100"),
  ///        Filter.existing("imgly_lut_lucid"),
  ///        Filter.existing("imgly_lut_mellow"),
  ///        Filter.existing("imgly_lut_neat"),
  ///        Filter.existing("imgly_lut_pale"),
  ///        Filter.existing("imgly_lut_pitched"),
  ///        Filter.existing("imgly_lut_polasx"),
  ///        Filter.existing("imgly_lut_pro400"),
  ///        Filter.existing("imgly_lut_quozi"),
  ///        Filter.existing("imgly_lut_settled"),
  ///        Filter.existing("imgly_lut_seventies"),
  ///        Filter.existing("imgly_lut_soft"),
  ///        Filter.existing("imgly_lut_steel"),
  ///        Filter.existing("imgly_lut_summer"),
  ///        Filter.existing("imgly_lut_tender"),
  ///        Filter.existing("imgly_lut_twilight"),
  ///     ])
  /// ];
  /// ```
  final List<FilterCategory>? categories;

  /// Whether categories should be flattened which effectively hides
  /// the categories. If this is enabled all filters will be shown in
  /// the top-level of the filter selection tool
  /// ordered according to their parent category.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool? flattenCategories;

  /// Converts [FilterOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _categories = categories;

    return {
      "categories": _categories == null
          ? null
          : List<dynamic>.from(_categories.map((x) => x._toJson())),
      "flattenCategories": flattenCategories,
    }..removeWhere((key, value) => value == null);
  }
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
  final List<FocusTool>? items;

  /// Converts [FocusOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _items = items;

    return {
      "items": _items == null
          ? null
          : List<dynamic>.from(_items.map((x) => _focusToolValues.reverse[x])),
    }..removeWhere((key, value) => value == null);
  }
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
  final List<FrameAction>? actions;

  /// Defines all available frames.
  /// New items can be mixed and matched with existing ones.
  /// `none` is always added.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   Frame.existing("imgly_frame_dia"),
  ///   Frame.existing("imgly_frame_art_decor"),
  ///   Frame.existing("imgly_frame_black_passepartout"),
  ///   Frame.existing("imgly_frame_wood_passepartout"),
  /// ];
  /// ```
  final List<Frame>? items;

  /// Converts [FrameOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _actions = actions;
    final _items = items;

    return {
      "actions": _actions == null
          ? null
          : List<dynamic>.from(
              _actions.map((x) => _frameActionValues.reverse[x])),
      "items": _items == null
          ? null
          : List<dynamic>.from(_items.map((x) => x._toJson())),
    }..removeWhere((key, value) => value == null);
  }
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
abstract class Frame extends _NamedItem {
  /// Retrieves an existing frame with the given [identifier].
  Frame._existing(String identifier) : super.existing(identifier);

  /// Creates a new named [Frame].
  Frame._custom(String identifier, String name) : super(identifier, name);

  /// Retrieves an [ExistingFrame] with the given [identifier].
  factory Frame.existing(String identifier) => ExistingFrame(identifier);

  /// Creates a new [CustomFrame].
  factory Frame(String identifier, String name, ImageGroupSet imageGroups,
          double relativeScale, String thumbnailUri,
          {FrameLayoutMode? layoutMode}) =>
      CustomFrame(identifier, name, imageGroups, relativeScale, thumbnailUri,
          layoutMode: layoutMode);

  /// Converts the [Frame] for JSON parsing.
  Map<String, dynamic> _toJson() => {"identifier": identifier};
}

/// An existing frame.
class ExistingFrame extends Frame {
  /// Retrieves an existing frame with the given [identifier].
  ExistingFrame(String identifier) : super._existing(identifier);
}

/// A custom frame.
class CustomFrame extends Frame {
  /// Creates a new [CustomFrame].
  CustomFrame(
    String identifier,
    String name,
    this.imageGroups,
    this.relativeScale,
    this.thumbnailUri, {
    this.layoutMode,
  }) : super._custom(identifier, name);

  /// Images for the 12-patch layout of a dynamic frame
  /// that automatically adapts to
  /// any output image resolution.
  final ImageGroupSet imageGroups;

  /// The layout mode of the patches of the frame.
  /// ```
  /// // Defaults to:
  /// FrameLayoutMode.horizontalInside
  /// ```
  final FrameLayoutMode? layoutMode;

  /// The relative scale of the frame which is defined in relation
  /// to the shorter side of the resulting output image.
  final double relativeScale;

  /// The source for the thumbnail image of the frame.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  final String thumbnailUri;

  @override
  Map<String, dynamic> _toJson() => {
        "identifier": identifier,
        "imageGroups": imageGroups._toJson(),
        "layoutMode": layoutMode == null
            ? null
            : _frameLayoutModeValues.reverse[layoutMode],
        "name": name,
        "relativeScale": relativeScale,
        "thumbnailURI": thumbnailUri,
      }..removeWhere((key, value) => value == null);
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
  final FrameImageGroup? bottom;

  /// The left image group.
  /// If `null` there is no top group.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final FrameImageGroup? left;

  /// The right image group.
  /// If `null` there is no top group.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final FrameImageGroup? right;

  /// The top image group.
  /// If `null` there is no top group.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final FrameImageGroup? top;

  /// Converts an [ImageGroupSet] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "bottom": bottom?._toJson(),
        "left": left?._toJson(),
        "right": right?._toJson(),
        "top": top?._toJson(),
      }..removeWhere((key, value) => value == null);
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
  final String? endUri;

  /// The render mode for the middle image.
  /// ```
  /// // Defaults to:
  /// FrameTileMode.repeat
  /// ```
  final FrameTileMode? midMode;

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
  final String? startUri;

  /// Converts a [FrameImageGroup] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "endURI": endUri,
        "midMode":
            midMode == null ? null : _frameTileModeValues.reverse[midMode],
        "midURI": midUri,
        "startURI": startUri,
      }..removeWhere((key, value) => value == null);
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
  /// (Un)mute the video playback.
  soundOnOff,

  /// Play/pause the video playback.
  playPause,

  /// Redo the action(s).
  redo,

  /// Undo the action(s).
  undo
}

/// The corresponding values to the [MainCanvasAction].
final _mainCanvasActionValues = _EnumValues({
  "redo": MainCanvasAction.redo,
  "undo": MainCanvasAction.undo,
  "playpause": MainCanvasAction.playPause,
  "soundonoff": MainCanvasAction.soundOnOff
});

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
  final List<BlendMode>? blendModes;

  /// Defines all available overlays.
  /// New items can be mixed and matched with existing ones.
  /// `none` is always added.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   Overlay.existing("imgly_overlay_golden"),
  ///   Overlay.existing("imgly_overlay_lightleak1"),
  ///   Overlay.existing("imgly_overlay_rain"),
  ///   Overlay.existing("imgly_overlay_mosaic"),
  ///   Overlay.existing("imgly_overlay_vintage"),
  ///   Overlay.existing("imgly_overlay_paper"),
  /// ];
  /// ```
  final List<Overlay>? items;

  /// Converts [OverlayOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _blendModes = blendModes;
    final _items = items;

    return {
      "blendModes": _blendModes == null
          ? null
          : List<dynamic>.from(
              _blendModes.map((x) => _blendModeValues.reverse[x])),
      "items": _items == null
          ? null
          : List<dynamic>.from(_items.map((x) => x._toJson())),
    }..removeWhere((key, value) => value == null);
  }
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
abstract class Overlay extends _NamedItem {
  /// Retrieves an existing overlay with the given [identifier].
  Overlay._existing(String identifier) : super.existing(identifier);

  /// Creates a new named [Overlay].
  Overlay._custom(String identifier, String name) : super(identifier, name);

  /// Retrieves an [ExistingOverlay] with the given [identifier].
  factory Overlay.existing(String identifier) => ExistingOverlay(identifier);

  /// Creates a new [CustomOverlay].
  factory Overlay(String identifier, String name, BlendMode defaultBlendMode,
          String overlayUri, {String? thumbnailUri}) =>
      CustomOverlay(identifier, name, defaultBlendMode, overlayUri,
          thumbnailUri: thumbnailUri);

  /// Converts the [Overlay] for JSON parsing.
  Map<String, dynamic> _toJson() => {"identifier": identifier};
}

/// An existing overlay.
class ExistingOverlay extends Overlay {
  /// Retrieves an existing overlay with the given [identifier].
  ExistingOverlay(String identifier) : super._existing(identifier);
}

/// A custom overlay.
class CustomOverlay extends Overlay {
  /// Creates a new [CustomOverlay].
  CustomOverlay(
    String identifier,
    String name,
    this.defaultBlendMode,
    this.overlayUri, {
    this.thumbnailUri,
  }) : super._custom(identifier, name);

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
  final String? thumbnailUri;

  /// Converts an [Overlay] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() => {
        "identifier": identifier,
        "defaultBlendMode": _blendModeValues.reverse[defaultBlendMode],
        "name": name,
        "overlayURI": overlayUri,
        "thumbnailURI": thumbnailUri,
      }..removeWhere((key, value) => value == null);
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
  final PositionSnappingOptions? position;

  /// Snapping options for rotating sprites.
  final RotationSnappingOptions? rotation;

  /// Converts [SnappingOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "position": position?._toJson(),
        "rotation": rotation?._toJson(),
      }..removeWhere((key, value) => value == null);
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
  final bool? enabled;

  /// The bottom side of a sprite's bounding box snaps to a horizontal line
  /// which is shifted from the bottom side of the edited image towards its
  /// center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double? snapToBottom;

  /// If enabled a sprite's center snaps to the horizontal line through the
  /// center of the edited image.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool? snapToHorizontalCenter;

  /// The bottom side of a sprite's bounding box snaps to a horizontal line
  /// which is shifted from the left side of the edited image towards its
  /// center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double? snapToLeft;

  /// The bottom side of a sprite's bounding box snaps to a horizontal
  /// line which is shifted from the right side of the edited image towards
  /// its center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double? snapToRight;

  /// The bottom side of a sprite's bounding box snaps to a horizontal line
  /// which is shifted from the right side of the edited image towards its
  /// center by this value. The value is measured in normalized
  /// coordinates relative to the smaller side of the edited image.
  /// If this value is explicitly set to `null` this snapping line is disabled.
  /// ```
  /// // Defaults to:
  /// 0.1
  /// ```
  final double? snapToTop;

  /// If enabled a sprite's center snaps to the vertical line through the
  /// center of the edited image.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool? snapToVerticalCenter;

  /// This threshold defines the distance of a pan gesture where snapping
  /// at a snap point occurs. It is measured in points.
  /// ```
  /// // Defaults to:
  /// 20
  /// ```
  final double? threshold;

  /// The keys that can explicitly be set to null.
  static const List<String> nullSupported = [
    "snapToLeft",
    "snapToRight",
    "snapToTop",
    "snapToBottom"
  ];

  /// Converts [PositionSnappingOptions] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "enabled": enabled,
        "snapToBottom": snapToBottom,
        "snapToHorizontalCenter": snapToHorizontalCenter,
        "snapToLeft": snapToLeft,
        "snapToRight": snapToRight,
        "snapToTop": snapToTop,
        "snapToVerticalCenter": snapToVerticalCenter,
        "threshold": threshold,
      }..removeWhere(
          (key, value) => value == null && !nullSupported.contains(key));
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
  final bool? enabled;

  /// Enabled snapping angles in degrees for rotating a sprite.
  /// The rotation angle is defined clockwise.
  /// ```
  /// // Defaults to:
  /// [0, 45, 90, 135, 180, 225, 270, 315]
  /// ```
  final List<double>? snapToAngles;

  /// This threshold defines the arc length of a rotation gesture where
  /// snapping at a snap angle occurs. It is measured in points.
  /// ```
  /// // Defaults to:
  /// 20
  /// ```
  final double? threshold;

  /// Converts [RotationSnappingOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _snapToAngles = snapToAngles;

    return {
      "enabled": enabled,
      "snapToAngles": _snapToAngles == null
          ? null
          : List<dynamic>.from(_snapToAngles.map((x) => x)),
      "threshold": threshold,
    }..removeWhere((key, value) => value == null);
  }
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
  final List<StickerAction>? actions;

  /// Defines all allowed actions for the sticker tool that are displayed as
  /// overlay buttons on the canvas.
  /// Only buttons for allowed actions are visible.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.add, CanvasAction.delete, CanvasAction.flip,
  /// CanvasAction.bringToFront, CanvasAction.undo, CanvasAction.redo]
  /// ```
  final List<StickerCanvasAction>? canvasActions;

  /// Defines all available stickers. Each sticker must be assigned to a
  /// category. New items and categories can be mixed and matched with
  /// existing ones.
  /// **If this array is `null` the defaults are used but the sticker category**
  /// **with the identifier `imgly_sticker_category_animated` is only shown**
  /// **when editing videos.**
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   StickerCategory.existing("imgly_sticker_category_emoticons",
  ///       items: [
  ///         Sticker.existing("imgly_smart_sticker_weekday"),
  ///         Sticker.existing("imgly_smart_sticker_date"),
  ///         Sticker.existing("imgly_smart_sticker_time"),
  ///         Sticker.existing("imgly_smart_sticker_time_clock"),
  ///         Sticker.existing("imgly_sticker_emoticons_grin"),
  ///         Sticker.existing("imgly_sticker_emoticons_laugh"),
  ///         Sticker.existing("imgly_sticker_emoticons_smile"),
  ///         Sticker.existing("imgly_sticker_emoticons_wink"),
  ///         Sticker.existing("imgly_sticker_emoticons_tongue_out_wink"),
  ///         Sticker.existing("imgly_sticker_emoticons_angel"),
  ///         Sticker.existing("imgly_sticker_emoticons_kisses"),
  ///         Sticker.existing("imgly_sticker_emoticons_loving"),
  ///         Sticker.existing("imgly_sticker_emoticons_kiss"),
  ///         Sticker.existing("imgly_sticker_emoticons_wave"),
  ///         Sticker.existing("imgly_sticker_emoticons_nerd"),
  ///         Sticker.existing("imgly_sticker_emoticons_cool"),
  ///         Sticker.existing("imgly_sticker_emoticons_blush"),
  ///         Sticker.existing("imgly_sticker_emoticons_duckface"),
  ///         Sticker.existing("imgly_sticker_emoticons_furious"),
  ///         Sticker.existing("imgly_sticker_emoticons_angry"),
  ///         Sticker.existing("imgly_sticker_emoticons_steaming_furious"),
  ///         Sticker.existing("imgly_sticker_emoticons_anxious"),
  ///         Sticker.existing("imgly_sticker_emoticons_cry"),
  ///         Sticker.existing("imgly_sticker_emoticons_sobbing"),
  ///         Sticker.existing("imgly_sticker_emoticons_loud_cry"),
  ///         Sticker.existing("imgly_sticker_emoticons_wide_grin"),
  ///         Sticker.existing("imgly_sticker_emoticons_impatient"),
  ///         Sticker.existing("imgly_sticker_emoticons_tired"),
  ///         Sticker.existing("imgly_sticker_emoticons_asleep"),
  ///         Sticker.existing("imgly_sticker_emoticons_sleepy"),
  ///         Sticker.existing("imgly_sticker_emoticons_deceased"),
  ///         Sticker.existing("imgly_sticker_emoticons_attention"),
  ///         Sticker.existing("imgly_sticker_emoticons_question"),
  ///         Sticker.existing("imgly_sticker_emoticons_not_speaking_to_you"),
  ///         Sticker.existing("imgly_sticker_emoticons_sick"),
  ///         Sticker.existing("imgly_sticker_emoticons_pumpkin"),
  ///         Sticker.existing("imgly_sticker_emoticons_boxer"),
  ///         Sticker.existing("imgly_sticker_emoticons_idea"),
  ///         Sticker.existing("imgly_sticker_emoticons_smoking"),
  ///         Sticker.existing("imgly_sticker_emoticons_skateboard"),
  ///         Sticker.existing("imgly_sticker_emoticons_guitar"),
  ///         Sticker.existing("imgly_sticker_emoticons_music"),
  ///         Sticker.existing("imgly_sticker_emoticons_sunbathing"),
  ///         Sticker.existing("imgly_sticker_emoticons_hippie"),
  ///         Sticker.existing("imgly_sticker_emoticons_humourous"),
  ///         Sticker.existing("imgly_sticker_emoticons_hitman"),
  ///         Sticker.existing("imgly_sticker_emoticons_harry_potter"),
  ///         Sticker.existing("imgly_sticker_emoticons_business"),
  ///         Sticker.existing("imgly_sticker_emoticons_batman"),
  ///         Sticker.existing("imgly_sticker_emoticons_skull"),
  ///         Sticker.existing("imgly_sticker_emoticons_ninja"),
  ///         Sticker.existing("imgly_sticker_emoticons_masked"),
  ///         Sticker.existing("imgly_sticker_emoticons_alien"),
  ///         Sticker.existing("imgly_sticker_emoticons_wrestler"),
  ///         Sticker.existing("imgly_sticker_emoticons_devil"),
  ///         Sticker.existing("imgly_sticker_emoticons_star"),
  ///         Sticker.existing("imgly_sticker_emoticons_baby_chicken"),
  ///         Sticker.existing("imgly_sticker_emoticons_rabbit"),
  ///         Sticker.existing("imgly_sticker_emoticons_pig"),
  ///         Sticker.existing("imgly_sticker_emoticons_chicken"),
  ///       ]),
  ///   StickerCategory.existing("imgly_sticker_category_shapes",
  ///       items: [
  ///         Sticker.existing("imgly_sticker_shapes_badge_01"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_04"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_12"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_06"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_13"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_36"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_08"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_11"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_35"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_28"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_32"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_15"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_20"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_18"),
  ///         Sticker.existing("imgly_sticker_shapes_badge_19"),
  ///         Sticker.existing("imgly_sticker_shapes_arrow_02"),
  ///         Sticker.existing("imgly_sticker_shapes_arrow_03"),
  ///         Sticker.existing("imgly_sticker_shapes_spray_01"),
  ///         Sticker.existing("imgly_sticker_shapes_spray_04"),
  ///         Sticker.existing("imgly_sticker_shapes_spray_03"),
  ///       ]),
  ///   StickerCategory.existing("imgly_sticker_category_animated",
  ///       items: [
  ///         Sticker.existing("imgly_sticker_animated_camera"),
  ///         Sticker.existing("imgly_sticker_animated_clouds"),
  ///         Sticker.existing("imgly_sticker_animated_coffee"),
  ///         Sticker.existing("imgly_sticker_animated_fire"),
  ///         Sticker.existing("imgly_sticker_animated_flower"),
  ///         Sticker.existing("imgly_sticker_animated_gift"),
  ///         Sticker.existing("imgly_sticker_animated_heart"),
  ///         Sticker.existing("imgly_sticker_animated_movie_clap"),
  ///         Sticker.existing("imgly_sticker_animated_rainbow"),
  ///         Sticker.existing("imgly_sticker_animated_stars"),
  ///         Sticker.existing("imgly_sticker_animated_sun"),
  ///         Sticker.existing("imgly_sticker_animated_thumbs_up"),
  ///       ])
  /// ];
  /// ```
  final List<StickerCategory>? categories;

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
  final ColorPalette? colors;

  /// The default tint mode for personal stickers.
  /// ```
  /// // Defaults to:
  /// TintMode.none
  /// ```
  final TintMode? defaultPersonalStickerTintMode;

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
  final bool? personalStickers;

  /// Converts the [StickerOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _actions = actions;
    final _canvasActions = canvasActions;
    final _categories = categories;

    return {
      "actions": _actions == null
          ? null
          : List<dynamic>.from(
              _actions.map((x) => _stickerActionValues.reverse[x])),
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(
              _canvasActions.map((x) => _stickerCanvasActionValues.reverse[x])),
      "categories": _categories == null
          ? null
          : List<dynamic>.from(_categories.map((x) => x._toJson())),
      "colors": colors?._toJson(),
      "defaultPersonalStickerTintMode": defaultPersonalStickerTintMode == null
          ? null
          : _tintModeValues.reverse[defaultPersonalStickerTintMode],
      "personalStickers": personalStickers,
    }..removeWhere((key, value) => value == null);
  }
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
  final List<TextAction>? actions;

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
  final ColorPalette? backgroundColors;

  /// Defines all allowed actions for the text tool that are displayed as
  /// overlay buttons on the canvas.
  /// ```
  /// // Defaults to:
  /// [CanvasAction.add, CanvasAction.delete,
  /// CanvasAction.bringToFront, CanvasAction.undo,
  /// CanvasAction.redo]
  /// ```
  final List<StickerCanvasAction>? canvasActions;

  /// Defines the default text color for newly created text.
  /// ```
  /// // Defaults to:
  /// [1, 1, 1, 1]
  /// ```
  final Color? defaultTextColor;

  /// Defines all available fonts.
  /// New items can be mixed and matched with existing ones.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   Font.existing("imgly_font_open_sans_bold"),
  ///   Font.existing("imgly_font_aleo_bold"),
  ///   Font.existing("imgly_font_amaticsc"),
  ///   Font.existing("imgly_font_archivo_black"),
  ///   Font.existing("imgly_font_bungee_inline"),
  ///   Font.existing("imgly_font_campton_bold"),
  ///   Font.existing("imgly_font_carter_one"),
  ///   Font.existing("imgly_font_codystar"),
  ///   Font.existing("imgly_font_fira_sans_regular"),
  ///   Font.existing("imgly_font_galano_grotesque_bold"),
  ///   Font.existing("imgly_font_krona_one"),
  ///   Font.existing("imgly_font_kumar_one_outline"),
  ///   Font.existing("imgly_font_lobster"),
  ///   Font.existing("imgly_font_molle"),
  ///   Font.existing("imgly_font_monoton"),
  ///   Font.existing("imgly_font_nixie_one"),
  ///   Font.existing("imgly_font_notable"),
  ///   Font.existing("imgly_font_ostrich_sans_black"),
  ///   Font.existing("imgly_font_ostrich_sans_bold"),
  ///   Font.existing("imgly_font_oswald_semi_bold"),
  ///   Font.existing("imgly_font_palanquin_dark_semi_bold"),
  ///   Font.existing("imgly_font_permanent_marker"),
  ///   Font.existing("imgly_font_poppins"),
  ///   Font.existing("imgly_font_roboto_black_italic"),
  ///   Font.existing("imgly_font_roboto_light_italic"),
  ///   Font.existing("imgly_font_sancreek"),
  ///   Font.existing("imgly_font_stint_ultra_expanded"),
  ///   Font.existing("imgly_font_trash_hand"),
  ///   Font.existing("imgly_font_vt323"),
  ///   Font.existing("imgly_font_yeseva_one"),
  /// ];
  /// ```
  final List<Font>? fonts;

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
  final ColorPalette? textColors;

  /// Converts the [TextOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _actions = actions;
    final _backgroundColors = backgroundColors;
    final _canvasActions = canvasActions;
    final _fonts = fonts;

    return {
      "actions": _actions == null
          ? null
          : List<dynamic>.from(
              _actions.map((x) => _textActionValues.reverse[x])),
      "backgroundColors": _backgroundColors?._toJson(),
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(
              _canvasActions.map((x) => _stickerCanvasActionValues.reverse[x])),
      "defaultTextColor": defaultTextColor?._toJson(),
      "fonts": _fonts == null
          ? null
          : List<dynamic>.from(_fonts.map((x) => x._toJson())),
      "textColors": textColors?._toJson(),
    }..removeWhere((key, value) => value == null);
  }
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
abstract class Font extends _NamedItem {
  /// Retrieves an existing font with the given [identifier].
  Font._existing(String identifier) : super.existing(identifier);

  /// Creates a new named [Font].
  Font._custom(String identifier, String name) : super(identifier, name);

  /// Retrieves an [ExistingFont] with the given [identifier].
  factory Font.existing(String identifier) => ExistingFont(identifier);

  /// Creates a new [CustomFont].
  factory Font(String identifier, String fontName, String name,
          {String? fontUri}) =>
      CustomFont(identifier, fontName, name, fontUri: fontUri);

  /// Converts the [Font] for JSON parsing.
  Map<String, dynamic> _toJson() => {"identifier": identifier};
}

/// An existing font.
class ExistingFont extends Font {
  /// Retrieves an existing font with the given [identifier].
  ExistingFont(String identifier) : super._existing(identifier);
}

/// A custom font.
class CustomFont extends Font {
  /// Creates a new [CustomFont].
  CustomFont(
    String identifier,
    this.fontName,
    String name, {
    this.fontUri,
  }) : super._custom(identifier, name);

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
  final String? fontUri;

  /// Converts the [Font] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() => {
        "identifier": identifier,
        "fontName": fontName,
        "fontURI": fontUri,
        "name": name,
      }..removeWhere((key, value) => value == null);
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
  final List<TextDesignCanvasAction>? canvasActions;

  /// The available colors to choose from.
  final ColorPalette? colors;

  /// The available [TextDesign]s.
  /// ```
  /// // Defaults to:
  /// final items = [
  ///   TextDesign.existing("imgly_text_design_blocks"),
  ///   TextDesign.existing("imgly_text_design_rotated"),
  ///   TextDesign.existing("imgly_text_design_blocks_light"),
  ///   TextDesign.existing("imgly_text_design_equal_width"),
  ///   TextDesign.existing("imgly_text_design_masked"),
  ///   TextDesign.existing("imgly_text_design_celebrate"),
  ///   TextDesign.existing("imgly_text_design_sunshine"),
  ///   TextDesign.existing("imgly_text_design_masked_badge"),
  ///   TextDesign.existing("imgly_text_design_blocks_condensed"),
  ///   TextDesign.existing("imgly_text_design_celebrate_simple"),
  ///   TextDesign.existing("imgly_text_design_equal_width_fat"),
  ///   TextDesign.existing("imgly_text_design_watercolor"),
  ///   TextDesign.existing("imgly_text_design_particles"),
  ///   TextDesign.existing("imgly_text_design_masked_speech_bubble"),
  ///   TextDesign.existing("imgly_text_design_masked_speech_bubble_comic"),
  ///   TextDesign.existing("imgly_text_design_multiline"),
  /// ];
  /// ```
  final List<TextDesign>? items;

  /// Converts the [TextDesignOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _canvasActions = canvasActions;
    final _items = items;
    return {
      "canvasActions": _canvasActions == null
          ? null
          : List<dynamic>.from(_canvasActions
              .map((x) => _textDesignCanvasActionValues.reverse[x])),
      "colors": colors?._toJson(),
      "items": _items == null
          ? null
          : List<dynamic>.from(_items.map((x) => x._toJson())),
    }..removeWhere((key, value) => value == null);
  }
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
        "identifier": identifier,
      }..removeWhere((key, value) => value == null);
}

/// An image and/or video editing tool.
enum Tool {
  /// A tool to apply image adjustments.
  adjustment,

  /// A tool to edit the audio track of videos.
  audio,

  /// A tool to add drawings.
  brush,

  /// A tool to compose a video from multiple video clips and to trim the
  /// timeline of the composition and the individual clips.
  composition,

  /// A tool to apply an image filter effect.
  filter,

  /// A tool to add blur.
  focus,

  /// A tool to add a frame.
  frame,

  /// A tool to add an overlay..
  overlay,

  /// A tool to add stickers.
  sticker,

  /// A tool to add texts.
  text,

  /// A tool to add text designs.
  textDesign,

  /// A tool to apply an transformation, such as cropping or rotation.
  transform,

  /// A tool to trim the timeline of videos.
  trim
}

/// The corresponding values to the [Tool].
final _toolValues = _EnumValues({
  "adjustment": Tool.adjustment,
  "audio": Tool.audio,
  "brush": Tool.brush,
  "composition": Tool.composition,
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
  final bool? allowFreeCrop;

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
  final List<CropRatio>? items;

  /// Whether to show a reset button to reset the applied crop, rotation and
  /// tilt angle.
  /// ```
  /// // Defaults to:
  /// true
  /// ```
  final bool? showResetButton;

  /// Converts [TransformOptions] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final _items = items;

    return {
      "allowFreeCrop": allowFreeCrop,
      "items": _items == null
          ? null
          : List<dynamic>.from(_items.map((x) => x._toJson())),
      "showResetButton": showResetButton,
    }..removeWhere((key, value) => value == null);
  }
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
  final String? name;

  /// If enabled the `width` and `height` of a ratio can be toggled in the UI.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool? toggleable;

  /// The width of the ratio.
  final double width;

  /// Converts the [CropRatio] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "height": height,
        "name": name,
        "toggleable": toggleable,
        "width": width,
      }..removeWhere((key, value) => value == null);
}

/// A filter category.
abstract class FilterCategory extends _NamedItem {
  /// Retrieves an existing filter category with the given [identifier].
  FilterCategory._existing(String identifier) : super.existing(identifier);

  /// Creates a new named [FilterCategory].
  FilterCategory._custom(String identifier, String name)
      : super(identifier, name);

  /// Retrieves an [ExistingFilterCategory] with the given [identifier].
  factory FilterCategory.existing(String identifier, {List<Filter>? items}) =>
      ExistingFilterCategory(identifier, items: items);

  /// Creates a new [CustomFilterCategory].
  factory FilterCategory(String identifier, String name,
          {String? thumbnailUri, List<Filter>? items}) =>
      CustomFilterCategory(identifier, name,
          thumbnailUri: thumbnailUri, items: items);

  /// Converts the [FilterCategory] for JSON parsing.
  Map<String, dynamic> _toJson() => {"identifier": identifier};
}

/// A existing filter category.
class ExistingFilterCategory extends FilterCategory {
  /// Retrieves an existing filter category with the given [identifier].
  ExistingFilterCategory(String identifier, {this.items})
      : super._existing(identifier);

  /// Items of the category which can be existing or new defined filters.
  final List<Filter>? items;

  @override
  Map<String, dynamic> _toJson() {
    final map = super._toJson();
    final _items = items;

    if (_items == null) {
      return map;
    } else {
      map.addAll({"items": List<dynamic>.from(_items.map((e) => e._toJson()))});
      return map;
    }
  }
}

/// A custom filter category.
class CustomFilterCategory extends FilterCategory {
  /// Creates a new [CustomFilterCategory].
  CustomFilterCategory(
    String identifier,
    String name, {
    this.items,
    this.thumbnailUri,
  }) : super._custom(identifier, name);

  /// Items of the category which can be existing or new defined filters.
  /// If `null` an empty category will be created.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final List<Filter>? items;

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
  final String? thumbnailUri;

  /// Converts the [FilterCategory] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() {
    final map = Map<String, dynamic>.from({
      "identifier": identifier,
      "name": name,
      "thumbnailURI": thumbnailUri,
    });

    final _items = items;
    if (_items != null) {
      map.addAll({
        "items": List<dynamic>.from(_items.map((x) => x._toJson())),
      });
    }
    return map..removeWhere((key, value) => value == null);
  }
}

/// A filter.
abstract class Filter extends _NamedItem {
  /// Retrieves an existing filter with the given [identifier].
  Filter._existing(String identifier) : super.existing(identifier);

  /// Creates a new named [Filter].
  Filter._custom(String identifier, String name) : super(identifier, name);

  /// Retrieves an [ExistingFilter] with the given [identifier].
  factory Filter.existing(String identifier) => ExistingFilter(identifier);

  /// Converts the [Filter] for JSON parsing.
  Map<String, dynamic> _toJson() => {"identifier": identifier};
}

/// An existing filter.
class ExistingFilter extends Filter {
  /// Retrieves an existing filter with the given [identifier].
  ExistingFilter(String identifier) : super._existing(identifier);
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
  }) : super._custom(identifier, name);

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
  final double? horizontalTileCount;

  /// The number of vertical tiles in the LUT image.
  /// ```
  /// // Defaults to:
  /// 5
  /// ```
  final double? verticalTileCount;

  /// Converts a [LutFilter] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() => {
        "horizontalTileCount": horizontalTileCount,
        "identifier": identifier,
        "lutURI": lutUri,
        "name": name,
        "verticalTileCount": verticalTileCount,
      }..removeWhere((key, value) => value == null);
}

/// A duoTone image filter.
class DuoToneFilter extends Filter {
  /// Creates a new [DuoToneFilter].
  DuoToneFilter(
    String identifier,
    String name,
    this.darkColor,
    this.lightColor,
  ) : super._custom(identifier, name);

  /// The duoTone color that is mapped to dark colors of the input image.
  final Color darkColor;

  /// The duoTone color that is mapped to light colors of the input image
  final Color lightColor;

  /// Converts a [DuoToneFilter] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() => {
        "darkColor": darkColor._toJson(),
        "identifier": identifier,
        "lightColor": lightColor._toJson(),
        "name": name,
      }..removeWhere((key, value) => value == null);
}

/// A sticker category.
abstract class StickerCategory extends _NamedItem {
  /// Retrieves an existing sticker category with the given [identifier].
  StickerCategory._existing(String identifier) : super.existing(identifier);

  /// Creates a new named [StickerCategory].
  StickerCategory._custom(String identifier, String name)
      : super(identifier, name);

  /// Retrieves an [ExistingStickerCategory] with the given [identifier].
  factory StickerCategory.existing(String identifier, {List<Sticker>? items}) =>
      ExistingStickerCategory(identifier, items: items);

  /// Creates a new [CustomStickerCategory].
  factory StickerCategory(String identifier, String name, String thumbnailUri,
          {List<Sticker>? items}) =>
      CustomStickerCategory(identifier, name, thumbnailUri, items: items);

  /// Converts the [StickerCategory] for JSON parsing.
  Map<String, dynamic> _toJson() => {"identifier": identifier};
}

/// A existing sticker category.
class ExistingStickerCategory extends StickerCategory {
  /// Retrieves an existing sticker category with the given [identifier].
  ExistingStickerCategory(String identifier, {this.items})
      : super._existing(identifier);

  /// Items of the category which can be existing or new defined stickers.
  final List<Sticker>? items;

  @override
  Map<String, dynamic> _toJson() {
    final map = super._toJson();
    final _items = items;

    if (_items == null) {
      return map;
    } else {
      map.addAll({"items": List<dynamic>.from(_items.map((e) => e._toJson()))});
      return map;
    }
  }
}

/// A custom sticker category.
class CustomStickerCategory extends StickerCategory {
  /// Creates a new [CustomStickerCategory].
  CustomStickerCategory(
    String identifier,
    String name,
    this.thumbnailUri, {
    this.items,
  }) : super._custom(identifier, name);

  /// Items of the category which can be existing or new defined stickers.
  /// If `null` an empty category will be created.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final List<Sticker>? items;

  /// The source of the thumbnail image of the category.
  /// This should either be the full path, a uri or if
  /// it is an asset the relative path as specified in
  /// your `pubspec.yaml` file.
  final String thumbnailUri;

  /// Converts a [StickerCategory] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() {
    final map = Map<String, dynamic>.from({
      "identifier": identifier,
      "name": name,
      "thumbnailURI": thumbnailUri,
    });

    final _items = items;
    if (_items != null) {
      map.addAll({"items": List<dynamic>.from(_items.map((x) => x._toJson()))});
    }
    return map..removeWhere((key, value) => value == null);
  }
}

/// A sticker.
abstract class Sticker extends _NamedItem {
  /// Retrieves an existing sticker with the given [identifier].
  Sticker._existing(String identifier) : super.existing(identifier);

  /// Creates a new named [Sticker].
  Sticker._custom(String identifier, String name) : super(identifier, name);

  /// Retrieves an [ExistingSticker] with the given [identifier].
  factory Sticker.existing(String identifier) => ExistingSticker(identifier);

  /// Creates a new [CustomSticker].
  factory Sticker(String identifier, String name, String stickerUri,
          {bool? adjustments, String? thumbnailUri, TintMode? tintMode}) =>
      CustomSticker(identifier, name, stickerUri,
          adjustments: adjustments,
          thumbnailUri: thumbnailUri,
          tintMode: tintMode);

  /// Converts the [Sticker] for JSON parsing.
  Map<String, dynamic> _toJson() => {"identifier": identifier};
}

/// An existing sticker.
class ExistingSticker extends Sticker {
  /// Retrieves an existing sticker with the given [identifier].
  ExistingSticker(String identifier) : super._existing(identifier);
}

/// A custom sticker.
class CustomSticker extends Sticker {
  /// Creates a new [CustomSticker].
  CustomSticker(
    String identifier,
    String name,
    this.stickerUri, {
    this.adjustments,
    this.thumbnailUri,
    this.tintMode,
  }) : super._custom(identifier, name);

  /// If enabled the brightness, contrast, and saturation of a sticker can
  /// be changed if the corresponding `StickerAction`s in the `Tool.sticker`
  /// are enabled.
  /// ```
  /// // Defaults to:
  /// false
  /// ```
  final bool? adjustments;

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
  final String? thumbnailUri;

  /// The sticker tint mode.
  /// ```
  /// // Defaults to:
  /// TintMode.none
  /// ```
  final TintMode? tintMode;

  /// Converts a [Sticker] for JSON parsing.
  @override
  Map<String, dynamic> _toJson() => {
        "adjustments": adjustments,
        "identifier": identifier,
        "name": name,
        "stickerURI": stickerUri,
        "thumbnailURI": thumbnailUri,
        "tintMode": tintMode == null ? null : _tintModeValues.reverse[tintMode],
      }..removeWhere((key, value) => value == null);
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
  _NamedItem(String identifier, String name)
      // ignore: prefer_initializing_formals
      : name = name,
        super(identifier);

  /// Retrieves an existing item.
  _NamedItem.existing(String identifier)
      : name = null,
        super(identifier);

  /// The name of the item.
  final String? name;
}

/// A media item.
class _MediaItem extends _UniqueItem {
  /// Creates a new [_MediaItem].
  _MediaItem(String identifier, {this.title, this.artist}) : super(identifier);

  /// The title of the media item.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String? title;

  /// The artist of the media item.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String? artist;
}

/// A video clip category.
class VideoClipCategory extends _NamedItem {
  /// Creates a new [VideoClipCategory].
  VideoClipCategory(String identifier, String name,
      {this.thumbnailURI, this.items})
      : super(identifier, name);

  /// A URI for the thumbnail of the category.
  /// If `null` a placeholder image will be used.
  final String? thumbnailURI;

  /// Items of the category.
  /// If `null` an empty category will be created.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final List<VideoClip>? items;

  /// Converts a [VideoClipCategory] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final map = Map<String, dynamic>.from({
      "name": name,
      "identifier": identifier,
      "thumbnailURI": thumbnailURI,
    });
    final _items = items;
    if (_items != null) {
      map.addAll({"items": List<dynamic>.from(_items.map((e) => e._toJson()))});
    }
    return map..removeWhere((key, value) => value == null);
  }
}

/// A video clip.
class VideoClip extends _MediaItem {
  /// Creates a new [VideoClip].
  VideoClip(String identifier, this.videoURI,
      {String? artist, String? title, this.thumbnailURI})
      : super(identifier, title: title, artist: artist);

  /// A URI for the thumbnail image of the video clip.
  /// If `null` the thumbnail will be automatically generated from the
  /// `videoURI`.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String? thumbnailURI;

  /// A URI for the video clip.
  /// Remote resources are not optimized and therefore should be downloaded
  /// in advance and then passed to the editor as local resources.
  final String videoURI;

  /// Converts a [VideoClip] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "thumbnailURI": thumbnailURI,
        "videoURI": videoURI,
        "identifier": identifier,
        "artist": artist,
        "title": title,
      }..removeWhere((key, value) => value == null);
}

/// An audio clip category.
class AudioClipCategory extends _NamedItem {
  /// Creates a new [AudioClipCategory].
  AudioClipCategory(String identifier, String name,
      {this.thumbnailURI, this.items})
      : super(identifier, name);

  /// A URI for the thumbnail of the category.
  /// If `null` a placeholder image will be used.
  final String? thumbnailURI;

  /// Items of the category.
  /// If `null` an empty category will be created.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final List<AudioClip>? items;

  /// Converts a [AudioClipCategory] for JSON parsing.
  Map<String, dynamic> _toJson() {
    final map = Map<String, dynamic>.from({
      "name": name,
      "identifier": identifier,
      "thumbnailURI": thumbnailURI,
    });

    final _items = items;
    if (_items != null) {
      map.addAll({"items": List<dynamic>.from(_items.map((e) => e._toJson()))});
    }
    return map..removeWhere((key, value) => value == null);
  }
}

/// An audio clip.
class AudioClip extends _MediaItem {
  /// Creates a new [AudioClip].
  AudioClip(String identifier, this.audioURI,
      {String? title, String? artist, this.thumbnailURI, this.duration})
      : super(identifier, title: title, artist: artist);

  /// The duration of the audio clip in seconds.
  /// If `null` the duration will be automatically derived from the asset.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final double? duration;

  /// A URI for the thumbnail image of the audio clip.
  /// If `null` a placeholder image will be used.
  /// ```
  /// // Defaults to:
  /// null
  /// ```
  final String? thumbnailURI;

  /// A URI for the audio clip.
  /// Audio clips from remote resources can be previewed in the editor but
  /// their export will fail! Remote audio resources are currently supported
  /// for debugging purposes only.
  final String audioURI;

  /// Converts a [AudioClip] for JSON parsing.
  Map<String, dynamic> _toJson() => {
        "thumbnailURI": thumbnailURI,
        "audioURI": audioURI,
        "duration": duration,
        "identifier": identifier,
        "artist": artist,
        "title": title,
      }..removeWhere((key, value) => value == null);
}

/// Maps the corresponding values to the enum.
class _EnumValues<T> {
  /// The map.
  final Map<String, T> map;

  /// The reversed map.
  Map<T, String>? reverseMap;

  /// Creates new [_EnumValues].
  _EnumValues(this.map);

  /// Gets the reverse.
  Map<T, String> get reverse {
    return map.map((k, v) => MapEntry(v, k));
  }
}
