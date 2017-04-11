/**
 * Created by russellmilburn on 11/08/15.
 */
package com.tro.chromecast.views.components.devicedisplay
{

	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanel;
	import com.tro.chromecast.views.components.devicedisplay.videocontrols.VideoControlPanelTexturesVo;
	import com.tro.chromecast.views.components.mediadisplay.MediaDisplaySprite;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.gestouch.gestures.TapGesture;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.textures.Texture;

	public class DeviceDisplay extends Sprite
	{

		public var laptop : Device;
		public var mobile : Device;
		public var tablet : Device;

		private var _currentDevice : Device;

		public var controlPanel : VideoControlPanel;

		public var videoDisplay : Sprite;
		private var videoImage : Image;

		private var _tap : TapGesture;



		public function DeviceDisplay(isMobileHorizontal : Boolean = true)
		{
			super();

			laptop = new Laptop();
			laptop.x = 509;
			laptop.y = 400;

			if (isMobileHorizontal)
			{
				mobile = new MobileHorizontal();
				mobile.x = 509;
				mobile.y = 600;
			}
			else
			{
				mobile = new MobileVertical();
				mobile.x = 509;
				mobile.y = 400;
			}

			tablet = new Tablet();
			tablet.x = 593;
			tablet.y = 400;

			laptop.visible = false;
			mobile.visible = false;
			tablet.visible = false;

			//May interfere with video controls
			_tap = new TapGesture(this);

			controlPanel = new VideoControlPanel();
			controlPanel.visible = false;


		}



		public function changeDevice(device : String ) : void
		{
			if (currentDevice !=null)
			{
				removeChild(currentDevice);
			}

			if (device == DeviceTypeVo.LAPTOP)
			{
				currentDevice = laptop;
			}
			else if (device == DeviceTypeVo.MOBILE)
			{
				currentDevice = mobile;
			}
			else if (device == DeviceTypeVo.TABLET)
			{
				currentDevice = tablet;
			}



			currentDevice.visible = true;
			addChild(currentDevice);
			updateDevicePosition();
		}

		private function updateDevicePosition():void
		{
			currentDevice.x = (stage.stageWidth - currentDevice.width) / 2;
		}

		public function reset() : void
		{
			if (currentDevice != null)
			{
				currentDevice.removeScreenTexture();
				if (videoImage != null)
				{
					removeVideo();
				}

				controlPanel.visible = false;
			}

		}


		public function get currentDevice():Device
		{
			return _currentDevice;
		}

		public function set currentDevice(value:Device):void
		{
			_currentDevice = value;
		}

		public function playVideoOnCurrentDevice(vi : Image) : void
		{
			videoImage = vi;
			videoDisplay.x = currentDevice.x + currentDevice.screenSize.x;
			videoDisplay.y = currentDevice.y + currentDevice.screenSize.y;
			videoImage.width = currentDevice.screenSize.width;
			videoImage.height = currentDevice.screenSize.height;

			videoDisplay.addChild(videoImage);

		}


		public function initVideo() : void
		{
			videoDisplay = new Sprite();
			videoDisplay.x = 0;
			videoDisplay.y = 0;

			controlPanel.setControlPanelWidth(currentDevice.screenSize.width);

			addChild(videoDisplay);
			addChild(controlPanel);

//			videoDisplaySprite = new MediaDisplaySprite(currentDevice.screenSize.width, currentDevice.screenSize.height);
//			videoDisplaySprite.x = currentDevice.x + currentDevice.screenSize.x;
//			videoDisplaySprite.y = currentDevice.y + currentDevice.screenSize.y;
//			controlPanel.setControlPanelWidth(currentDevice.screenSize.width);
//			addChild(videoDisplaySprite);
//			addChild(controlPanel);


		}

		public function removeVideo() : void
		{
			//TODO: remove video from the stage and clean up when view tranisitions out
			removeChild(videoImage);
			removeChild(controlPanel);

		}

		public function setControlPanelTextureVo(vo : VideoControlPanelTexturesVo) : void
		{
			controlPanel.setTextureData(vo);
			controlPanel.x = currentDevice.x + currentDevice.screenSize.x;
			controlPanel.y = currentDevice.y + currentDevice.screenSize.y + currentDevice.screenSize.height - 50;
			controlPanel.setControlPanelWidth(currentDevice.screenSize.width);
		}


		public function updateScreenOnCurrentDevice(texture : Texture) : void
		{
			if (currentDevice != null)
			{
				currentDevice.updateScreen(texture);
			}

		}

		public function getPopUpPosition() : Point
		{
			return currentDevice.popUpPosition;
		}

		public function getCurrentDeviceScreenSize() : Rectangle
		{
			return currentDevice.screenSize;
		}


		public function get tap():TapGesture
		{
			return _tap;
		}

		public function set tap(value:TapGesture):void
		{
			_tap = value;
		}
	}
}
