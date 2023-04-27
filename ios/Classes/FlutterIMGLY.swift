import Flutter
import UIKit
import ImglyKit
import MobileCoreServices

@available(iOS 13.0, *)
open class FlutterIMGLY: NSObject {

    // MARK: - Typealias

    /// The typealias for creating a `MediaEditViewController`.
    public typealias IMGLYMediaEditViewControllerBlock = (_ configuration: Configuration?,_ serializationData: Data?) -> MediaEditViewController?

    /// A block used to return the `outputImageFileFormatUTI`.
    public typealias IMGLYUTIBlock = (_ configuration: Configuration?) -> CFString

    /// A completion block.
    public typealias IMGLYCompletionBlock = () -> Void

    /// A block to modify the `Configuration`.
    public typealias IMGLYConfigurationBlock = (_ builder: ConfigurationBuilder) -> Void

    /// An alias of `URL` for clarification purposes.
    public typealias IMGLYExportURL = URL

    /// An alias of a `Dictionary` used to simplification.
    public typealias IMGLYDictionary = Dictionary<String, Any>

    // MARK: - Constants

    /// The `FlutterResult` handler for the plugin.
    public var result: FlutterResult?

    /// The `FlutterPluginRegistrar` used for the communication
    /// with the Flutter plugin.
    public static var registrar: FlutterPluginRegistrar?

    /// The `FlutterMethodChannel` used for the communication
    /// with the Flutter plugin.
    public static var methodeChannel: FlutterMethodChannel?

    /// The `IMGLYConfigurationBlock` block to modify the `Configuration` before it is used to initialize a new `MediaEditViewController` instance.
    /// The configuration defined in Dart is already applied to the provided `ConfigurationBuilder` object.
    public static var configureWithBuilder: IMGLYConfigurationBlock?

    /// The currently presented `MediaEditViewController`.
    private var mediaEditViewController: MediaEditViewController?

    /// The export type can either be fileURL or dataURL.
    public var exportType: String?

    /// The future location of the export data.
    public var exportFile: URL?

    /// Whether or not the serialization feature should be enabled.
    public var serializationEnabled: Bool?

    /// The type can be either an object or a file.
    public var serializationType: String?

    /// The desired location of the serialization file.
    public var serializationFile: URL?

    /// Whether or not to include the original image
    /// within the serialization.
    public var serializationEmbedImage: Bool?

    /// Indicates whether the VideoEditor SDK should export the individual video segments.
    public var serializeVideoSegments: Bool = false

    /// IMGLY constants for the plugin use.
    public struct IMGLYConstants {
        public static let kErrorUnableToUnlock = "E_UNABLE_TO_UNLOCK"
        public static let kErrorUnableToLoad = "E_UNABLE_TO_LOAD"
        public static let kErrorUnableToExport = "E_UNABLE_TO_EXPORT"
        public static let kErrorMultipleRequests = "E_MULTIPLE_REQUESTS"

        public static let kExportTypeFileURL = "file-url"
        public static let kExportTypeDataURL = "data-url"
        public static let kExportTypeObject = "object"
    }

    // MARK: - Deinit

    deinit {
        if let mediaEditController = self.mediaEditViewController {
            self.dismiss(mediaEditViewController: mediaEditController, animated: false, completion: nil)
        }
    }

    // MARK: - Presentation

