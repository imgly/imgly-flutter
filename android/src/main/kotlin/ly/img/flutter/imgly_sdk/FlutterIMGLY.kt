package ly.img.flutter.imgly_sdk

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import ly.img.android.pesdk.backend.model.state.manager.SettingsList
import ly.img.android.pesdk.ui.activity.EditorBuilder
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import kotlin.jvm.Throws

import ly.img.android.pesdk.ui.utils.PermissionRequest
import ly.img.android.pesdk.utils.MainThreadRunnable
import ly.img.android.sdk.config.Configuration
import ly.img.android.sdk.config.skipIfNotExists
import ly.img.android.serializer._3.IMGLYFileReader

open class FlutterIMGLY: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware, PluginRegistry.RequestPermissionsResultListener, PluginRegistry.ActivityResultListener, PermissionRequest.Response {

  /** The *MethodChannel* that will handle the communication between Flutter and native Android.
   *
   * This local reference serves to register the plugin with the Flutter Engine and unregister it
   * when the Flutter Engine is detached from the Activity.
   */
  lateinit var channel : MethodChannel

  /** The currently used *Activity*. */
  var currentActivity: Activity? = null

  /** The current *Result* handling the message channel. */
  var result: MethodChannel.Result? = null

  /** The currently used `Configuration`. */
  var currentConfig: Configuration? = null

  /** The currently used *SettingsList*. */
  var currentSettingsList: SettingsList? = null

  /** The currently used *FlutterPluginBinding*. */
  private var binding: FlutterPlugin.FlutterPluginBinding? = null

