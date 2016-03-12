import CSFML 
func seconds(amount : Float) -> Time {return sfSeconds(amount)}
func milliseconds(amount : Int32) -> Time {return sfMilliseconds(amount)}
func microseconds(amount : Int64) -> Time {return sfMicroseconds(amount)}
func sleep(duration : Time) -> () {return sfSleep(duration)}
class ConvexShape : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfConvexShape_create())}
func copy() -> ConvexShape {return ConvexShape(owned:sfConvexShape_copy(self.ptr))}
deinit {if owned {sfConvexShape_destroy(self.ptr)}}
func move(offset : Vector2f) -> () {return sfConvexShape_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfConvexShape_rotate(self.ptr, angle)}
func scale(factors : Vector2f) -> () {return sfConvexShape_scale(self.ptr, factors)}
func setTexture(texture : Texture, resetRect : Bool) -> () {return sfConvexShape_setTexture(self.ptr, texture.ptr, Int32(resetRect))}
func getPoint(index : Int) -> Vector2f {return sfConvexShape_getPoint(self.ptr, index)}
func setPoint(index : Int, point : Vector2f) -> () {return sfConvexShape_setPoint(self.ptr, index, point)}
var position : Vector2f {get {return sfConvexShape_getPosition(self.ptr)} set(position) {return sfConvexShape_setPosition(self.ptr, position)} }
var texture : Texture {get {return Texture(unowned:sfConvexShape_getTexture(self.ptr))!} }
var rotation : Float {get {return sfConvexShape_getRotation(self.ptr)} set(angle) {return sfConvexShape_setRotation(self.ptr, angle)} }
var outlineColor : Color {get {return sfConvexShape_getOutlineColor(self.ptr)} set(color) {return sfConvexShape_setOutlineColor(self.ptr, color)} }
var pointCount : Int {get {return sfConvexShape_getPointCount(self.ptr)} set(count) {return sfConvexShape_setPointCount(self.ptr, count)} }
var scale : Vector2f {get {return sfConvexShape_getScale(self.ptr)} set(scale) {return sfConvexShape_setScale(self.ptr, scale)} }
var origin : Vector2f {get {return sfConvexShape_getOrigin(self.ptr)} set(origin) {return sfConvexShape_setOrigin(self.ptr, origin)} }
var fillColor : Color {get {return sfConvexShape_getFillColor(self.ptr)} set(color) {return sfConvexShape_setFillColor(self.ptr, color)} }
var transform : Transform {get {return sfConvexShape_getTransform(self.ptr)} }
var globalBounds : FloatRect {get {return sfConvexShape_getGlobalBounds(self.ptr)} }
var localBounds : FloatRect {get {return sfConvexShape_getLocalBounds(self.ptr)} }
var outlineThickness : Float {get {return sfConvexShape_getOutlineThickness(self.ptr)} set(thickness) {return sfConvexShape_setOutlineThickness(self.ptr, thickness)} }
var inverseTransform : Transform {get {return sfConvexShape_getInverseTransform(self.ptr)} }
var textureRect : IntRect {get {return sfConvexShape_getTextureRect(self.ptr)} set(rect) {return sfConvexShape_setTextureRect(self.ptr, rect)} }
 }
enum BlendFactor : UInt32 { 
case Zero = 0
case One = 1
case SrcColor = 2
case OneMinusSrcColor = 3
case DstColor = 4
case OneMinusDstColor = 5
case SrcAlpha = 6
case OneMinusSrcAlpha = 7
case DstAlpha = 8
case OneMinusDstAlpha = 9
 }
class Text : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfText_create())}
func copy() -> Text {return Text(owned:sfText_copy(self.ptr))}
deinit {if owned {sfText_destroy(self.ptr)}}
func move(offset : Vector2f) -> () {return sfText_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfText_rotate(self.ptr, angle)}
func scale(factors : Vector2f) -> () {return sfText_scale(self.ptr, factors)}
func findCharacterPos(index : Int) -> Vector2f {return sfText_findCharacterPos(self.ptr, index)}
var string : String {get {return String(sfText_getString(self.ptr))} set(string) {return sfText_setString(self.ptr, string)} }
var position : Vector2f {get {return sfText_getPosition(self.ptr)} set(position) {return sfText_setPosition(self.ptr, position)} }
var rotation : Float {get {return sfText_getRotation(self.ptr)} set(angle) {return sfText_setRotation(self.ptr, angle)} }
var scale : Vector2f {get {return sfText_getScale(self.ptr)} set(scale) {return sfText_setScale(self.ptr, scale)} }
var unicodeString : UnsafePointer<UInt32> {get {return sfText_getUnicodeString(self.ptr)} set(string) {return sfText_setUnicodeString(self.ptr, string)} }
var origin : Vector2f {get {return sfText_getOrigin(self.ptr)} set(origin) {return sfText_setOrigin(self.ptr, origin)} }
var font : Font {get {return Font(unowned:sfText_getFont(self.ptr))!} set(font) {return sfText_setFont(self.ptr, font.ptr)} }
var transform : Transform {get {return sfText_getTransform(self.ptr)} }
var style : UInt32 {get {return sfText_getStyle(self.ptr)} set(style) {return sfText_setStyle(self.ptr, style)} }
var characterSize : UInt32 {get {return sfText_getCharacterSize(self.ptr)} set(size) {return sfText_setCharacterSize(self.ptr, size)} }
var localBounds : FloatRect {get {return sfText_getLocalBounds(self.ptr)} }
var globalBounds : FloatRect {get {return sfText_getGlobalBounds(self.ptr)} }
var inverseTransform : Transform {get {return sfText_getInverseTransform(self.ptr)} }
var color : Color {get {return sfText_getColor(self.ptr)} set(color) {return sfText_setColor(self.ptr, color)} }
 }
class SoundRecorder : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(onStart : sfSoundRecorderStartCallback, onProcess : sfSoundRecorderProcessCallback, onStop : sfSoundRecorderStopCallback, userData : UnsafeMutablePointer<()>) {super.init(owned:sfSoundRecorder_create(onStart, onProcess, onStop, userData))}
deinit {if owned {sfSoundRecorder_destroy(self.ptr)}}
func start(sampleRate : UInt32) -> Bool {return Bool(sfSoundRecorder_start(self.ptr, sampleRate))}
func stop() -> () {return sfSoundRecorder_stop(self.ptr)}
func setProcessingInterval(interval : Time) -> () {return sfSoundRecorder_setProcessingInterval(self.ptr, interval)}
static func getAvailableDevices(count : UnsafeMutablePointer<Int>) -> UnsafeMutablePointer<UnsafePointer<Int8>> {return sfSoundRecorder_getAvailableDevices(count)}
func setDevice(name : String) -> Bool {return Bool(sfSoundRecorder_setDevice(self.ptr, name))}
var device : String {get {return String(sfSoundRecorder_getDevice(self.ptr))} }
var sampleRate : UInt32 {get {return sfSoundRecorder_getSampleRate(self.ptr)} }
var defaultDevice : String {get {return String(sfSoundRecorder_getDefaultDevice())} }
var isAvailable : Bool {get {return Bool(sfSoundRecorder_isAvailable())} }
 }
class UdpSocket : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfUdpSocket_create())}
deinit {if owned {sfUdpSocket_destroy(self.ptr)}}
func setBlocking(blocking : Bool) -> () {return sfUdpSocket_setBlocking(self.ptr, Int32(blocking))}
func bind(port : UInt16) -> SocketStatus {return SocketStatus(rawValue:sfUdpSocket_bind(self.ptr, port).rawValue)!}
func unbind() -> () {return sfUdpSocket_unbind(self.ptr)}
func send(data : UnsafePointer<()>, size : Int, address : IpAddress, port : UInt16) -> SocketStatus {return SocketStatus(rawValue:sfUdpSocket_send(self.ptr, data, size, address, port).rawValue)!}
func receive(data : UnsafeMutablePointer<()>, maxSize : Int, sizeReceived : UnsafeMutablePointer<Int>, inout address : IpAddress, port : UnsafeMutablePointer<UInt16>) -> SocketStatus {return SocketStatus(rawValue:sfUdpSocket_receive(self.ptr, data, maxSize, sizeReceived, &address, port).rawValue)!}
func sendPacket(packet : Packet, address : IpAddress, port : UInt16) -> SocketStatus {return SocketStatus(rawValue:sfUdpSocket_sendPacket(self.ptr, packet.ptr, address, port).rawValue)!}
func receivePacket(packet : Packet, inout address : IpAddress, port : UnsafeMutablePointer<UInt16>) -> SocketStatus {return SocketStatus(rawValue:sfUdpSocket_receivePacket(self.ptr, packet.ptr, &address, port).rawValue)!}
static func maxDatagramSize() -> UInt32 {return sfUdpSocket_maxDatagramSize()}
var isBlocking : Bool {get {return Bool(sfUdpSocket_isBlocking(self.ptr))} }
var localPort : UInt16 {get {return sfUdpSocket_getLocalPort(self.ptr)} }
 }
enum MouseWheel : UInt32 { 
case VerticalWheel = 0
case HorizontalWheel = 1
 }