    /// Presents a `MediaEditViewController`.
    /// - Parameter createMediaEditViewController: The `IMGLYMediaEditViewControllerBlock` that returns the `MediaEditViewController`.
    /// - Parameter getUTI: The `IMGLYUTIBlock` that returns the correct UTI.
    /// - Parameter configuration: The configuration to apply to the `MediaEditViewController`.
    /// - Parameter serialization: The serialization with which the `MediaEditViewController` should be loaded.
    public func present(mediaEditViewControllerBlock createMediaEditViewController: @escaping IMGLYMediaEditViewControllerBlock, utiBlock getUTI: @escaping IMGLYUTIBlock, configurationData: IMGLYDictionary?, serialization: IMGLYDictionary?) {

        // The data from the JSON serialization.
        var serializationData: Data?

        // The configuration used for the editor.
        var configuration: Configuration?

        // The returned editor.
        var mediaEditViewController: MediaEditViewController?

        // Retrieve the serialization data and reject the Flutter request if needed.
        if let serializationOriginalData = serialization {
            do {
                try serializationData = JSONSerialization.data(withJSONObject: serializationOriginalData, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            } catch let error {
                self.result?(FlutterError(code: "Invalid serialization", message: "The serialization could not be read. For more information look into the details.", details: error.localizedDescription))
                self.result = nil
            }
        }

        // Run on the main queue in order to align with the license validation.
        DispatchQueue.main.async {
            // Retrieve the configuration.
            let assetCatalog = AssetCatalog.defaultItems
            let configurationDictionary = configurationData ?? [String: Any]()
            // Resolve the assets first.
            guard let resolvedConfiguration = self.resolveAssets(for: configurationDictionary) else {
                self.result?(FlutterError(code: "Configuration invalid.", message: "The provided configuration is invalid.", details: nil))
                self.result = nil
                return
            }

            let parsedConfiguration = Configuration { (builder) in
                builder.assetCatalog = assetCatalog
                do {
                    try builder.configure(from: resolvedConfiguration as [String : Any])
                } catch let error {
                    self.result?(FlutterError(code: "Configuration could not be applied.", message: "The provided configuration is invalid. For futher information see the error attached in the details.", details: "ERROR:\(error.localizedDescription)"))
                    self.result = nil
                    return
                }
            }

            // Get the correct export settings.
            guard let exportTypeValue = self.IMGLYDictionary(with: resolvedConfiguration, valueForKeyPath: "export.image.exportType", defaultValue: IMGLYConstants.kExportTypeFileURL) as? String,
                  let exportFileValue = self.IMGLYDictionary(with: resolvedConfiguration, valueForKeyPath: "export.filename", defaultValue: "imgly-export/\(UUID().uuidString)") as? String,
                  let serializationEnabledValue = self.IMGLYDictionary(with: resolvedConfiguration, valueForKeyPath: "export.serialization.enabled", defaultValue: false) as? Bool,
                  let serializationTypeValue = self.IMGLYDictionary(with: resolvedConfiguration, valueForKeyPath: "export.serialization.exportType", defaultValue: IMGLYConstants.kExportTypeFileURL) as? String,
                  let serializationFileValue = self.IMGLYDictionary(with: resolvedConfiguration, valueForKeyPath: "export.serialization.filename", defaultValue: "imgly-export/\(UUID().uuidString)") as? String,
                  let serializationEmbedImageValue = self.IMGLYDictionary(with: resolvedConfiguration, valueForKeyPath: "export.serialization.embedSourceImage", defaultValue: false) as? Bool,
                  let serializeVideoSegments = self.IMGLYDictionary(with: resolvedConfiguration, valueForKeyPath: "export.video.segments", defaultValue: false) as? Bool else {
                self.result?(FlutterError(code: "Configuration invalid.", message: "The configuration could not be parsed.", details: nil))
                self.result = nil
                return
            }

            // Convert the desired file urls into a readable URL.
            let exportFileURL = self.retrieveExportURL(with: exportFileValue, uti: getUTI(parsedConfiguration))
            let serializationFile = self.retrieveExportURL(with: serializationFileValue, uti: kUTTypeJSON)

            // Assign the export settings.
            self.exportType = exportTypeValue
            self.exportFile = exportFileURL
            self.serializationEnabled = serializationEnabledValue
            self.serializationType = serializationTypeValue
            self.serializationFile = serializationFile
            self.serializationEmbedImage = serializationEmbedImageValue
            self.serializeVideoSegments = serializeVideoSegments

            // Check whether the export settings are valid.
            if (self.exportType == nil) || (self.exportFile == nil && self.exportType == IMGLYConstants.kExportTypeFileURL) || (serializationFile == nil && self.serializationType == IMGLYConstants.kExportTypeFileURL) {
                self.result?(FlutterError(code: "Export settings invalid.", message: "The export settings are not valid. Please check them again.", details: nil))
                self.result = nil
                return
            }

            // Update the export settings configuration
            var updatedDictionary: IMGLYDictionary = resolvedConfiguration
            if var exportDictionary = updatedDictionary.value(forKeyPath: "export", defaultValue: nil) as? IMGLYDictionary {
                exportDictionary.setValue(self.exportFile?.absoluteString ?? NSNull.self, forKeyPath: "filename")
                updatedDictionary.setValue(exportDictionary, forKeyPath: "export")
            }

            let toolbarMode = updatedDictionary.value(forKeyPath: "toolbarMode", defaultValue: nil) as? String

            configuration = Configuration(builder: { (builder) in
                builder.assetCatalog = assetCatalog
                do {
                    try builder.configure(from: updatedDictionary)
                } catch let error {
                    self.result?(FlutterError(code: "Configuration could not be applied.", message: "The provided configuration is invalid. For futher information see the error attached in the details.", details: "ERROR:\(error.localizedDescription)"))
                    self.result = nil
                    return
                }
                if toolbarMode == "top" {
                    self.configureToolbar(builder)
                }
                FlutterIMGLY.configureWithBuilder?(builder)
            })
            // Finally present the editor itself.
            mediaEditViewController = createMediaEditViewController(configuration, serializationData)

            if let controller = mediaEditViewController {
                if toolbarMode == "top" {
                    let navigationController = UINavigationController(rootViewController: controller)
                    navigationController.modalPresentationStyle = .fullScreen

                    let appearance = UINavigationBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = configuration?.theme.toolbarBackgroundColor
                    appearance.shadowColor = configuration?.theme.toolbarBackgroundColor
                    navigationController.navigationBar.standardAppearance = appearance
                    navigationController.navigationBar.scrollEdgeAppearance = appearance
                    navigationController.navigationBar.compactAppearance = appearance
                    if #available(iOS 15.0, *) {
                        navigationController.navigationBar.compactScrollEdgeAppearance = appearance
                    }

                    UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
                } else {
                    UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
                }
            } else {
                self.result?(FlutterError(code: "Editor could not be initialized.", message: nil, details: nil))
                self.result = nil
            }
        }
    }

