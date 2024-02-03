// Autogenerated from Pigeon (v16.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is IvsPlayerFlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): IvsPlayerFlutterError {
  return IvsPlayerFlutterError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class IvsPlayerFlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class PlayerState(val raw: Int) {
  READY(0),
  BUFFERING(1),
  IDLE(2),
  PLAYING(3),
  ENDED(4),
  ERROR(5);

  companion object {
    fun ofRaw(raw: Int): PlayerState? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface IvsPlayerRequesterToNative {
  fun load(urlString: String)
  fun play()
  fun pause()
  fun clean()

  companion object {
    /** The codec used by IvsPlayerRequesterToNative. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `IvsPlayerRequesterToNative` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: IvsPlayerRequesterToNative?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.ivs_player_plugin.IvsPlayerRequesterToNative.load", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val urlStringArg = args[0] as String
            var wrapped: List<Any?>
            try {
              api.load(urlStringArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.ivs_player_plugin.IvsPlayerRequesterToNative.play", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.play()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.ivs_player_plugin.IvsPlayerRequesterToNative.pause", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.pause()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.ivs_player_plugin.IvsPlayerRequesterToNative.clean", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.clean()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class IvsPlayerRequesterToFlutter(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by IvsPlayerRequesterToFlutter. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
  }
  fun didChangeState(stateArg: PlayerState, callback: (Result<Unit>) -> Unit)
{
    val channelName = "dev.flutter.pigeon.ivs_player_plugin.IvsPlayerRequesterToFlutter.didChangeState"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(stateArg.raw)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(IvsPlayerFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun didChangeDuration(durationArg: Double, callback: (Result<Unit>) -> Unit)
{
    val channelName = "dev.flutter.pigeon.ivs_player_plugin.IvsPlayerRequesterToFlutter.didChangeDuration"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(durationArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(IvsPlayerFlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}