enum KeyCode : Int32 { 
case Unknown = -1
case A = 0
case B = 1
case C = 2
case D = 3
case E = 4
case F = 5
case G = 6
case H = 7
case I = 8
case J = 9
case K = 10
case L = 11
case M = 12
case N = 13
case O = 14
case P = 15
case Q = 16
case R = 17
case S = 18
case T = 19
case U = 20
case V = 21
case W = 22
case X = 23
case Y = 24
case Z = 25
case Num0 = 26
case Num1 = 27
case Num2 = 28
case Num3 = 29
case Num4 = 30
case Num5 = 31
case Num6 = 32
case Num7 = 33
case Num8 = 34
case Num9 = 35
case Escape = 36
case LControl = 37
case LShift = 38
case LAlt = 39
case LSystem = 40
case RControl = 41
case RShift = 42
case RAlt = 43
case RSystem = 44
case Menu = 45
case LBracket = 46
case RBracket = 47
case SemiColon = 48
case Comma = 49
case Period = 50
case Quote = 51
case Slash = 52
case BackSlash = 53
case Tilde = 54
case Equal = 55
case Dash = 56
case Space = 57
case Return = 58
case Back = 59
case Tab = 60
case PageUp = 61
case PageDown = 62
case End = 63
case Home = 64
case Insert = 65
case Delete = 66
case Add = 67
case Subtract = 68
case Multiply = 69
case Divide = 70
case Left = 71
case Right = 72
case Up = 73
case Down = 74
case Numpad0 = 75
case Numpad1 = 76
case Numpad2 = 77
case Numpad3 = 78
case Numpad4 = 79
case Numpad5 = 80
case Numpad6 = 81
case Numpad7 = 82
case Numpad8 = 83
case Numpad9 = 84
case F1 = 85
case F2 = 86
case F3 = 87
case F4 = 88
case F5 = 89
case F6 = 90
case F7 = 91
case F8 = 92
case F9 = 93
case F10 = 94
case F11 = 95
case F12 = 96
case F13 = 97
case F14 = 98
case F15 = 99
case Pause = 100
case Count = 101
 }
class RenderTexture : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(width : UInt32, height : UInt32, depthBuffer : Bool) {super.init(owned:sfRenderTexture_create(width, height, Int32(depthBuffer)))}
deinit {if owned {sfRenderTexture_destroy(self.ptr)}}
func setActive(active : Bool) -> Bool {return Bool(sfRenderTexture_setActive(self.ptr, Int32(active)))}
func display() -> () {return sfRenderTexture_display(self.ptr)}
func clear(color : Color) -> () {return sfRenderTexture_clear(self.ptr, color)}
func getViewport(view : View) -> IntRect {return sfRenderTexture_getViewport(self.ptr, view.ptr)}
func mapPixelToCoords(point : Vector2i, view : View) -> Vector2f {return sfRenderTexture_mapPixelToCoords(self.ptr, point, view.ptr)}
func mapCoordsToPixel(point : Vector2f, view : View) -> Vector2i {return sfRenderTexture_mapCoordsToPixel(self.ptr, point, view.ptr)}
func drawSprite(object : Sprite, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawSprite(self.ptr, object.ptr, pointer(&states))}
func drawText(object : Text, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawText(self.ptr, object.ptr, pointer(&states))}
func drawShape(object : Shape, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawShape(self.ptr, object.ptr, pointer(&states))}
func drawCircleShape(object : CircleShape, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawCircleShape(self.ptr, object.ptr, pointer(&states))}
func drawConvexShape(object : ConvexShape, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawConvexShape(self.ptr, object.ptr, pointer(&states))}
func drawRectangleShape(object : RectangleShape, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawRectangleShape(self.ptr, object.ptr, pointer(&states))}
func drawVertexArray(object : VertexArray, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawVertexArray(self.ptr, object.ptr, pointer(&states))}
func drawPrimitives(vertices : UnsafePointer<sfVertex>, vertexCount : Int, type : PrimitiveType, states : RenderStates?) -> () {var states=states;return sfRenderTexture_drawPrimitives(self.ptr, vertices, vertexCount, sfPrimitiveType(rawValue:type.rawValue), pointer(&states))}
func pushGLStates() -> () {return sfRenderTexture_pushGLStates(self.ptr)}
func popGLStates() -> () {return sfRenderTexture_popGLStates(self.ptr)}
func resetGLStates() -> () {return sfRenderTexture_resetGLStates(self.ptr)}
func setSmooth(smooth : Bool) -> () {return sfRenderTexture_setSmooth(self.ptr, Int32(smooth))}
func setRepeated(repeated : Bool) -> () {return sfRenderTexture_setRepeated(self.ptr, Int32(repeated))}
var view : View {get {return View(unowned:sfRenderTexture_getView(self.ptr))!} set(view) {return sfRenderTexture_setView(self.ptr, view.ptr)} }
var texture : Texture {get {return Texture(unowned:sfRenderTexture_getTexture(self.ptr))!} }
var defaultView : View {get {return View(unowned:sfRenderTexture_getDefaultView(self.ptr))!} }
var isRepeated : Bool {get {return Bool(sfRenderTexture_isRepeated(self.ptr))} }
var size : Vector2u {get {return sfRenderTexture_getSize(self.ptr)} }
var isSmooth : Bool {get {return Bool(sfRenderTexture_isSmooth(self.ptr))} }
 }
class Window : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(mode : VideoMode, title : String, style : UInt32, settings : ContextSettings?) {var settings=settings;super.init(owned:sfWindow_create(mode, title, style, pointer(&settings)))}
init(mode : VideoMode, title : UnsafePointer<UInt32>, style : UInt32, settings : ContextSettings?) {var settings=settings;super.init(owned:sfWindow_createUnicode(mode, title, style, pointer(&settings)))}
init(handle : UnsafeMutablePointer<()>, settings : ContextSettings?) {var settings=settings;super.init(owned:sfWindow_createFromHandle(handle, pointer(&settings)))}
deinit {if owned {sfWindow_destroy(self.ptr)}}
func close() -> () {return sfWindow_close(self.ptr)}
func pollEvent(inout event : Event) -> Bool {return Bool(sfWindow_pollEvent(self.ptr, &event))}
func waitEvent(inout event : Event) -> Bool {return Bool(sfWindow_waitEvent(self.ptr, &event))}
func setTitle(title : String) -> () {return sfWindow_setTitle(self.ptr, title)}
func setUnicodeTitle(title : UnsafePointer<UInt32>) -> () {return sfWindow_setUnicodeTitle(self.ptr, title)}
func setIcon(width : UInt32, height : UInt32, pixels : UnsafePointer<UInt8>) -> () {return sfWindow_setIcon(self.ptr, width, height, pixels)}
func setVisible(visible : Bool) -> () {return sfWindow_setVisible(self.ptr, Int32(visible))}
func setMouseCursorVisible(visible : Bool) -> () {return sfWindow_setMouseCursorVisible(self.ptr, Int32(visible))}
func setVerticalSyncEnabled(enabled : Bool) -> () {return sfWindow_setVerticalSyncEnabled(self.ptr, Int32(enabled))}
func setKeyRepeatEnabled(enabled : Bool) -> () {return sfWindow_setKeyRepeatEnabled(self.ptr, Int32(enabled))}
func setActive(active : Bool) -> Bool {return Bool(sfWindow_setActive(self.ptr, Int32(active)))}
func requestFocus() -> () {return sfWindow_requestFocus(self.ptr)}
func hasFocus() -> Bool {return Bool(sfWindow_hasFocus(self.ptr))}
func display() -> () {return sfWindow_display(self.ptr)}
func setFramerateLimit(limit : UInt32) -> () {return sfWindow_setFramerateLimit(self.ptr, limit)}
func setJoystickThreshold(threshold : Float) -> () {return sfWindow_setJoystickThreshold(self.ptr, threshold)}
var position : Vector2i {get {return sfWindow_getPosition(self.ptr)} set(position) {return sfWindow_setPosition(self.ptr, position)} }
var isOpen : Bool {get {return Bool(sfWindow_isOpen(self.ptr))} }
var size : Vector2u {get {return sfWindow_getSize(self.ptr)} set(size) {return sfWindow_setSize(self.ptr, size)} }
var systemHandle : UnsafeMutablePointer<()> {get {return sfWindow_getSystemHandle(self.ptr)} }
var settings : ContextSettings {get {return sfWindow_getSettings(self.ptr)} }
 }
typealias InputStream = sfInputStream
extension InputStream { 

 }
typealias TextEvent = sfTextEvent
extension TextEvent { 

 }
class CircleShape : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfCircleShape_create())}
func copy() -> CircleShape {return CircleShape(owned:sfCircleShape_copy(self.ptr))}
deinit {if owned {sfCircleShape_destroy(self.ptr)}}
func move(offset : Vector2f) -> () {return sfCircleShape_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfCircleShape_rotate(self.ptr, angle)}
func scale(factors : Vector2f) -> () {return sfCircleShape_scale(self.ptr, factors)}
func setTexture(texture : Texture, resetRect : Bool) -> () {return sfCircleShape_setTexture(self.ptr, texture.ptr, Int32(resetRect))}
func getPoint(index : Int) -> Vector2f {return sfCircleShape_getPoint(self.ptr, index)}
var position : Vector2f {get {return sfCircleShape_getPosition(self.ptr)} set(position) {return sfCircleShape_setPosition(self.ptr, position)} }
var texture : Texture {get {return Texture(unowned:sfCircleShape_getTexture(self.ptr))!} }
var rotation : Float {get {return sfCircleShape_getRotation(self.ptr)} set(angle) {return sfCircleShape_setRotation(self.ptr, angle)} }
var outlineColor : Color {get {return sfCircleShape_getOutlineColor(self.ptr)} set(color) {return sfCircleShape_setOutlineColor(self.ptr, color)} }
var pointCount : Int {get {return sfCircleShape_getPointCount(self.ptr)} set(count) {return sfCircleShape_setPointCount(self.ptr, count)} }
var scale : Vector2f {get {return sfCircleShape_getScale(self.ptr)} set(scale) {return sfCircleShape_setScale(self.ptr, scale)} }
var radius : Float {get {return sfCircleShape_getRadius(self.ptr)} set(radius) {return sfCircleShape_setRadius(self.ptr, radius)} }
var origin : Vector2f {get {return sfCircleShape_getOrigin(self.ptr)} set(origin) {return sfCircleShape_setOrigin(self.ptr, origin)} }
var fillColor : Color {get {return sfCircleShape_getFillColor(self.ptr)} set(color) {return sfCircleShape_setFillColor(self.ptr, color)} }
var transform : Transform {get {return sfCircleShape_getTransform(self.ptr)} }
var globalBounds : FloatRect {get {return sfCircleShape_getGlobalBounds(self.ptr)} }
var localBounds : FloatRect {get {return sfCircleShape_getLocalBounds(self.ptr)} }
var outlineThickness : Float {get {return sfCircleShape_getOutlineThickness(self.ptr)} set(thickness) {return sfCircleShape_setOutlineThickness(self.ptr, thickness)} }
var inverseTransform : Transform {get {return sfCircleShape_getInverseTransform(self.ptr)} }
var textureRect : IntRect {get {return sfCircleShape_getTextureRect(self.ptr)} set(rect) {return sfCircleShape_setTextureRect(self.ptr, rect)} }
 }