    private func configureToolbar(_ builder: ConfigurationBuilder) {
        let toolbarButtonClosure: (ImglyKit.Button) -> Void = { button in
            button.tintColor = builder.theme.primaryColor
        }

        // Configure `VideoEditViewController`.
        builder.configureVideoEditViewController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }

        // Configure `PhotoEditViewController`.
        builder.configurePhotoEditViewController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }

        // Configure tools.
        builder.configureTransformToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureCompositionToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureTrimToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureClipTrimToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureAudioToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureAudioClipToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureVideoClipToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureFilterToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureAdjustToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureFocusToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureStickerToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureStickerColorToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureStickerOptionsToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureTextToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureTextOptionsToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureTextFontToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureTextColorToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureTextDesignToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureTextDesignOptionsToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureOverlayToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureFrameToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureFrameOptionsToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureBrushToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
        builder.configureBrushColorToolController { options in
            options.applyButtonConfigurationClosure = toolbarButtonClosure
            options.discardButtonConfigurationClosure = toolbarButtonClosure
        }
    }

    /// Dismisses an `MediaEditViewController` instance.
    /// - Parameter mediaEditPreviewController: The `MediaEditViewController` to dismiss.
    /// - Parameter animated: Whether or not to animated the dismissal.
    public func dismiss(mediaEditViewController: MediaEditViewController, animated: Bool, completion: IMGLYCompletionBlock?)  {
        self.exportType = nil
        self.exportFile = nil
        self.serializationEnabled = false
        self.serializationType = nil
        self.serializationFile = nil
        self.serializationEmbedImage = false
        self.mediaEditViewController = nil

        mediaEditViewController.presentingViewController?.dismiss(animated: animated, completion: completion)
    }

    // MARK: - Licensing

    /// Unlocks the license from an asset path.
    /// Redirects the call to one of the unlocking functions below.
    /// - Parameter licensePath: The relative path to the license.
    public func unlockWithLicense(with licensePath: String) {
        let validLicensePath = licensePath + ".ios"
        guard let key = FlutterIMGLY.registrar?.lookupKey(forAsset: validLicensePath),
              let url = Bundle.main.url(forResource: key, withExtension: nil) else {
            self.result?(FlutterError(code: "License validation failed.", message: "Unlocking the SDK failed due to:", details: "The license file could not be found in the bundle."))
            self.result = nil
            return
        }
        self.unlockWithLicenseFile(at: url)
    }

    /// Unlocks the SDK witha license from a given file.
    /// - Parameter url: The url where the file is located.
    open func unlockWithLicenseFile(at url: URL) {}
}