  /** Called as soon as the plugin is attached to the engine. */
  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    this.binding = binding
  }

  /** Called as soon as the plugin is detached to the engine. */
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  /** Called as soon as the plugin receives a *call* from the method channel. */
  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) { }

  /** Called as soon as the plugin receives the result for a permission request. */
  override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray?): Boolean {
    if (grantResults != null) {
      PermissionRequest.onRequestPermissionsResult(requestCode, permissions, grantResults)
      return true
    }
    return false
  }

  /** Called as soon as a permission request has been granted. */
  override fun permissionGranted() {}

  /** Called as soon as a permission request has been denied. */
  override fun permissionDenied() {}

  /** Called as soon as the plugin receives the result of the activity. */
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean { return false }

  /** Called as soon as the plugin is attached to an activity. */
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.currentActivity = binding.activity
    binding.addActivityResultListener(this)
    binding.addRequestPermissionsResultListener(this)
  }

  /** Called as soon as the plugin is detached from an activity. */
  override fun onDetachedFromActivity() {
    this.currentActivity = null
  }

  /** Called as soon as the plugin is detached from an activity for config changes. */
  override fun onDetachedFromActivityForConfigChanges() {
    this.currentActivity = null
  }

  /** Called as soon as the plugin is attached to an activity for config changes. */
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    this.currentActivity = binding.activity
    binding.addActivityResultListener(this)
    binding.addRequestPermissionsResultListener(this)
  }

  /**
   * Starts the editor.
   *
   * @param settingsList The *SettingsList* which configures the editor.
   */
  fun startEditor(settingsList: SettingsList, resultID: Int) {
    val currentActivity = this.currentActivity ?: throw RuntimeException("Can't start the Editor because there is no current activity")
    MainThreadRunnable {
      EditorBuilder(currentActivity)
              .setSettingsList(settingsList)
              .startActivityForResult(currentActivity, resultID, PermissionRequest.NEEDED_EDITOR_PERMISSIONS)
    }()
  }

  /**
   * Resolves the asset to unlock the license.
   *
   * @param asset The relative path to the license within the assets folder.
   */
  fun resolveLicense(asset: String?) {
    val validAsset = asset + ".android"
    if (validAsset != null) {
      binding?.flutterAssets?.getAssetFilePathBySubpath(validAsset)?.also { path ->
        val licenseContent = binding?.applicationContext?.assets?.open(path)?.bufferedReader().use { it?.readText() }
        licenseContent?.also {
          this.unlockWithLicense(it)
        } ?: run {
          result?.error("Invalid license.", "The license content can not be empty.", null)
        }
      } ?: run {
        result?.error("Invalid license.", "The license can not be found..", null)
      }
    } else {
      result?.error("Invalid license.", "The license can not be nil.", null)
    }
  }

  /**
   * Unlocks the SDK with a stringified license.
   *
   * @param license The license as a *String*.
   */
  open fun unlockWithLicense(license: String) { }

  /**
   * Reads and applies the serialization.
   *
   * @param settingsList The *SettingsList* to apply the serialization to.
   * @param serialization The serialization as a *String*.
   * @param readImage Whether or not to read the image.
   */
  fun readSerialisation(settingsList: SettingsList, serialization: String?, readImage: Boolean) {
    if (serialization != null) {
      skipIfNotExists {
        IMGLYFileReader(settingsList).also {
          it.readJson(serialization, readImage)
        }
      }
    }
  }

  /**
   * Configures and presents the editor.
   *
   * @param asset The asset source as *String* which should be loaded into the editor.
   * @param config The *Configuration* to configure the editor with as if any.
   * @param serialization The serialization to load into the editor if any.
   */
  open fun present(asset: String, config: HashMap<String, Any>?, serialization: String?) { }

  /**
   * Resolves the nested assets from a configuration map.
   *
   * @param source The configuration as a *MutableHashMap<String, Any>*.
   * @return The resolved configuration as a *MutableHashMap<String, Any>*.
   */
  fun resolveAssets(source: MutableMap<String, Any>) : MutableMap<String, Any> {
    // Resolve the frames.
    val frameKeyPath = "frame.items"
    val imageGroupTopKeyPaths = listOf("imageGroups.top.startURI", "imageGroups.top.midURI", "imageGroups.top.endURI")
    val imageGroupBottomKeyPaths = listOf("imageGroups.bottom.startURI", "imageGroups.bottom.midURI", "imageGroups.bottom.endURI")
    val imageGroupLeftKeyPaths = listOf("imageGroups.left.startURI", "imageGroups.left.midURI", "imageGroups.left.endURI")
    val imageGroupRightKeyPaths = listOf("imageGroups.right.startURI", "imageGroups.right.midURI", "imageGroups.right.endURI")
    val thumbnailPath = listOf("thumbnailURI")
    val unifiedKeyPaths = thumbnailPath + imageGroupTopKeyPaths + imageGroupBottomKeyPaths + imageGroupLeftKeyPaths + imageGroupRightKeyPaths

    val resolvedFrames = this.resolveNestedCategories(source, frameKeyPath, unifiedKeyPaths, null, null)
    if (resolvedFrames != null) {
      IMGLYSetValue(source, frameKeyPath, resolvedFrames)
    }

    // Resolve the overlays.
    val overlayKeyPath = "overlay.items"
    val overlayKeyPaths = listOf("thumbnailURI", "overlayURI")
    val resolvedOverlays = this.resolveNestedCategories(source, overlayKeyPath, overlayKeyPaths, null, null)
    if (resolvedOverlays != null) {
      IMGLYSetValue(source, overlayKeyPath, resolvedOverlays)
    }

    // Resolve the fonts.
    val fontKeyPath = "text.fonts"
    val fontKeyPaths = listOf("fontURI")
    val resolvedFonts = this.resolveNestedCategories(source, fontKeyPath, fontKeyPaths, null, null)
    if (resolvedFonts != null) {
      IMGLYSetValue(source, fontKeyPath, resolvedFonts)
    }

    // Resolve the stickers.
    val stickerCategoryKeyPath = "sticker.categories"
    val stickerCategoryResolvingKeyPaths = listOf("thumbnailURI")
    val stickerKeyPath = "items"
    val stickerResolvingKeyPaths = listOf("thumbnailURI", "stickerURI")

    val resolvedStickerCategories = this.resolveNestedCategories(source, stickerCategoryKeyPath, stickerCategoryResolvingKeyPaths, stickerKeyPath, stickerResolvingKeyPaths)
    if (resolvedStickerCategories != null) {
      IMGLYSetValue(source, stickerCategoryKeyPath, resolvedStickerCategories)
    }

    // Resolve the filters.
    val filterCategoryKeyPath = "filter.categories"
    val filterCategoryResolvingKeyPaths = listOf("thumbnailURI")
    val filterKeyPath = "items"
    val filterResolvingKeyPaths = listOf("lutURI")

    val resolvedFilterCategories = this.resolveNestedCategories(source, filterCategoryKeyPath, filterCategoryResolvingKeyPaths, filterKeyPath, filterResolvingKeyPaths)
    if (resolvedFilterCategories != null) {
      IMGLYSetValue(source, filterCategoryKeyPath, resolvedFilterCategories)
    }
    return source
  }

  /**
   * Wraps an embedded asset.
   *
   * @param source The unresolved *source* of the embedded image.
   * @property resolvedURI The correctly formatted URI as a *String*.
   * @constructor Creates a new instance that holds the information on the asset.
   */
  class EmbeddedAsset(source: String) {

    /** The resolved uri to integrate nto the configuration.*/
    val resolvedURI: String?
      get() = resolveURI()

    /** The unresolved *source* of the embedded image. */
    val source: String = source

    /**
     * Resolves the embedded URI into a valid *String* value.
     * @return Valid URI as *String* if any.
     */
    private fun resolveURI() : String? {
      return if (source.startsWith("/") || source.contains("://") ) {
        source
      } else {
        "asset:///flutter_assets/$source"
      }
    }

  }

  /**
   * Resolves the nested resources which are contained in sub-maps.
   *
   * @param baseSource The source as *MutableMap<String, Any>* from where to resolve all of the resources.
   * @param baseKeyPath The key path as *String* for the location of the sub-map.
   * @param keyPaths The keyPaths as *List<String>* of the resources for all sub-maps.
   * @return The resolved [baseSource] as *MutableMap<String, Any>*
   */
  private fun resolveNestedCategories(baseSource: MutableMap<String, Any>, baseKeyPath: String, keyPaths: List<String>, subKeyPath: String?, subKeyPaths: List<String>?) : MutableList<MutableMap<String, Any>>? {
    val categories = this.resolveCategories(baseSource, baseKeyPath, keyPaths) as? MutableList<MutableMap<String, Any>>
    if (categories != null) {
      if (subKeyPath != null && subKeyPaths != null) {
        categories.forEach { category ->
          val items = this.resolveCategories(category, subKeyPath, subKeyPaths)
          if (items != null) {
            IMGLYSetValue(category, subKeyPath, items)
            val index = categories.indexOfFirst { dict ->
              dict.keys == category.keys
            }
            categories[index] = category
          }
        }
        return categories
      } else {
        return categories
      }
    } else {
      return null
    }
  }

  /**
   * Resolves the nested resources which are contained in sub-maps.
   *
   * @param baseSource The source as *MutableMap<String, Any>* from where to resolve all of the resources.
   * @param baseKeyPath The key path as *String* for the location of the sub-map.
   * @param keyPaths The keyPaths as *List<String>* of the resources for all sub-maps.
   * @return The resolved [baseSource] as *MutableMap<String, Any>*
   */
  private fun resolveCategories(baseSource: MutableMap<String, Any>, baseKeyPath: String, keyPaths: List<String>) : MutableList<MutableMap<String, Any>>? {
    val categories = IMGLYGetValue(baseSource, baseKeyPath) as? MutableList<MutableMap<String, Any>>
    if (categories != null) {
      categories.forEach { category ->
        val resolvedMap = this.resolveNestedAssets(category, keyPaths)
        val index = categories.indexOfFirst { dict ->
          dict.keys == category.keys
        }
        categories[index] = resolvedMap
      }
      return categories
    }
    return null
  }

  /**
   * Resolves the nested resources.
   *
   * @param source The source as *MutableMap<String, Any>* from where to resolve the resources.
   * @param keyPaths The keyPaths as *List<String>* of the resources.
   * @return The resolved [source] as *MutableMap<String, Any>*
   */
  private fun resolveNestedAssets(source: MutableMap<String, Any>, keyPaths: List<String>) : MutableMap<String, Any> {
    keyPaths.forEach { path ->
      val value = IMGLYGetValue(source, path) as? String
      if (value != null) {
        val finalURI = EmbeddedAsset(value).resolvedURI
        if (finalURI != null) {
          IMGLYSetValue(source, path, finalURI)
        }
      }
    }
    return source
  }

  /**
   * Retrieves the value of a given [map] at a given [keyPath].
   *
   * @param map The source map as *MutableMap<String, Any>* from where to retrieve the value.
   * @param keyPath The key path as *String* to the requested value.
   * @return The value as *Any*.
   */
  private fun IMGLYGetValue(map: MutableMap<String, Any>, keyPath: String) : Any? {
    val subBefore = keyPath.substringBefore('.')
    val subAfter = keyPath.substringAfter('.')
    if(!subAfter.isEmpty() && keyPath.contains(".")){
      val dic = map[subBefore] as? MutableMap<String, Any>
      if (dic != null) {
        return IMGLYGetValue(dic, subAfter)
      } else {
        return null
      }
    }else{
      return map[subBefore]
    }
  }

  /**
   * Mutates the value of a given [map] at a the given [keyPath].
   *
   * @param map The source map as *MutableMap<String, Any>* from which to mutate the [value].
   * @param keyPath The key path as *String* to the requested [value].
   * @param value The new value as *Any*.
   * @return The value as *Any*.
   */
  private fun IMGLYSetValue(map: MutableMap<String, Any>, keyPath: String, value: Any) {
    val subBefore = keyPath.substringBefore('.')
    val subAfter = keyPath.substringAfter('.')
    if(!subAfter.isEmpty() && keyPath.contains(".")){
      val dic = map[subBefore] as? MutableMap<String, Any>
      if (dic != null) {
        IMGLYSetValue(dic, subAfter, value)
      } else {
        return
      }
    }else{
      map[subBefore] = value
    }
  }

  /**
   * Converts an *JSONObject* to a *Map<String, Any?>*.
   *
   * @param json The source *JSONObject* to convert.
   * @throws JSONException when there are problems with JSON parsing.
   * @return The [json] converted into a *Map<String, Any?>*.
   */
  @Throws(JSONException::class)
  fun jsonToMap(json: JSONObject): Map<String, Any?> {
    var retMap: Map<String, Any?> = HashMap()
    if (json !== JSONObject.NULL) {
      retMap = toMap(json)
    }
    return retMap
  }

  /**
   * Converts an *JSONObject* to a *Map<String, Any?>*.
   *
   * @param jsonObject The source *JSONObject* to convert.
   * @throws JSONException when there are problems with JSON parsing.
   * @return The [jsonObject] converted into a *Map<String, Any?>*.
   */
  @Throws(JSONException::class)
  private fun toMap(jsonObject: JSONObject): Map<String, Any?> {
    val map: MutableMap<String, Any?> = HashMap()
    jsonObject.keys().forEach { key ->
      var value = jsonObject[key]
      if (value is JSONArray) {
        value = toList(value)
      } else if (value is JSONObject) {
        value = toMap(value)
      }
      map[key] = value
    }
    return map
  }

  /**
   * Converts an *JSONArray* to a *List<Any>*.
   *
   * @param array The source *JSONArray* to convert.
   * @throws JSONException when there are problems with JSON parsing.
   * @return The [array] converted into a *List<Any>*.
   */
  @Throws(JSONException::class)
  private fun toList(array: JSONArray): List<Any> {
    val list: MutableList<Any> = ArrayList()
    for (i in 0 until array.length()) {
      var value = array[i]
      if (value is JSONArray) {
        value = toList(value)
      } else if (value is JSONObject) {
        value = toMap(value)
      }
      list.add(value)
    }
    return list
  }
}