class RectangleShape : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfRectangleShape_create())}
func copy() -> RectangleShape {return RectangleShape(owned:sfRectangleShape_copy(self.ptr))}
deinit {if owned {sfRectangleShape_destroy(self.ptr)}}
func move(offset : Vector2f) -> () {return sfRectangleShape_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfRectangleShape_rotate(self.ptr, angle)}
func scale(factors : Vector2f) -> () {return sfRectangleShape_scale(self.ptr, factors)}
func setTexture(texture : Texture, resetRect : Bool) -> () {return sfRectangleShape_setTexture(self.ptr, texture.ptr, Int32(resetRect))}
func getPoint(index : Int) -> Vector2f {return sfRectangleShape_getPoint(self.ptr, index)}
var position : Vector2f {get {return sfRectangleShape_getPosition(self.ptr)} set(position) {return sfRectangleShape_setPosition(self.ptr, position)} }
var texture : Texture {get {return Texture(unowned:sfRectangleShape_getTexture(self.ptr))!} }
var rotation : Float {get {return sfRectangleShape_getRotation(self.ptr)} set(angle) {return sfRectangleShape_setRotation(self.ptr, angle)} }
var outlineColor : Color {get {return sfRectangleShape_getOutlineColor(self.ptr)} set(color) {return sfRectangleShape_setOutlineColor(self.ptr, color)} }
var pointCount : Int {get {return sfRectangleShape_getPointCount(self.ptr)} }
var scale : Vector2f {get {return sfRectangleShape_getScale(self.ptr)} set(scale) {return sfRectangleShape_setScale(self.ptr, scale)} }
var origin : Vector2f {get {return sfRectangleShape_getOrigin(self.ptr)} set(origin) {return sfRectangleShape_setOrigin(self.ptr, origin)} }
var fillColor : Color {get {return sfRectangleShape_getFillColor(self.ptr)} set(color) {return sfRectangleShape_setFillColor(self.ptr, color)} }
var transform : Transform {get {return sfRectangleShape_getTransform(self.ptr)} }
var globalBounds : FloatRect {get {return sfRectangleShape_getGlobalBounds(self.ptr)} }
var localBounds : FloatRect {get {return sfRectangleShape_getLocalBounds(self.ptr)} }
var outlineThickness : Float {get {return sfRectangleShape_getOutlineThickness(self.ptr)} set(thickness) {return sfRectangleShape_setOutlineThickness(self.ptr, thickness)} }
var size : Vector2f {get {return sfRectangleShape_getSize(self.ptr)} set(size) {return sfRectangleShape_setSize(self.ptr, size)} }
var inverseTransform : Transform {get {return sfRectangleShape_getInverseTransform(self.ptr)} }
var textureRect : IntRect {get {return sfRectangleShape_getTextureRect(self.ptr)} set(rect) {return sfRectangleShape_setTextureRect(self.ptr, rect)} }
 }
class FtpDirectoryResponse : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
deinit {if owned {sfFtpDirectoryResponse_destroy(self.ptr)}}
var status : FtpStatus {get {return FtpStatus(rawValue:sfFtpDirectoryResponse_getStatus(self.ptr).rawValue)!} }
var isOk : Bool {get {return Bool(sfFtpDirectoryResponse_isOk(self.ptr))} }
var directory : String {get {return String(sfFtpDirectoryResponse_getDirectory(self.ptr))} }
var message : String {get {return String(sfFtpDirectoryResponse_getMessage(self.ptr))} }
 }
enum JoystickAxis : UInt32 { 
case X = 0
case Y = 1
case Z = 2
case R = 3
case U = 4
case V = 5
case PovX = 6
case PovY = 7
 }
typealias KeyEvent = sfKeyEvent
extension KeyEvent { 

 }
typealias ContextSettings = sfContextSettings
extension ContextSettings { 

 }
class Thread : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(function : @convention(c) (UnsafeMutablePointer<()>) -> (()), userData : UnsafeMutablePointer<()>) {super.init(owned:sfThread_create(function, userData))}
deinit {if owned {sfThread_destroy(self.ptr)}}
func launch() -> () {return sfThread_launch(self.ptr)}
func wait() -> () {return sfThread_wait(self.ptr)}
func terminate() -> () {return sfThread_terminate(self.ptr)}
 }
class VertexArray : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfVertexArray_create())}
func copy() -> VertexArray {return VertexArray(owned:sfVertexArray_copy(self.ptr))}
deinit {if owned {sfVertexArray_destroy(self.ptr)}}
func getVertex(index : Int) -> UnsafeMutablePointer<sfVertex> {return sfVertexArray_getVertex(self.ptr, index)}
func clear() -> () {return sfVertexArray_clear(self.ptr)}
func resize(vertexCount : Int) -> () {return sfVertexArray_resize(self.ptr, vertexCount)}
func append(vertex : Vertex) -> () {return sfVertexArray_append(self.ptr, vertex)}
var bounds : FloatRect {get {return sfVertexArray_getBounds(self.ptr)} }
var vertexCount : Int {get {return sfVertexArray_getVertexCount(self.ptr)} }
var primitiveType : PrimitiveType {get {return PrimitiveType(rawValue:sfVertexArray_getPrimitiveType(self.ptr).rawValue)!} set(type) {return sfVertexArray_setPrimitiveType(self.ptr, sfPrimitiveType(rawValue:type.rawValue))} }
 }
typealias JoystickConnectEvent = sfJoystickConnectEvent
extension JoystickConnectEvent { 

 }
typealias Vertex = sfVertex
extension Vertex { 

 }
enum SoundStatus : UInt32 { 
case Stopped = 0
case Paused = 1
case Playing = 2
 }
class TcpListener : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfTcpListener_create())}
deinit {if owned {sfTcpListener_destroy(self.ptr)}}
func setBlocking(blocking : Bool) -> () {return sfTcpListener_setBlocking(self.ptr, Int32(blocking))}
func listen(port : UInt16) -> SocketStatus {return SocketStatus(rawValue:sfTcpListener_listen(self.ptr, port).rawValue)!}
var isBlocking : Bool {get {return Bool(sfTcpListener_isBlocking(self.ptr))} }
var localPort : UInt16 {get {return sfTcpListener_getLocalPort(self.ptr)} }
 }
enum BlendEquation : UInt32 { 
case Add = 0
case Subtract = 1
 }
typealias JoystickButtonEvent = sfJoystickButtonEvent
extension JoystickButtonEvent { 

 }
typealias JoystickIdentification = sfJoystickIdentification
extension JoystickIdentification { 

 }
class Sound : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfSound_create())}
func copy() -> Sound {return Sound(owned:sfSound_copy(self.ptr))}
deinit {if owned {sfSound_destroy(self.ptr)}}
func play() -> () {return sfSound_play(self.ptr)}
func pause() -> () {return sfSound_pause(self.ptr)}
func stop() -> () {return sfSound_stop(self.ptr)}
func setRelativeToListener(relative : Bool) -> () {return sfSound_setRelativeToListener(self.ptr, Int32(relative))}
var loop : Bool {get {return Bool(sfSound_getLoop(self.ptr))} set(loop) {return sfSound_setLoop(self.ptr, Int32(loop))} }
var volume : Float {get {return sfSound_getVolume(self.ptr)} set(volume) {return sfSound_setVolume(self.ptr, volume)} }
var position : Vector3f {get {return sfSound_getPosition(self.ptr)} set(position) {return sfSound_setPosition(self.ptr, position)} }
var minDistance : Float {get {return sfSound_getMinDistance(self.ptr)} set(distance) {return sfSound_setMinDistance(self.ptr, distance)} }
var buffer : SoundBuffer {get {return SoundBuffer(unowned:sfSound_getBuffer(self.ptr))!} set(buffer) {return sfSound_setBuffer(self.ptr, buffer.ptr)} }
var isRelativeToListener : Bool {get {return Bool(sfSound_isRelativeToListener(self.ptr))} }
var status : SoundStatus {get {return SoundStatus(rawValue:sfSound_getStatus(self.ptr).rawValue)!} }
var pitch : Float {get {return sfSound_getPitch(self.ptr)} set(pitch) {return sfSound_setPitch(self.ptr, pitch)} }
var attenuation : Float {get {return sfSound_getAttenuation(self.ptr)} set(attenuation) {return sfSound_setAttenuation(self.ptr, attenuation)} }
var playingOffset : Time {get {return sfSound_getPlayingOffset(self.ptr)} set(timeOffset) {return sfSound_setPlayingOffset(self.ptr, timeOffset)} }
 }
class Clock : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfClock_create())}
func copy() -> Clock {return Clock(owned:sfClock_copy(self.ptr))}
deinit {if owned {sfClock_destroy(self.ptr)}}
func restart() -> Time {return sfClock_restart(self.ptr)}
var elapsedTime : Time {get {return sfClock_getElapsedTime(self.ptr)} }
 }
typealias SoundStreamChunk = sfSoundStreamChunk
extension SoundStreamChunk { 

 }