/// Extension for converting wrappers.
@available(iOS 13.0, *)
extension FlutterIMGLY {
    /// Retrieves the value for the given key path.
    /// - Parameter dictionary: The dictionary to get the values from.
    /// - Parameter path: The path of the value.
    /// - Parameter defaultValue: The value to return if not value is set.
    /// - Returns: The value of the key path.
    private func IMGLYDictionary(with dictionary: IMGLYDictionary?, valueForKeyPath path: String, defaultValue: Any) -> Any? {
        if dictionary == nil {
            return defaultValue
        }
        return dictionary?.value(forKeyPath: path, defaultValue: defaultValue)
    }

    /// Convers the dedicated export settings into an `IMGLYExportURL`.
    /// - Parameter url: The export setting.
    /// - Returns: The corresponding `IMGLYExportURL`.
    private func convertURL(with url: Any) -> IMGLYExportURL? {
        guard var path = url as? NSString else { return nil }

        var tempURL = URL(string: path as String)
        if tempURL?.scheme != nil {
            return tempURL as URL?
        } else {
            if path.range(of: ":").location != NSNotFound {
                let urlAllowedCharacterSet = NSMutableCharacterSet()
                urlAllowedCharacterSet.formUnion(with: .urlUserAllowed)
                urlAllowedCharacterSet.formUnion(with: .urlPasswordAllowed)
                urlAllowedCharacterSet.formUnion(with: .urlHostAllowed)
                urlAllowedCharacterSet.formUnion(with: .urlPathAllowed)
                urlAllowedCharacterSet.formUnion(with: .urlQueryAllowed)
                urlAllowedCharacterSet.formUnion(with: .urlFragmentAllowed)
                path = path.addingPercentEncoding(withAllowedCharacters: urlAllowedCharacterSet as CharacterSet) as NSString? ?? path
                tempURL = URL(string: path as String)
                if tempURL != nil {
                    return tempURL
                }
            }
        }

        path = path.removingPercentEncoding as NSString? ?? path
        if path.hasPrefix("~") {
            // Path is inside user directory
            path = path.expandingTildeInPath as NSString
        } else if !path.isAbsolutePath {
            // Create a path to a temporary file
            path = NSTemporaryDirectory().appending(path as String) as NSString
        }

        tempURL = URL(fileURLWithPath: path as String, isDirectory: false)
        return tempURL
    }

    /// Retrieves the correct `IMGLYExportURL` for exporting.
    /// - Parameter url: The input url to format.
    /// - Parameter expectedUTI: The UTI for the file.
    /// - Returns: The converted `IMGLYExportURL`.
    private func retrieveExportURL(with url: Any, uti: CFString) -> IMGLYExportURL? {
        guard let fileExtension = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension)?.takeRetainedValue() as String?, let baseUrl = convertURL(with: url) else { return nil }
        return baseUrl.appendingPathExtension(fileExtension)
    }
}

/// Extension responsible for resolving the assets of a `Configuration`.
@available(iOS 13.0, *)
extension FlutterIMGLY {
    /// Wraps around the Flutter source in order to resolve
    /// nested assets from within the `Configuration`.
    public class EmbeddedAsset {

