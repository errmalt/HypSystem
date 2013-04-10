package fr.hyperfiction;

import nme.JNI;
#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end
/**
 * ...
 * @author shoe[box]
 */

@:build( org.shoebox.utils.NativeMirror.build( ) )
class HypSystem{

	#if android
	private static var _f_show_dialog			: Dynamic;
	private static var _f_show_dialog2			: Dynamic;
	private static var _f_show_loading			: Dynamic;

	private static inline var ANDROID_CLASS : String = 'fr/hyperfiction/HypSystem';
	#end


	#if iphone
	private static var hyp_webview_screen_w	= Lib.load( "HypSystem" , "HypSystem_screen_width"  , 0 );
	private static var hyp_webview_screen_h	= Lib.load( "HypSystem" , "HypSystem_screen_height" , 0 );
	private static var hyp_system_lang		= Lib.load( "HypSystem" , "HypSystem_get_system_lang" , 0 );
	#end

	#if blackberry
	private static var hyp_show_loading		= Lib.load( "HypSystem" , "HypSystem_show_loading"  , 0 );
	private static var hyp_hide_loading		= Lib.load( "HypSystem" , "HypSystem_hide_loading"  , 0 );
	private static var hyp_system_lang		= Lib.load( "HypSystem" , "HypSystem_get_system_lang" , 0 );
	private static var hyp_launch_browser	= Lib.load( "HypSystem" , "HypSystem_launch_browser" , 1 );
	#end

	// -------o constructor

		/**
		* constructor
		*
		* @param
		* @return	void
		*/
		private function new() {

		}

	// -------o public

		/**
		*
		*
		* @public
		* @return	void
		*/
		#if android
		@JNI
		#end
		#if ios
		@CPP("HypSystem","HypSystem_isConnectedtoInternet")
		#end
		static public function isConnected( ) : Bool {
			return true;
		}



		/**
		*
		*
		* @public
		* @return	void
		*/
		#if ios
		@CPP("HypSystem","HypSystem_isIphone")
		#end

		#if android
		@JNI
		#end
		static public function isSmartPhone( ) : Bool {
			return false;
		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		static public function showError_dialog(
													sText : String
													#if android,
													?bCancelable : Bool,
													?sNeg	: String ,
													?sPos	: String ,
													?fPos	: Void->Void,
													?fNeg	: Void->Void
													#end
												) : Void {
			#if android
			_show_error_dialog( sText , bCancelable , sNeg , sPos , fPos , fNeg );
			#end
		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		#if android
		@JNI
		#end
		static public function getSystem_lang( ) : String {

			var s = 'unknow';

			#if iphone
			s = hyp_system_lang( );
			#end

			#if blackberry
			s = hyp_system_lang( );
			#end

			return s;

		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		#if android
		@JNI
		#end
		static public function show_loading( ) : Void {
			#if blackberry
			hyp_show_loading();
			#end
		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		#if android
		@JNI
		#end
		static public function hide_loading( ) : Void {
			#if blackberry
			hyp_hide_loading();
			#end
		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		#if android
		@JNI
		#end
		static public function dismiss_loading( ) : Void {

		}

		#if blackberry
		static public function launch_browser( sUrl : String ) : Void {
			hyp_launch_browser( sUrl );
		}
		#end

		/**
		*
		*
		* @private
		* @return	void
		*/
		static private function _show_error_dialog(
											sText		: String ,
											?bCancelable	: Bool,
											?sNeg		: String ,
											?sPos		: String ,
											?fPos		: Void->Void,
											?fNeg		: Void->Void
										) : Void{
			trace('_show_error_dialog ::: '+sText);

			#if android
				if( sNeg == null && sPos == null ){
					openDialog( sText , bCancelable );
				}else{
					if( _f_show_dialog2 == null )
						_f_show_dialog2 = JNI.createStaticMethod( ANDROID_CLASS , "openCustomDialog" , "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/haxe/nme/HaxeObject;)V" );
						_f_show_dialog2( sText , sNeg , sPos , new PopupCallBack( fPos , fNeg ) );
				}
			#end
		}


	// -------o protected

	// -------o iOS

	#if ios

		/**
		*
		*
		* @public
		* @return	void
		*/
		static public function get_screen_width( ) : Int {
			return hyp_webview_screen_w( );
		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		static public function get_screen_height( ) : Int {
			return hyp_webview_screen_h( );
		}

		#end

	// -------o android

	#if android

		/**
		*
		*
		* @public
		* @return	void
		*/
		@JNI
		static public function isWifi( ) : Bool {

		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		@JNI
		static public function getScreen_bucket( ) : String {

		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		@JNI
		static public function getDensity( ) : String {

		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		@JNI
		static public function wakeLock( iDelay : Int ) : Void {}

		/**
		*
		*
		* @public
		* @return	void
		*/
		@JNI
		static public function getLocal_IP( ) : String {}

		/**
		*
		*
		* @public
		* @return	void
		*/
		@JNI
		static public function lightsOut( ) : Void {}

		//Privates
		@JNI
		private static function openDialog( s : String , bCancelable : Bool ) : Void{}

	#end

	// -------o misc

}

#if android

/**
 * ...
 * @author shoe[box]
 */

class PopupCallBack{

	public var fPos : Void->Void;
	public var fNeg : Void->Void;

	// -------o constructor

		/**
		* constructor
		*
		* @param
		* @return	void
		*/
		public function new( fPos : Void->Void , fNeg : Void->Void ) {
			this.fPos = fPos;
			this.fNeg = fNeg;
		}

	// -------o public

		/**
		*
		*
		* @public
		* @return	void
		*/
		public function pos( ) : Void {
			fPos( );
		}

		/**
		*
		*
		* @public
		* @return	void
		*/
		public function neg( ) : Void {
			fNeg( );
		}

	// -------o protected



	// -------o misc

}

#end