class Sprite : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfSprite_create())}
func copy() -> Sprite {return Sprite(owned:sfSprite_copy(self.ptr))}
deinit {if owned {sfSprite_destroy(self.ptr)}}
func move(offset : Vector2f) -> () {return sfSprite_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfSprite_rotate(self.ptr, angle)}
func scale(factors : Vector2f) -> () {return sfSprite_scale(self.ptr, factors)}
func setTexture(texture : Texture, resetRect : Bool) -> () {return sfSprite_setTexture(self.ptr, texture.ptr, Int32(resetRect))}
var globalBounds : FloatRect {get {return sfSprite_getGlobalBounds(self.ptr)} }
var localBounds : FloatRect {get {return sfSprite_getLocalBounds(self.ptr)} }
var position : Vector2f {get {return sfSprite_getPosition(self.ptr)} set(position) {return sfSprite_setPosition(self.ptr, position)} }
var texture : Texture {get {return Texture(unowned:sfSprite_getTexture(self.ptr))!} }
var rotation : Float {get {return sfSprite_getRotation(self.ptr)} set(angle) {return sfSprite_setRotation(self.ptr, angle)} }
var scale : Vector2f {get {return sfSprite_getScale(self.ptr)} set(scale) {return sfSprite_setScale(self.ptr, scale)} }
var origin : Vector2f {get {return sfSprite_getOrigin(self.ptr)} set(origin) {return sfSprite_setOrigin(self.ptr, origin)} }
var inverseTransform : Transform {get {return sfSprite_getInverseTransform(self.ptr)} }
var textureRect : IntRect {get {return sfSprite_getTextureRect(self.ptr)} set(rectangle) {return sfSprite_setTextureRect(self.ptr, rectangle)} }
var color : Color {get {return sfSprite_getColor(self.ptr)} set(color) {return sfSprite_setColor(self.ptr, color)} }
var transform : Transform {get {return sfSprite_getTransform(self.ptr)} }
 }
typealias TouchEvent = sfTouchEvent
extension TouchEvent { 

 }
class Image : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(width : UInt32, height : UInt32) {super.init(owned:sfImage_create(width, height))}
init(width : UInt32, height : UInt32, color : Color) {super.init(owned:sfImage_createFromColor(width, height, color))}
init(width : UInt32, height : UInt32, pixels : UnsafePointer<UInt8>) {super.init(owned:sfImage_createFromPixels(width, height, pixels))}
init(filename : String) {super.init(owned:sfImage_createFromFile(filename))}
init(data : UnsafePointer<()>, size : Int) {super.init(owned:sfImage_createFromMemory(data, size))}
init(inout stream : InputStream) {super.init(owned:sfImage_createFromStream(&stream))}
func copy() -> Image {return Image(owned:sfImage_copy(self.ptr))}
deinit {if owned {sfImage_destroy(self.ptr)}}
func saveToFile(filename : String) -> Bool {return Bool(sfImage_saveToFile(self.ptr, filename))}
func createMaskFromColor(color : Color, alpha : UInt8) -> () {return sfImage_createMaskFromColor(self.ptr, color, alpha)}
func copyImage(source : Image, destX : UInt32, destY : UInt32, sourceRect : IntRect, applyAlpha : Bool) -> () {return sfImage_copyImage(self.ptr, source.ptr, destX, destY, sourceRect, Int32(applyAlpha))}
func setPixel(x : UInt32, y : UInt32, color : Color) -> () {return sfImage_setPixel(self.ptr, x, y, color)}
func getPixel(x : UInt32, y : UInt32) -> Color {return sfImage_getPixel(self.ptr, x, y)}
func flipHorizontally() -> () {return sfImage_flipHorizontally(self.ptr)}
func flipVertically() -> () {return sfImage_flipVertically(self.ptr)}
var size : Vector2u {get {return sfImage_getSize(self.ptr)} }
var pixelsPtr : UnsafePointer<UInt8> {get {return sfImage_getPixelsPtr(self.ptr)} }
 }
class Shader : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(vertexShaderFilename : String, fragmentShaderFilename : String) {super.init(owned:sfShader_createFromFile(vertexShaderFilename, fragmentShaderFilename))}
init(vertexShader : String, fragmentShader : String) {super.init(owned:sfShader_createFromMemory(vertexShader, fragmentShader))}
init(inout vertexShaderStream : InputStream, inout fragmentShaderStream : InputStream) {super.init(owned:sfShader_createFromStream(&vertexShaderStream, &fragmentShaderStream))}
deinit {if owned {sfShader_destroy(self.ptr)}}
func setFloatParameter(name : String, x : Float) -> () {return sfShader_setFloatParameter(self.ptr, name, x)}
func setFloat2Parameter(name : String, x : Float, y : Float) -> () {return sfShader_setFloat2Parameter(self.ptr, name, x, y)}
func setFloat3Parameter(name : String, x : Float, y : Float, z : Float) -> () {return sfShader_setFloat3Parameter(self.ptr, name, x, y, z)}
func setFloat4Parameter(name : String, x : Float, y : Float, z : Float, w : Float) -> () {return sfShader_setFloat4Parameter(self.ptr, name, x, y, z, w)}
func setVector2Parameter(name : String, vector : Vector2f) -> () {return sfShader_setVector2Parameter(self.ptr, name, vector)}
func setVector3Parameter(name : String, vector : Vector3f) -> () {return sfShader_setVector3Parameter(self.ptr, name, vector)}
func setColorParameter(name : String, color : Color) -> () {return sfShader_setColorParameter(self.ptr, name, color)}
func setTransformParameter(name : String, transform : Transform) -> () {return sfShader_setTransformParameter(self.ptr, name, transform)}
func setTextureParameter(name : String, texture : Texture) -> () {return sfShader_setTextureParameter(self.ptr, name, texture.ptr)}
func setCurrentTextureParameter(name : String) -> () {return sfShader_setCurrentTextureParameter(self.ptr, name)}
func bind() -> () {return sfShader_bind(self.ptr)}
var isAvailable : Bool {get {return Bool(sfShader_isAvailable())} }
var nativeHandle : UInt32 {get {return sfShader_getNativeHandle(self.ptr)} }
 }
class Ftp : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfFtp_create())}
deinit {if owned {sfFtp_destroy(self.ptr)}}
func connect(server : IpAddress, port : UInt16, timeout : Time) -> FtpResponse {return FtpResponse(unowned:sfFtp_connect(self.ptr, server, port, timeout))!}
func loginAnonymous() -> FtpResponse {return FtpResponse(unowned:sfFtp_loginAnonymous(self.ptr))!}
func login(userName : String, password : String) -> FtpResponse {return FtpResponse(unowned:sfFtp_login(self.ptr, userName, password))!}
func disconnect() -> FtpResponse {return FtpResponse(unowned:sfFtp_disconnect(self.ptr))!}
func keepAlive() -> FtpResponse {return FtpResponse(unowned:sfFtp_keepAlive(self.ptr))!}
func getDirectoryListing(directory : String) -> FtpListingResponse {return FtpListingResponse(unowned:sfFtp_getDirectoryListing(self.ptr, directory))!}
func changeDirectory(directory : String) -> FtpResponse {return FtpResponse(unowned:sfFtp_changeDirectory(self.ptr, directory))!}
func parentDirectory() -> FtpResponse {return FtpResponse(unowned:sfFtp_parentDirectory(self.ptr))!}
init(ftp : Ftp, name : String) {super.init(owned:sfFtp_createDirectory(ftp.ptr, name))}
func deleteDirectory(name : String) -> FtpResponse {return FtpResponse(unowned:sfFtp_deleteDirectory(self.ptr, name))!}
func renameFile(file : String, newName : String) -> FtpResponse {return FtpResponse(unowned:sfFtp_renameFile(self.ptr, file, newName))!}
func deleteFile(name : String) -> FtpResponse {return FtpResponse(unowned:sfFtp_deleteFile(self.ptr, name))!}
func download(distantFile : String, destPath : String, mode : FtpTransferMode) -> FtpResponse {return FtpResponse(unowned:sfFtp_download(self.ptr, distantFile, destPath, sfFtpTransferMode(rawValue:mode.rawValue)))!}
func upload(localFile : String, destPath : String, mode : FtpTransferMode) -> FtpResponse {return FtpResponse(unowned:sfFtp_upload(self.ptr, localFile, destPath, sfFtpTransferMode(rawValue:mode.rawValue)))!}
var workingDirectory : FtpDirectoryResponse {get {return FtpDirectoryResponse(unowned:sfFtp_getWorkingDirectory(self.ptr))!} }
 }
enum SensorType : UInt32 { 
case Accelerometer = 0
case Gyroscope = 1
case Magnetometer = 2
case Gravity = 3
case UserAcceleration = 4
case Orientation = 5
case Count = 6
 }
enum EventType : UInt32 { 
case Closed = 0
case Resized = 1
case LostFocus = 2
case GainedFocus = 3
case TextEntered = 4
case KeyPressed = 5
case KeyReleased = 6
case MouseWheelMoved = 7
case MouseWheelScrolled = 8
case MouseButtonPressed = 9
case MouseButtonReleased = 10
case MouseMoved = 11
case MouseEntered = 12
case MouseLeft = 13
case JoystickButtonPressed = 14
case JoystickButtonReleased = 15
case JoystickMoved = 16
case JoystickConnected = 17
case JoystickDisconnected = 18
case TouchBegan = 19
case TouchMoved = 20
case TouchEnded = 21
case SensorChanged = 22
case Count = 23
 }
typealias MouseButtonEvent = sfMouseButtonEvent
extension MouseButtonEvent { 

 }
class HttpRequest : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfHttpRequest_create())}
deinit {if owned {sfHttpRequest_destroy(self.ptr)}}
func setField(field : String, value : String) -> () {return sfHttpRequest_setField(self.ptr, field, value)}
func setMethod(method : HttpMethod) -> () {return sfHttpRequest_setMethod(self.ptr, sfHttpMethod(rawValue:method.rawValue))}
func setUri(uri : String) -> () {return sfHttpRequest_setUri(self.ptr, uri)}
func setHttpVersion(major : UInt32, minor : UInt32) -> () {return sfHttpRequest_setHttpVersion(self.ptr, major, minor)}
func setBody(body : String) -> () {return sfHttpRequest_setBody(self.ptr, body)}
 }