        /// The initial source that needs to be parsed.
        let source: String

        /// Returns the resolved URL as a `String`.
        public var resolvedURL: String? {
            if source.starts(with: "/") {
                return URL(fileURLWithPath: source).absoluteString
            } else if let url = URL(string: source), UIApplication.shared.canOpenURL(url) {
                return url.absoluteString
            } else {
                let lookUpKey = FlutterIMGLY.registrar?.lookupKey(forAsset: source)
                let url = Bundle.main.url(forResource: lookUpKey, withExtension: nil)
                return url?.absoluteString
            }
        }

        /// Initializes a new `IMGLYEmbeddedAsset` object.
        /// - Parameter configurationDictionary: The `NSDictionary` data to initialize the object from.
        public required init(from source: String) {
            self.source = source
        }
    }

    /// Resolves the nested assets of a `Configuration`.
    /// - Parameter configuration: The `Configuration` as IMGLYDictionary.
    /// - Returns: The correctly resolved `Configuration` in JSON format.
    private func resolveAssets(for configuration: IMGLYDictionary) -> IMGLYDictionary? {
        var resolvedConfiguration = configuration

        // Audio
        let audioCategoriesKeyPath = "audio.categories"
        let audioCategoryResolvingKeyPaths = ["thumbnailURI"]
        let audioKeyPath = "items"
        let audioResolvingKeyPaths = ["thumbnailURI", "audioURI"]

        if let audioCategories = self.resolveNestedCategories(from: resolvedConfiguration, at: audioCategoriesKeyPath, with: audioCategoryResolvingKeyPaths, at: audioKeyPath, with: audioResolvingKeyPaths) {
            resolvedConfiguration.setValue(audioCategories, forKeyPath: audioCategoriesKeyPath)
        }

        // Video composition
        let videoCategoriesKeyPath = "composition.categories"
        let videoCategoryResolvingKeyPaths = ["thumbnailURI"]
        let videoKeyPath = "items"
        let videoResolvingKeyPaths = ["thumbnailURI", "videoURI"]

        if let videoCategories = self.resolveNestedCategories(from: resolvedConfiguration, at: videoCategoriesKeyPath, with: videoCategoryResolvingKeyPaths, at: videoKeyPath, with: videoResolvingKeyPaths) {
            resolvedConfiguration.setValue(videoCategories, forKeyPath: videoCategoriesKeyPath)
        }

        // Frames
        let frameKeyPath = "frame.items"
        let imageGroupTopKeyPaths = ["imageGroups.top.startURI", "imageGroups.top.midURI", "imageGroups.top.endURI"]
        let imageGroupBottomKeyPaths = ["imageGroups.bottom.startURI", "imageGroups.bottom.midURI", "imageGroups.bottom.endURI"]
        let imageGroupLeftKeyPaths = ["imageGroups.left.startURI", "imageGroups.left.midURI", "imageGroups.left.endURI"]
        let imageGroupRightKeyPaths = ["imageGroups.right.startURI", "imageGroups.right.midURI", "imageGroups.right.endURI"]
        let thumbnailPath = ["thumbnailURI"]
        let unifiedFrameKeyPaths = thumbnailPath + imageGroupTopKeyPaths + imageGroupBottomKeyPaths + imageGroupLeftKeyPaths + imageGroupRightKeyPaths
        if let resolvedFrames = self.resolveCategories(from: resolvedConfiguration, at: frameKeyPath, with: unifiedFrameKeyPaths) {
            resolvedConfiguration.setValue(resolvedFrames, forKeyPath: frameKeyPath)
        }

        // Overlays
        let overlayKeyPath = "overlay.items"
        let overlayResolvingKeyPaths = ["thumbnailURI", "overlayURI"]
        if let resolvedOverlays = self.resolveCategories(from: resolvedConfiguration, at: overlayKeyPath, with: overlayResolvingKeyPaths) {
            resolvedConfiguration.setValue(resolvedOverlays, forKeyPath: overlayKeyPath)
        }

        // Fonts
        let fontKeyPath = "text.fonts"
        let fontResolvingKeyPaths = ["fontURI"]
        if let resolvedFonts = self.resolveCategories(from: resolvedConfiguration, at: fontKeyPath, with: fontResolvingKeyPaths) {
            resolvedConfiguration.setValue(resolvedFonts, forKeyPath: fontKeyPath)
        }

        // Stickers
        let stickerCategoriesKeyPath = "sticker.categories"
        let stickerCategoryResolvingKeyPaths = ["thumbnailURI"]
        let stickerKeyPath = "items"
        let stickerResolvingKeyPaths = ["thumbnailURI", "stickerURI"]

        if let stickerCategories = self.resolveNestedCategories(from: resolvedConfiguration, at: stickerCategoriesKeyPath, with: stickerCategoryResolvingKeyPaths, at: stickerKeyPath, with: stickerResolvingKeyPaths) {
            resolvedConfiguration.setValue(stickerCategories, forKeyPath: stickerCategoriesKeyPath)
        }

        // Filters
        let filterCategoryKeyPath = "filter.categories"
        let filterCategoryResolvingKeyPaths = ["thumbnailURI"]
        let filterKeyPath = "items"
        let filterResolvingKeyPaths = ["lutURI"]

        if let filterCategories = self.resolveNestedCategories(from: resolvedConfiguration, at: filterCategoryKeyPath, with: filterCategoryResolvingKeyPaths, at: filterKeyPath, with: filterResolvingKeyPaths) {
            resolvedConfiguration.setValue(filterCategories, forKeyPath: filterCategoryKeyPath)
        }

        // Watermark
        let watermarkKeyPath = "watermark"
        let watermarkResolvingKeyPaths = ["watermarkURI"]

        if let watermarkOptions = resolvedConfiguration.value(forKeyPath: watermarkKeyPath, defaultValue: nil) as? IMGLYDictionary {
            let resolvedWatermark = self.resolveNestedAssets(from: watermarkOptions, with: watermarkResolvingKeyPaths)
            resolvedConfiguration.setValue(resolvedWatermark, forKeyPath: watermarkKeyPath)
        }
        return resolvedConfiguration
    }