class View : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfView_create())}
init(rectangle : FloatRect) {super.init(owned:sfView_createFromRect(rectangle))}
func copy() -> View {return View(owned:sfView_copy(self.ptr))}
deinit {if owned {sfView_destroy(self.ptr)}}
func reset(rectangle : FloatRect) -> () {return sfView_reset(self.ptr, rectangle)}
func move(offset : Vector2f) -> () {return sfView_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfView_rotate(self.ptr, angle)}
func zoom(factor : Float) -> () {return sfView_zoom(self.ptr, factor)}
var center : Vector2f {get {return sfView_getCenter(self.ptr)} set(center) {return sfView_setCenter(self.ptr, center)} }
var size : Vector2f {get {return sfView_getSize(self.ptr)} set(size) {return sfView_setSize(self.ptr, size)} }
var rotation : Float {get {return sfView_getRotation(self.ptr)} set(angle) {return sfView_setRotation(self.ptr, angle)} }
var viewport : FloatRect {get {return sfView_getViewport(self.ptr)} set(viewport) {return sfView_setViewport(self.ptr, viewport)} }
 }
typealias MouseWheelEvent = sfMouseWheelEvent
extension MouseWheelEvent { 

 }
class RenderWindow : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(mode : VideoMode, title : String, style : UInt32, settings : ContextSettings?) {var settings=settings;super.init(owned:sfRenderWindow_create(mode, title, style, pointer(&settings)))}
init(mode : VideoMode, title : UnsafePointer<UInt32>, style : UInt32, settings : ContextSettings?) {var settings=settings;super.init(owned:sfRenderWindow_createUnicode(mode, title, style, pointer(&settings)))}
init(handle : UnsafeMutablePointer<()>, settings : ContextSettings?) {var settings=settings;super.init(owned:sfRenderWindow_createFromHandle(handle, pointer(&settings)))}
deinit {if owned {sfRenderWindow_destroy(self.ptr)}}
func close() -> () {return sfRenderWindow_close(self.ptr)}
func pollEvent(inout event : Event) -> Bool {return Bool(sfRenderWindow_pollEvent(self.ptr, &event))}
func waitEvent(inout event : Event) -> Bool {return Bool(sfRenderWindow_waitEvent(self.ptr, &event))}
func setTitle(title : String) -> () {return sfRenderWindow_setTitle(self.ptr, title)}
func setUnicodeTitle(title : UnsafePointer<UInt32>) -> () {return sfRenderWindow_setUnicodeTitle(self.ptr, title)}
func setIcon(width : UInt32, height : UInt32, pixels : UnsafePointer<UInt8>) -> () {return sfRenderWindow_setIcon(self.ptr, width, height, pixels)}
func setVisible(visible : Bool) -> () {return sfRenderWindow_setVisible(self.ptr, Int32(visible))}
func setMouseCursorVisible(show : Bool) -> () {return sfRenderWindow_setMouseCursorVisible(self.ptr, Int32(show))}
func setVerticalSyncEnabled(enabled : Bool) -> () {return sfRenderWindow_setVerticalSyncEnabled(self.ptr, Int32(enabled))}
func setKeyRepeatEnabled(enabled : Bool) -> () {return sfRenderWindow_setKeyRepeatEnabled(self.ptr, Int32(enabled))}
func setActive(active : Bool) -> Bool {return Bool(sfRenderWindow_setActive(self.ptr, Int32(active)))}
func requestFocus() -> () {return sfRenderWindow_requestFocus(self.ptr)}
func hasFocus() -> Bool {return Bool(sfRenderWindow_hasFocus(self.ptr))}
func display() -> () {return sfRenderWindow_display(self.ptr)}
func setFramerateLimit(limit : UInt32) -> () {return sfRenderWindow_setFramerateLimit(self.ptr, limit)}
func setJoystickThreshold(threshold : Float) -> () {return sfRenderWindow_setJoystickThreshold(self.ptr, threshold)}
func clear(color : Color) -> () {return sfRenderWindow_clear(self.ptr, color)}
func getViewport(view : View) -> IntRect {return sfRenderWindow_getViewport(self.ptr, view.ptr)}
func mapPixelToCoords(point : Vector2i, view : View) -> Vector2f {return sfRenderWindow_mapPixelToCoords(self.ptr, point, view.ptr)}
func mapCoordsToPixel(point : Vector2f, view : View) -> Vector2i {return sfRenderWindow_mapCoordsToPixel(self.ptr, point, view.ptr)}
func drawSprite(object : Sprite, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawSprite(self.ptr, object.ptr, pointer(&states))}
func drawText(object : Text, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawText(self.ptr, object.ptr, pointer(&states))}
func drawShape(object : Shape, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawShape(self.ptr, object.ptr, pointer(&states))}
func drawCircleShape(object : CircleShape, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawCircleShape(self.ptr, object.ptr, pointer(&states))}
func drawConvexShape(object : ConvexShape, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawConvexShape(self.ptr, object.ptr, pointer(&states))}
func drawRectangleShape(object : RectangleShape, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawRectangleShape(self.ptr, object.ptr, pointer(&states))}
func drawVertexArray(object : VertexArray, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawVertexArray(self.ptr, object.ptr, pointer(&states))}
func drawPrimitives(vertices : UnsafePointer<sfVertex>, vertexCount : Int, type : PrimitiveType, states : RenderStates?) -> () {var states=states;return sfRenderWindow_drawPrimitives(self.ptr, vertices, vertexCount, sfPrimitiveType(rawValue:type.rawValue), pointer(&states))}
func pushGLStates() -> () {return sfRenderWindow_pushGLStates(self.ptr)}
func popGLStates() -> () {return sfRenderWindow_popGLStates(self.ptr)}
func resetGLStates() -> () {return sfRenderWindow_resetGLStates(self.ptr)}
func capture() -> Image {return Image(owned:sfRenderWindow_capture(self.ptr))}
var position : Vector2i {get {return sfRenderWindow_getPosition(self.ptr)} set(position) {return sfRenderWindow_setPosition(self.ptr, position)} }
var isOpen : Bool {get {return Bool(sfRenderWindow_isOpen(self.ptr))} }
var view : View {get {return View(unowned:sfRenderWindow_getView(self.ptr))!} set(view) {return sfRenderWindow_setView(self.ptr, view.ptr)} }
var defaultView : View {get {return View(unowned:sfRenderWindow_getDefaultView(self.ptr))!} }
var size : Vector2u {get {return sfRenderWindow_getSize(self.ptr)} set(size) {return sfRenderWindow_setSize(self.ptr, size)} }
var systemHandle : UnsafeMutablePointer<()> {get {return sfRenderWindow_getSystemHandle(self.ptr)} }
var settings : ContextSettings {get {return sfRenderWindow_getSettings(self.ptr)} }
 }
class Mutex : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfMutex_create())}
deinit {if owned {sfMutex_destroy(self.ptr)}}
func lock() -> () {return sfMutex_lock(self.ptr)}
func unlock() -> () {return sfMutex_unlock(self.ptr)}
 }
class Context : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfContext_create())}
deinit {if owned {sfContext_destroy(self.ptr)}}
func setActive(active : Bool) -> () {return sfContext_setActive(self.ptr, Int32(active))}
 }
typealias Vector2i = sfVector2i
extension Vector2i { 

 }
class SoundStream : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(onGetData : sfSoundStreamGetDataCallback, onSeek : sfSoundStreamSeekCallback, channelCount : UInt32, sampleRate : UInt32, userData : UnsafeMutablePointer<()>) {super.init(owned:sfSoundStream_create(onGetData, onSeek, channelCount, sampleRate, userData))}
deinit {if owned {sfSoundStream_destroy(self.ptr)}}
func play() -> () {return sfSoundStream_play(self.ptr)}
func pause() -> () {return sfSoundStream_pause(self.ptr)}
func stop() -> () {return sfSoundStream_stop(self.ptr)}
func setRelativeToListener(relative : Bool) -> () {return sfSoundStream_setRelativeToListener(self.ptr, Int32(relative))}
var position : Vector3f {get {return sfSoundStream_getPosition(self.ptr)} set(position) {return sfSoundStream_setPosition(self.ptr, position)} }
var volume : Float {get {return sfSoundStream_getVolume(self.ptr)} set(volume) {return sfSoundStream_setVolume(self.ptr, volume)} }
var minDistance : Float {get {return sfSoundStream_getMinDistance(self.ptr)} set(distance) {return sfSoundStream_setMinDistance(self.ptr, distance)} }
var channelCount : UInt32 {get {return sfSoundStream_getChannelCount(self.ptr)} }
var sampleRate : UInt32 {get {return sfSoundStream_getSampleRate(self.ptr)} }
var loop : Bool {get {return Bool(sfSoundStream_getLoop(self.ptr))} set(loop) {return sfSoundStream_setLoop(self.ptr, Int32(loop))} }
var status : SoundStatus {get {return SoundStatus(rawValue:sfSoundStream_getStatus(self.ptr).rawValue)!} }
var pitch : Float {get {return sfSoundStream_getPitch(self.ptr)} set(pitch) {return sfSoundStream_setPitch(self.ptr, pitch)} }
var attenuation : Float {get {return sfSoundStream_getAttenuation(self.ptr)} set(attenuation) {return sfSoundStream_setAttenuation(self.ptr, attenuation)} }
var isRelativeToListener : Bool {get {return Bool(sfSoundStream_isRelativeToListener(self.ptr))} }
var playingOffset : Time {get {return sfSoundStream_getPlayingOffset(self.ptr)} set(timeOffset) {return sfSoundStream_setPlayingOffset(self.ptr, timeOffset)} }
 }
typealias Event = sfEvent
extension Event { 

 }
enum HttpStatus : UInt32 { 
case Ok = 200
case Created = 201
case Accepted = 202
case NoContent = 204
case ResetContent = 205
case PartialContent = 206
case MultipleChoices = 300
case MovedPermanently = 301
case MovedTemporarily = 302
case NotModified = 304
case BadRequest = 400
case Unauthorized = 401
case Forbidden = 403
case NotFound = 404
case RangeNotSatisfiable = 407
case InternalServerError = 500
case NotImplemented = 501
case BadGateway = 502
case ServiceNotAvailable = 503
case GatewayTimeout = 504
case VersionNotSupported = 505
case InvalidResponse = 1000
case ConnectionFailed = 1001
 }
typealias MouseWheelScrollEvent = sfMouseWheelScrollEvent
extension MouseWheelScrollEvent { 

 }
typealias JoystickMoveEvent = sfJoystickMoveEvent
extension JoystickMoveEvent { 

 }
typealias Vector2f = sfVector2f
extension Vector2f { 

 }
typealias MouseMoveEvent = sfMouseMoveEvent
extension MouseMoveEvent { 

 }
class Texture : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(width : UInt32, height : UInt32) {super.init(owned:sfTexture_create(width, height))}
init(filename : String, area : IntRect?) {var area=area;super.init(owned:sfTexture_createFromFile(filename, pointer(&area)))}
init(data : UnsafePointer<()>, sizeInBytes : Int, area : IntRect?) {var area=area;super.init(owned:sfTexture_createFromMemory(data, sizeInBytes, pointer(&area)))}
init(inout stream : InputStream, area : IntRect?) {var area=area;super.init(owned:sfTexture_createFromStream(&stream, pointer(&area)))}
init(image : Image, area : IntRect?) {var area=area;super.init(owned:sfTexture_createFromImage(image.ptr, pointer(&area)))}
func copy() -> Texture {return Texture(owned:sfTexture_copy(self.ptr))}
deinit {if owned {sfTexture_destroy(self.ptr)}}
func copyToImage() -> Image {return Image(owned:sfTexture_copyToImage(self.ptr))}
func updateFromPixels(pixels : UnsafePointer<UInt8>, width : UInt32, height : UInt32, x : UInt32, y : UInt32) -> () {return sfTexture_updateFromPixels(self.ptr, pixels, width, height, x, y)}
func updateFromImage(image : Image, x : UInt32, y : UInt32) -> () {return sfTexture_updateFromImage(self.ptr, image.ptr, x, y)}
func updateFromWindow(window : Window, x : UInt32, y : UInt32) -> () {return sfTexture_updateFromWindow(self.ptr, window.ptr, x, y)}
func updateFromRenderWindow(renderWindow : RenderWindow, x : UInt32, y : UInt32) -> () {return sfTexture_updateFromRenderWindow(self.ptr, renderWindow.ptr, x, y)}
func setSmooth(smooth : Bool) -> () {return sfTexture_setSmooth(self.ptr, Int32(smooth))}
func setRepeated(repeated : Bool) -> () {return sfTexture_setRepeated(self.ptr, Int32(repeated))}
func bind() -> () {return sfTexture_bind(self.ptr)}
var maximumSize : UInt32 {get {return sfTexture_getMaximumSize()} }
var isRepeated : Bool {get {return Bool(sfTexture_isRepeated(self.ptr))} }
var size : Vector2u {get {return sfTexture_getSize(self.ptr)} }
var nativeHandle : UInt32 {get {return sfTexture_getNativeHandle(self.ptr)} }
var isSmooth : Bool {get {return Bool(sfTexture_isSmooth(self.ptr))} }
 }
typealias FloatRect = sfFloatRect
extension FloatRect { 
static func contains(rect : FloatRect?, x : Float, y : Float) -> Bool {var rect=rect;return Bool(sfFloatRect_contains(pointer(&rect), x, y))}
static func intersects(rect1 : FloatRect?, rect2 : FloatRect?, inout intersection : FloatRect) -> Bool {var rect1=rect1, rect2=rect2;return Bool(sfFloatRect_intersects(pointer(&rect1), pointer(&rect2), &intersection))}
 }
enum HttpMethod : UInt32 { 
case Get = 0
case Post = 1
case Head = 2
case Put = 3
case Delete = 4
 }
enum TextStyle : UInt32 { 
case Regular = 0
case Bold = 1
case Italic = 2
case Underlined = 4
case StrikeThrough = 8
 }
enum WindowStyle : UInt32 { 
case None = 0
case Titlebar = 1
case Resize = 2
case Close = 4
case Fullscreen = 8
case DefaultStyle = 7
 }
extension sfRenderStates { 

 }
class SoundBufferRecorder : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfSoundBufferRecorder_create())}
deinit {if owned {sfSoundBufferRecorder_destroy(self.ptr)}}
func start(sampleRate : UInt32) -> () {return sfSoundBufferRecorder_start(self.ptr, sampleRate)}
func stop() -> () {return sfSoundBufferRecorder_stop(self.ptr)}
var sampleRate : UInt32 {get {return sfSoundBufferRecorder_getSampleRate(self.ptr)} }
var buffer : SoundBuffer {get {return SoundBuffer(unowned:sfSoundBufferRecorder_getBuffer(self.ptr))!} }
 }
class Font : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(filename : String) {super.init(owned:sfFont_createFromFile(filename))}
init(data : UnsafePointer<()>, sizeInBytes : Int) {super.init(owned:sfFont_createFromMemory(data, sizeInBytes))}
init(inout stream : InputStream) {super.init(owned:sfFont_createFromStream(&stream))}
func copy() -> Font {return Font(owned:sfFont_copy(self.ptr))}
deinit {if owned {sfFont_destroy(self.ptr)}}
func getGlyph(codePoint : UInt32, characterSize : UInt32, bold : Bool) -> Glyph {return sfFont_getGlyph(self.ptr, codePoint, characterSize, Int32(bold))}
func getKerning(first : UInt32, second : UInt32, characterSize : UInt32) -> Float {return sfFont_getKerning(self.ptr, first, second, characterSize)}
func getLineSpacing(characterSize : UInt32) -> Float {return sfFont_getLineSpacing(self.ptr, characterSize)}
func getUnderlinePosition(characterSize : UInt32) -> Float {return sfFont_getUnderlinePosition(self.ptr, characterSize)}
func getUnderlineThickness(characterSize : UInt32) -> Float {return sfFont_getUnderlineThickness(self.ptr, characterSize)}
func getTexture(characterSize : UInt32) -> Texture {return Texture(unowned:sfFont_getTexture(self.ptr, characterSize))!}
var info : FontInfo {get {return sfFont_getInfo(self.ptr)} }
 }
typealias SensorEvent = sfSensorEvent
extension SensorEvent { 

 }
enum FtpStatus : UInt32 { 
case RestartMarkerReply = 110
case ServiceReadySoon = 120
case DataConnectionAlreadyOpened = 125
case OpeningDataConnection = 150
case Ok = 200
case PointlessCommand = 202
case SystemStatus = 211
case DirectoryStatus = 212
case FileStatus = 213
case HelpMessage = 214
case SystemType = 215
case ServiceReady = 220
case ClosingConnection = 221
case DataConnectionOpened = 225
case ClosingDataConnection = 226
case EnteringPassiveMode = 227
case LoggedIn = 230
case FileActionOk = 250
case DirectoryOk = 257
case NeedPassword = 331
case NeedAccountToLogIn = 332
case NeedInformation = 350
case ServiceUnavailable = 421
case DataConnectionUnavailable = 425
case TransferAborted = 426
case FileActionAborted = 450
case LocalError = 451
case InsufficientStorageSpace = 452
case CommandUnknown = 500
case ParametersUnknown = 501
case CommandNotImplemented = 502
case BadCommandSequence = 503
case ParameterNotImplemented = 504
case NotLoggedIn = 530
case NeedAccountToStore = 532
case FileUnavailable = 550
case PageTypeUnknown = 551
case NotEnoughMemory = 552
case FilenameNotAllowed = 553
case InvalidResponse = 1000
case ConnectionFailed = 1001
case ConnectionClosed = 1002
case InvalidFile = 1003
 }
class SoundBuffer : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(filename : String) {super.init(owned:sfSoundBuffer_createFromFile(filename))}
init(data : UnsafePointer<()>, sizeInBytes : Int) {super.init(owned:sfSoundBuffer_createFromMemory(data, sizeInBytes))}
init(inout stream : InputStream) {super.init(owned:sfSoundBuffer_createFromStream(&stream))}
init(samples : UnsafePointer<Int16>, sampleCount : UInt64, channelCount : UInt32, sampleRate : UInt32) {super.init(owned:sfSoundBuffer_createFromSamples(samples, sampleCount, channelCount, sampleRate))}
func copy() -> SoundBuffer {return SoundBuffer(owned:sfSoundBuffer_copy(self.ptr))}
deinit {if owned {sfSoundBuffer_destroy(self.ptr)}}
func saveToFile(filename : String) -> Bool {return Bool(sfSoundBuffer_saveToFile(self.ptr, filename))}
var samples : UnsafePointer<Int16> {get {return sfSoundBuffer_getSamples(self.ptr)} }
var sampleCount : UInt64 {get {return sfSoundBuffer_getSampleCount(self.ptr)} }
var sampleRate : UInt32 {get {return sfSoundBuffer_getSampleRate(self.ptr)} }
var channelCount : UInt32 {get {return sfSoundBuffer_getChannelCount(self.ptr)} }
var duration : Time {get {return sfSoundBuffer_getDuration(self.ptr)} }
 }
enum FtpTransferMode : UInt32 { 
case Binary = 0
case Ascii = 1
case Ebcdic = 2
 }
enum ContextAttribute : UInt32 { 
case Default = 0
case Core = 1
case Debug = 4
 }