    /// Resolves assets for nested categories.
    /// - Parameter baseSource: The `IMGLYDictionary` to get all data from.
    /// - Parameter baseKeyPath: The key path to the top level categories.
    /// - Parameter keyPaths: The key paths to resolve from the top level categories.
    /// - Parameter subKeyPath: The key path to the nested categories (if any).
    /// - Parameter subKeyPaths: The key paths to resolve from the nested categories.
    /// - Returns: An array of the top level `IMGLYDictionary` categories with modified nested
    ///            categories if needed.
    private func resolveNestedCategories(from baseSource: IMGLYDictionary, at baseKeyPath: String, with keyPaths: [String], at subKeyPath: String?, with subKeyPaths: [String]?) -> [IMGLYDictionary]? {

        if var categories = self.resolveCategories(from: baseSource, at: baseKeyPath, with: keyPaths) {
            if let subKey = subKeyPath, let subPaths = subKeyPaths {
                categories.enumerated().forEach { (subCategory) in
                    if let stickers = self.resolveCategories(from: subCategory.element, at: subKey, with: subPaths) {
                        var resolvedStickerCategory = subCategory.element
                        resolvedStickerCategory.setValue(stickers, forKeyPath: subKey)
                        categories[subCategory.offset] = resolvedStickerCategory
                    }
                }
                return categories
            } else {
                return categories
            }
        } else {
            return nil
        }
    }

    /// Resolves assets for the sub-dictionaries.
    /// - Parameter baseSource: The `IMGLYDictionary` to get all data from.
    /// - Parameter baseKeyPath: The key path to the top level categories.
    /// - Parameter keyPaths: The key paths to resolve from the top level categories.
    /// - Returns: An array of the top level `IMGLYDictionary` categories.
    private func resolveCategories(from baseSource: IMGLYDictionary, at baseKeyPath: String, with keyPaths: [String]) -> [IMGLYDictionary]? {
        if var categories = baseSource.value(forKeyPath: baseKeyPath, defaultValue: nil) as? [IMGLYDictionary] {
            categories.enumerated().forEach { (category) in
                let resolvedDict = self.resolveNestedAssets(from: category.element, with: keyPaths)
                categories[category.offset] = resolvedDict
            }
            return categories
        } else {
            return nil
        }
    }

    /// Resolves nested assets by converting the URIs into a readyble URL.
    /// - Parameter source: The source dictionary.
    /// - Parameter keyPaths: The key paths where assets need to be resolved.
    /// - Returns: An `IMGLYDictionary` with the correct URL.
    private func resolveNestedAssets(from source: IMGLYDictionary, with keyPaths: [String]) -> IMGLYDictionary {
        var modifiedSource = source
        keyPaths.forEach { (path) in
            if let keyValue = source.value(forKeyPath: path, defaultValue: nil) as? String {
                let wrappedAsset = EmbeddedAsset(from: keyValue)
                modifiedSource.setValue(wrappedAsset.resolvedURL ?? NSNull.self, forKeyPath: path)
            }
        }
        return modifiedSource
    }
}

/// Extension for the `Data` class in order to simplify the URL writing process.
extension Data {
    /// Writes itself to the given `URL`.
    /// - Parameter fileURL: The `URL` to write the data to.
    /// - Parameter createDirectory: Whether to create a directory.
    /// - throws: An `Error` object.
    public func IMGLYwriteToUrl(_ fileURL: URL, andCreateDirectoryIfNeeded createDirectory: Bool) throws {
        if createDirectory {
            try FileManager.default.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
        }
        try self.write(to: fileURL, options: .atomicWrite)
    }
}

/// Extension for the `Dictionary` in order to access and modify nested dictionaries.
extension Dictionary {

    // MARK: - Public

    /// Gets the value for a given key path.
    /// - Parameter forKeyPath: The key path to the value.
    /// - Parameter defaultValue: The default value in case the value is nil/NSNull.
    /// - Returns: The value for the key path.
    func value(forKeyPath: String, defaultValue: Any?) -> Any? {
        guard let keys = self.keys(for: forKeyPath) else { return nil }
        let value = self.retrieveValue(forKeys: keys)
        if let val = value, !(val is NSNull) {
            return val
        } else {
            return defaultValue
        }
    }

    /// Changes the value for a given key path.
    /// - Parameter forKeyPath: The key path to the value.
    /// - Parameter value: The new value for the key path.
    mutating func setValue(_ value: Any, forKeyPath: String) {
        guard let keys = self.keys(for: forKeyPath) else { return }
        return self.mutateValue(value, forKeys: keys)
    }

    // MARK: - Private

    /// Converts the key path into usable `Key`s.
    /// - Parameter keyPath: The key path to convert.
    /// - Returns: An array of `Key`s.
    private func keys(for keyPath: String) -> [Key]? {
        let keys = keyPath.components(separatedBy: ".").reversed().compactMap({ $0 as? Key })
        return keys.isEmpty ? nil : keys
    }

    /// Retrieves the value for a key path.
    /// - Parameter keys: The key path represented in `Key`s.
    /// - Returns: The value at the path.
    private func retrieveValue(forKeys keys: [Key]) -> Any? {
        guard let lastKey = keys.last, let value = self[lastKey] else { return nil }
        return keys.count == 1 ? value : (value as? [Key: Any]).flatMap { $0.retrieveValue(forKeys: Array(keys.dropLast())) }
    }

    /// Changes the value for a key path.
    /// - Parameter value: The new value.
    /// - Parameter keys: The key path represented in `Key`s.
    private mutating func mutateValue(_ value: Any, forKeys keys: [Key]) {
        guard let lastKey = keys.last, self[lastKey] != nil else { return }
        if keys.count == 1 {
            (value as? Value).map { self[lastKey] = $0 }
        } else if var subDict = self[lastKey] as? [Key: Value] {
            subDict.mutateValue(value, forKeys: Array(keys.dropLast()))
            (subDict as? Value).map { self[lastKey] = $0 }
        }
    }
}