class Shape : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(getPointCount : sfShapeGetPointCountCallback, getPoint : sfShapeGetPointCallback, userData : UnsafeMutablePointer<()>) {super.init(owned:sfShape_create(getPointCount, getPoint, userData))}
deinit {if owned {sfShape_destroy(self.ptr)}}
func move(offset : Vector2f) -> () {return sfShape_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfShape_rotate(self.ptr, angle)}
func scale(factors : Vector2f) -> () {return sfShape_scale(self.ptr, factors)}
func setTexture(texture : Texture, resetRect : Bool) -> () {return sfShape_setTexture(self.ptr, texture.ptr, Int32(resetRect))}
func getPoint(index : Int) -> Vector2f {return sfShape_getPoint(self.ptr, index)}
func update() -> () {return sfShape_update(self.ptr)}
var position : Vector2f {get {return sfShape_getPosition(self.ptr)} set(position) {return sfShape_setPosition(self.ptr, position)} }
var texture : Texture {get {return Texture(unowned:sfShape_getTexture(self.ptr))!} }
var rotation : Float {get {return sfShape_getRotation(self.ptr)} set(angle) {return sfShape_setRotation(self.ptr, angle)} }
var outlineColor : Color {get {return sfShape_getOutlineColor(self.ptr)} set(color) {return sfShape_setOutlineColor(self.ptr, color)} }
var pointCount : Int {get {return sfShape_getPointCount(self.ptr)} }
var scale : Vector2f {get {return sfShape_getScale(self.ptr)} set(scale) {return sfShape_setScale(self.ptr, scale)} }
var origin : Vector2f {get {return sfShape_getOrigin(self.ptr)} set(origin) {return sfShape_setOrigin(self.ptr, origin)} }
var fillColor : Color {get {return sfShape_getFillColor(self.ptr)} set(color) {return sfShape_setFillColor(self.ptr, color)} }
var transform : Transform {get {return sfShape_getTransform(self.ptr)} }
var globalBounds : FloatRect {get {return sfShape_getGlobalBounds(self.ptr)} }
var localBounds : FloatRect {get {return sfShape_getLocalBounds(self.ptr)} }
var outlineThickness : Float {get {return sfShape_getOutlineThickness(self.ptr)} set(thickness) {return sfShape_setOutlineThickness(self.ptr, thickness)} }
var inverseTransform : Transform {get {return sfShape_getInverseTransform(self.ptr)} }
var textureRect : IntRect {get {return sfShape_getTextureRect(self.ptr)} set(rect) {return sfShape_setTextureRect(self.ptr, rect)} }
 }
class SocketSelector : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfSocketSelector_create())}
func copy() -> SocketSelector {return SocketSelector(owned:sfSocketSelector_copy(self.ptr))}
deinit {if owned {sfSocketSelector_destroy(self.ptr)}}
func addTcpListener(socket : TcpListener) -> () {return sfSocketSelector_addTcpListener(self.ptr, socket.ptr)}
func addTcpSocket(socket : TcpSocket) -> () {return sfSocketSelector_addTcpSocket(self.ptr, socket.ptr)}
func addUdpSocket(socket : UdpSocket) -> () {return sfSocketSelector_addUdpSocket(self.ptr, socket.ptr)}
func removeTcpListener(socket : TcpListener) -> () {return sfSocketSelector_removeTcpListener(self.ptr, socket.ptr)}
func removeTcpSocket(socket : TcpSocket) -> () {return sfSocketSelector_removeTcpSocket(self.ptr, socket.ptr)}
func removeUdpSocket(socket : UdpSocket) -> () {return sfSocketSelector_removeUdpSocket(self.ptr, socket.ptr)}
func clear() -> () {return sfSocketSelector_clear(self.ptr)}
func wait(timeout : Time) -> Bool {return Bool(sfSocketSelector_wait(self.ptr, timeout))}
func isTcpListenerReady(socket : TcpListener) -> Bool {return Bool(sfSocketSelector_isTcpListenerReady(self.ptr, socket.ptr))}
func isTcpSocketReady(socket : TcpSocket) -> Bool {return Bool(sfSocketSelector_isTcpSocketReady(self.ptr, socket.ptr))}
func isUdpSocketReady(socket : UdpSocket) -> Bool {return Bool(sfSocketSelector_isUdpSocketReady(self.ptr, socket.ptr))}
 }
class FtpListingResponse : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
deinit {if owned {sfFtpListingResponse_destroy(self.ptr)}}
func getName(index : Int) -> String {return String(sfFtpListingResponse_getName(self.ptr, index))}
var status : FtpStatus {get {return FtpStatus(rawValue:sfFtpListingResponse_getStatus(self.ptr).rawValue)!} }
var count : Int {get {return sfFtpListingResponse_getCount(self.ptr)} }
var isOk : Bool {get {return Bool(sfFtpListingResponse_isOk(self.ptr))} }
var message : String {get {return String(sfFtpListingResponse_getMessage(self.ptr))} }
 }
typealias IpAddress = sfIpAddress
extension IpAddress { 
static func fromString(address : String) -> IpAddress {return sfIpAddress_fromString(address)}
static func fromBytes(byte0 : UInt8, byte1 : UInt8, byte2 : UInt8, byte3 : UInt8) -> IpAddress {return sfIpAddress_fromBytes(byte0, byte1, byte2, byte3)}
static func fromInteger(address : UInt32) -> IpAddress {return sfIpAddress_fromInteger(address)}
func toString(string : UnsafeMutablePointer<Int8>) -> () {return sfIpAddress_toString(self, string)}
func toInteger() -> UInt32 {return sfIpAddress_toInteger(self)}
static func getPublicAddress(timeout : Time) -> IpAddress {return sfIpAddress_getPublicAddress(timeout)}
var localAddress : IpAddress {get {return sfIpAddress_getLocalAddress()} }
static let none = sfIpAddress_None
static let localHost = sfIpAddress_LocalHost
static let broadcast = sfIpAddress_Broadcast
 }
class Transformable : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfTransformable_create())}
func copy() -> Transformable {return Transformable(owned:sfTransformable_copy(self.ptr))}
deinit {if owned {sfTransformable_destroy(self.ptr)}}
func move(offset : Vector2f) -> () {return sfTransformable_move(self.ptr, offset)}
func rotate(angle : Float) -> () {return sfTransformable_rotate(self.ptr, angle)}
func scale(factors : Vector2f) -> () {return sfTransformable_scale(self.ptr, factors)}
var transform : Transform {get {return sfTransformable_getTransform(self.ptr)} }
var origin : Vector2f {get {return sfTransformable_getOrigin(self.ptr)} set(origin) {return sfTransformable_setOrigin(self.ptr, origin)} }
var position : Vector2f {get {return sfTransformable_getPosition(self.ptr)} set(position) {return sfTransformable_setPosition(self.ptr, position)} }
var rotation : Float {get {return sfTransformable_getRotation(self.ptr)} set(angle) {return sfTransformable_setRotation(self.ptr, angle)} }
var inverseTransform : Transform {get {return sfTransformable_getInverseTransform(self.ptr)} }
var scale : Vector2f {get {return sfTransformable_getScale(self.ptr)} set(scale) {return sfTransformable_setScale(self.ptr, scale)} }
 }
enum MouseButton : UInt32 { 
case Left = 0
case Right = 1
case Middle = 2
case XButton1 = 3
case XButton2 = 4
case ButtonCount = 5
 }
typealias BlendMode = sfBlendMode
extension BlendMode { 
static let blendAlpha = sfBlendAlpha
static let blendAdd = sfBlendAdd
static let blendMultiply = sfBlendMultiply
static let blendNone = sfBlendNone
 }
typealias Vector3f = sfVector3f
extension Vector3f { 

 }
class HttpResponse : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
deinit {if owned {sfHttpResponse_destroy(self.ptr)}}
func getField(field : String) -> String {return String(sfHttpResponse_getField(self.ptr, field))}
var status : HttpStatus {get {return HttpStatus(rawValue:sfHttpResponse_getStatus(self.ptr).rawValue)!} }
var body : String {get {return String(sfHttpResponse_getBody(self.ptr))} }
var minorVersion : UInt32 {get {return sfHttpResponse_getMinorVersion(self.ptr)} }
var majorVersion : UInt32 {get {return sfHttpResponse_getMajorVersion(self.ptr)} }
 }
typealias Glyph = sfGlyph
extension Glyph { 

 }
typealias VideoMode = sfVideoMode
extension VideoMode { 
static func getFullscreenModes(Count : UnsafeMutablePointer<Int>) -> UnsafePointer<sfVideoMode> {return sfVideoMode_getFullscreenModes(Count)}
var desktopMode : VideoMode {get {return sfVideoMode_getDesktopMode()} }
var isValid : Bool {get {return Bool(sfVideoMode_isValid(self))} }
 }
typealias Time = sfTime
extension Time { 
func asSeconds() -> Float {return sfTime_asSeconds(self)}
func asMilliseconds() -> Int32 {return sfTime_asMilliseconds(self)}
func asMicroseconds() -> Int64 {return sfTime_asMicroseconds(self)}
static let zero = sfTime_Zero
 }
typealias Vector2u = sfVector2u
extension Vector2u { 

 }
typealias Transform = sfTransform
extension Transform { 
static func fromMatrix(a00 : Float, a01 : Float, a02 : Float, a10 : Float, a11 : Float, a12 : Float, a20 : Float, a21 : Float, a22 : Float) -> Transform {return sfTransform_fromMatrix(a00, a01, a02, a10, a11, a12, a20, a21, a22)}
static func getMatrix(transform : Transform?, matrix : UnsafeMutablePointer<Float>) -> () {var transform=transform;return sfTransform_getMatrix(pointer(&transform), matrix)}
static func getInverse(transform : Transform?) -> Transform {var transform=transform;return sfTransform_getInverse(pointer(&transform))}
static func transformPoint(transform : Transform?, point : Vector2f) -> Vector2f {var transform=transform;return sfTransform_transformPoint(pointer(&transform), point)}
static func transformRect(transform : Transform?, rectangle : FloatRect) -> FloatRect {var transform=transform;return sfTransform_transformRect(pointer(&transform), rectangle)}
static func combine(inout transform : Transform, other : Transform?) -> () {var other=other;return sfTransform_combine(&transform, pointer(&other))}
static func translate(inout transform : Transform, x : Float, y : Float) -> () {return sfTransform_translate(&transform, x, y)}
static func rotate(inout transform : Transform, angle : Float) -> () {return sfTransform_rotate(&transform, angle)}
static func rotateWithCenter(inout transform : Transform, angle : Float, centerX : Float, centerY : Float) -> () {return sfTransform_rotateWithCenter(&transform, angle, centerX, centerY)}
static func scale(inout transform : Transform, scaleX : Float, scaleY : Float) -> () {return sfTransform_scale(&transform, scaleX, scaleY)}
static func scaleWithCenter(inout transform : Transform, scaleX : Float, scaleY : Float, centerX : Float, centerY : Float) -> () {return sfTransform_scaleWithCenter(&transform, scaleX, scaleY, centerX, centerY)}
static let identity = sfTransform_Identity
 }
enum PrimitiveType : UInt32 { 
case Points = 0
case Lines = 1
case LinesStrip = 2
case Triangles = 3
case TrianglesStrip = 4
case TrianglesFan = 5
case Quads = 6
 }
class FtpResponse : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
deinit {if owned {sfFtpResponse_destroy(self.ptr)}}
var status : FtpStatus {get {return FtpStatus(rawValue:sfFtpResponse_getStatus(self.ptr).rawValue)!} }
var isOk : Bool {get {return Bool(sfFtpResponse_isOk(self.ptr))} }
var message : String {get {return String(sfFtpResponse_getMessage(self.ptr))} }
 }
class Http : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfHttp_create())}
deinit {if owned {sfHttp_destroy(self.ptr)}}
func setHost(host : String, port : UInt16) -> () {return sfHttp_setHost(self.ptr, host, port)}
func sendRequest(request : HttpRequest, timeout : Time) -> HttpResponse {return HttpResponse(unowned:sfHttp_sendRequest(self.ptr, request.ptr, timeout))!}
 }
class Packet : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfPacket_create())}
func copy() -> Packet {return Packet(owned:sfPacket_copy(self.ptr))}
deinit {if owned {sfPacket_destroy(self.ptr)}}
func append(data : UnsafePointer<()>, sizeInBytes : Int) -> () {return sfPacket_append(self.ptr, data, sizeInBytes)}
func clear() -> () {return sfPacket_clear(self.ptr)}
func endOfPacket() -> Bool {return Bool(sfPacket_endOfPacket(self.ptr))}
func canRead() -> Bool {return Bool(sfPacket_canRead(self.ptr))}
func readBool() -> Bool {return Bool(sfPacket_readBool(self.ptr))}
func readInt8() -> Int8 {return sfPacket_readInt8(self.ptr)}
func readUint8() -> UInt8 {return sfPacket_readUint8(self.ptr)}
func readInt16() -> Int16 {return sfPacket_readInt16(self.ptr)}
func readUint16() -> UInt16 {return sfPacket_readUint16(self.ptr)}
func readInt32() -> Int32 {return sfPacket_readInt32(self.ptr)}
func readUint32() -> UInt32 {return sfPacket_readUint32(self.ptr)}
func readFloat() -> Float {return sfPacket_readFloat(self.ptr)}
func readDouble() -> Double {return sfPacket_readDouble(self.ptr)}
func readString(string : UnsafeMutablePointer<Int8>) -> () {return sfPacket_readString(self.ptr, string)}
func readWideString(string : UnsafeMutablePointer<Int32>) -> () {return sfPacket_readWideString(self.ptr, string)}
func writeBool(value : Bool) -> () {return sfPacket_writeBool(self.ptr, Int32(value))}
func writeInt8(value : Int8) -> () {return sfPacket_writeInt8(self.ptr, value)}
func writeUint8(value : UInt8) -> () {return sfPacket_writeUint8(self.ptr, value)}
func writeInt16(value : Int16) -> () {return sfPacket_writeInt16(self.ptr, value)}
func writeUint16(value : UInt16) -> () {return sfPacket_writeUint16(self.ptr, value)}
func writeInt32(value : Int32) -> () {return sfPacket_writeInt32(self.ptr, value)}
func writeUint32(value : UInt32) -> () {return sfPacket_writeUint32(self.ptr, value)}
func writeFloat(value : Float) -> () {return sfPacket_writeFloat(self.ptr, value)}
func writeDouble(value : Double) -> () {return sfPacket_writeDouble(self.ptr, value)}
func writeString(string : String) -> () {return sfPacket_writeString(self.ptr, string)}
func writeWideString(string : UnsafePointer<Int32>) -> () {return sfPacket_writeWideString(self.ptr, string)}
var dataSize : Int {get {return sfPacket_getDataSize(self.ptr)} }
var data : UnsafePointer<()> {get {return sfPacket_getData(self.ptr)} }
 }
class TcpSocket : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init() {super.init(owned:sfTcpSocket_create())}
deinit {if owned {sfTcpSocket_destroy(self.ptr)}}
func setBlocking(blocking : Bool) -> () {return sfTcpSocket_setBlocking(self.ptr, Int32(blocking))}
func connect(host : IpAddress, port : UInt16, timeout : Time) -> SocketStatus {return SocketStatus(rawValue:sfTcpSocket_connect(self.ptr, host, port, timeout).rawValue)!}
func disconnect() -> () {return sfTcpSocket_disconnect(self.ptr)}
func send(data : UnsafePointer<()>, size : Int) -> SocketStatus {return SocketStatus(rawValue:sfTcpSocket_send(self.ptr, data, size).rawValue)!}
func sendPartial(data : UnsafePointer<()>, size : Int, sent : UnsafeMutablePointer<Int>) -> SocketStatus {return SocketStatus(rawValue:sfTcpSocket_sendPartial(self.ptr, data, size, sent).rawValue)!}
func receive(data : UnsafeMutablePointer<()>, maxSize : Int, sizeReceived : UnsafeMutablePointer<Int>) -> SocketStatus {return SocketStatus(rawValue:sfTcpSocket_receive(self.ptr, data, maxSize, sizeReceived).rawValue)!}
func sendPacket(packet : Packet) -> SocketStatus {return SocketStatus(rawValue:sfTcpSocket_sendPacket(self.ptr, packet.ptr).rawValue)!}
func receivePacket(packet : Packet) -> SocketStatus {return SocketStatus(rawValue:sfTcpSocket_receivePacket(self.ptr, packet.ptr).rawValue)!}
var remotePort : UInt16 {get {return sfTcpSocket_getRemotePort(self.ptr)} }
var isBlocking : Bool {get {return Bool(sfTcpSocket_isBlocking(self.ptr))} }
var localPort : UInt16 {get {return sfTcpSocket_getLocalPort(self.ptr)} }
var remoteAddress : IpAddress {get {return sfTcpSocket_getRemoteAddress(self.ptr)} }
 }
class Music : OpaqueWrapper { 
internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}
internal override init(owned : COpaquePointer) {super.init(owned:owned)}
init(filename : String) {super.init(owned:sfMusic_createFromFile(filename))}
init(data : UnsafePointer<()>, sizeInBytes : Int) {super.init(owned:sfMusic_createFromMemory(data, sizeInBytes))}
init(inout stream : InputStream) {super.init(owned:sfMusic_createFromStream(&stream))}
deinit {if owned {sfMusic_destroy(self.ptr)}}
func play() -> () {return sfMusic_play(self.ptr)}
func pause() -> () {return sfMusic_pause(self.ptr)}
func stop() -> () {return sfMusic_stop(self.ptr)}
func setRelativeToListener(relative : Bool) -> () {return sfMusic_setRelativeToListener(self.ptr, Int32(relative))}
var loop : Bool {get {return Bool(sfMusic_getLoop(self.ptr))} set(loop) {return sfMusic_setLoop(self.ptr, Int32(loop))} }
var volume : Float {get {return sfMusic_getVolume(self.ptr)} set(volume) {return sfMusic_setVolume(self.ptr, volume)} }
var position : Vector3f {get {return sfMusic_getPosition(self.ptr)} set(position) {return sfMusic_setPosition(self.ptr, position)} }
var channelCount : UInt32 {get {return sfMusic_getChannelCount(self.ptr)} }
var pitch : Float {get {return sfMusic_getPitch(self.ptr)} set(pitch) {return sfMusic_setPitch(self.ptr, pitch)} }
var attenuation : Float {get {return sfMusic_getAttenuation(self.ptr)} set(attenuation) {return sfMusic_setAttenuation(self.ptr, attenuation)} }
var duration : Time {get {return sfMusic_getDuration(self.ptr)} }
var playingOffset : Time {get {return sfMusic_getPlayingOffset(self.ptr)} set(timeOffset) {return sfMusic_setPlayingOffset(self.ptr, timeOffset)} }
var isRelativeToListener : Bool {get {return Bool(sfMusic_isRelativeToListener(self.ptr))} }
var minDistance : Float {get {return sfMusic_getMinDistance(self.ptr)} set(distance) {return sfMusic_setMinDistance(self.ptr, distance)} }
var sampleRate : UInt32 {get {return sfMusic_getSampleRate(self.ptr)} }
var status : SoundStatus {get {return SoundStatus(rawValue:sfMusic_getStatus(self.ptr).rawValue)!} }
 }
typealias FontInfo = sfFontInfo
extension FontInfo { 

 }
typealias SizeEvent = sfSizeEvent
extension SizeEvent { 

 }
typealias IntRect = sfIntRect
extension IntRect { 
static func contains(rect : IntRect?, x : Int32, y : Int32) -> Bool {var rect=rect;return Bool(sfIntRect_contains(pointer(&rect), x, y))}
static func intersects(rect1 : IntRect?, rect2 : IntRect?, inout intersection : IntRect) -> Bool {var rect1=rect1, rect2=rect2;return Bool(sfIntRect_intersects(pointer(&rect1), pointer(&rect2), &intersection))}
 }
enum SocketStatus : UInt32 { 
case Done = 0
case NotReady = 1
case Partial = 2
case Disconnected = 3
case Error = 4
 }
typealias Color = sfColor
extension Color { 
static func fromRGB(red : UInt8, green : UInt8, blue : UInt8) -> Color {return sfColor_fromRGB(red, green, blue)}
static func fromRGBA(red : UInt8, green : UInt8, blue : UInt8, alpha : UInt8) -> Color {return sfColor_fromRGBA(red, green, blue, alpha)}
static func fromInteger(color : UInt32) -> Color {return sfColor_fromInteger(color)}
func toInteger() -> UInt32 {return sfColor_toInteger(self)}
func add(color2 : Color) -> Color {return sfColor_add(self, color2)}
func subtract(color2 : Color) -> Color {return sfColor_subtract(self, color2)}
func modulate(color2 : Color) -> Color {return sfColor_modulate(self, color2)}
static let black = sfBlack
static let white = sfWhite
static let red = sfRed
static let green = sfGreen
static let blue = sfBlue
static let yellow = sfYellow
static let magenta = sfMagenta
static let cyan = sfCyan
static let transparent = sfTransparent
 }