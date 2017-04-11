/**
 * Created by russellmilburn on 28/07/15.
 */
package com.tro.chromecast.models
{

	import com.tro.chromecast.events.AppEvent;
	import com.tro.chromecast.interfaces.ISectionState;
	import com.tro.chromecast.models.states.section.AugRealitySection;
	import com.tro.chromecast.models.states.section.BackdropSection;
	import com.tro.chromecast.models.states.section.CastContentSection;
	import com.tro.chromecast.models.states.section.ConnectDeviceSection;
	import com.tro.chromecast.models.states.section.ConnectLaptopSection;
	import com.tro.chromecast.models.states.section.ConnectSection;
	import com.tro.chromecast.models.states.section.DiscoverMoreSection;
	import com.tro.chromecast.models.states.section.DoMoreSection;
	import com.tro.chromecast.models.states.section.EnjoySection;
	import com.tro.chromecast.models.states.section.ExitSection;
	import com.tro.chromecast.models.states.section.GuestModeSection;
	import com.tro.chromecast.models.states.section.InstructionSection;
	import com.tro.chromecast.models.states.section.IntroSection;
	import com.tro.chromecast.models.states.section.MirrorDeviceSection;
	import com.tro.chromecast.models.states.section.PlugInSection;
	import com.tro.chromecast.models.states.section.SectionEvent;
	import com.tro.chromecast.models.states.section.SectionList;
	import com.tro.chromecast.models.vos.DeviceTypeVo;
	import com.tro.chromecast.models.vos.NavigationBtnVo;
	import com.tro.chromecast.views.ViewList;
	import com.tro.chromecast.models.vos.TrackingVo;
	import com.gamua.flox.Flox;


	public class ApplicationModel extends AbstractModel
	{
		public static const INCOMING_VIEW_FROM_LEFT : String = "incomingViewFromLeft";
		public static const INCOMING_VIEW_FROM_RIGHT : String = "incomingViewFromRight";
		
		[Inject]
		public var introState : IntroSection;
		
		[Inject]
		public var arState : AugRealitySection;
		
		[Inject]
		public var instructionsState : InstructionSection;
		
		[Inject]
		public var enjoySection : EnjoySection;
		
		[Inject]
		public var exitSection : ExitSection;
		
		[Inject]
		public var connectSection : ConnectSection;
		
		[Inject]
		public var doMoreSection : DoMoreSection;
		
		[Inject]
		public var plugInSection : PlugInSection;
		
		[Inject]
		public var connectLaptop : ConnectLaptopSection;
		
		[Inject]
		public var connectDevice : ConnectDeviceSection;

		[Inject]
		public var backdropSection : BackdropSection;

		[Inject]
		public var discoverMore : DiscoverMoreSection;

		[Inject]
		public var castContent : CastContentSection;

		[Inject]
		public var mirrorDeviceSection : MirrorDeviceSection;

		[Inject]
		public var guestModeSeciton : GuestModeSection;
		
		private var _newSection : ISectionState;
		private var _currentView : String;
		private var _direction : String;
		
		private var _selectedDevice : String;
		private var _navigationBtnData : Array;
		private var _doMoreData : Array;
		private var _isMenuOpen : Boolean = true;
		private var _isReturningFromPreviousSection : Boolean = false;
		
		public function ApplicationModel()
		{
			super();
			
			_navigationBtnData = new Array();
		}
		
		public function setupMenu() : void
		{
			var showMe: NavigationBtnVo = new NavigationBtnVo();
			showMe.label = "Show Me";
			showMe.sectionName = SectionList.AR_SECTION;
			
			var plugIn: NavigationBtnVo = new NavigationBtnVo();
			plugIn.label = "Plug in";
			plugIn.sectionName = SectionList.PLUG_IN_SECTION;
			
			var connect: NavigationBtnVo = new NavigationBtnVo();
			connect.label = "Connect";
			connect.sectionName = SectionList.CONNECT_SECTION;
			
			var enjoy: NavigationBtnVo = new NavigationBtnVo();
			enjoy.label = "How To Cast";
			enjoy.sectionName = SectionList.ENJOY_SECTION;
			
			var doMore: NavigationBtnVo = new NavigationBtnVo();
			doMore.label = "Do More";
			doMore.sectionName = SectionList.DO_MORE_SECTION;
			
			var instructions: NavigationBtnVo = new NavigationBtnVo();
			instructions.label = "Instructions";
			instructions.sectionName = SectionList.INSTRUCTIONS_SECTION;
			
			var exit: NavigationBtnVo = new NavigationBtnVo();
			exit.label = "Exit";
			exit.sectionName = SectionList.EXIT_SECTION;
			
			_navigationBtnData.push(instructions);
			_navigationBtnData.push(showMe);
			_navigationBtnData.push(plugIn);
			_navigationBtnData.push(connect);
			_navigationBtnData.push(enjoy);
			_navigationBtnData.push(doMore);
			_navigationBtnData.push(exit);
			
			dispatch(new ApplicationModelEvent(ApplicationModelEvent.ON_SETUP_NAVIGATION));

			doMoreMenu();
		}


		private function doMoreMenu() : void
		{
			var discover : NavigationBtnVo = new NavigationBtnVo();
			discover.label = "Discover more apps";
			discover.sectionName = SectionList.DISCOVER_MORE;

			var backdrop : NavigationBtnVo = new NavigationBtnVo();
			backdrop.label = "Backdrop";
			backdrop.sectionName = SectionList.BACKDROP_SECTION;

			var guest : NavigationBtnVo = new NavigationBtnVo();
			guest.label = "Guest mode";
			guest.sectionName = SectionList.GUEST_MODE_SECTION;

			var mirror : NavigationBtnVo = new NavigationBtnVo();
			mirror.label = "Mirror your device";
			mirror.sectionName = SectionList.MIRROR_DEVICE_SECTION;

			var cast : NavigationBtnVo = new NavigationBtnVo();
			cast.label = "Cast your own content";
			cast.sectionName = SectionList.CAST_CONTENT_SECTION;

			_doMoreData = new Array();

			_doMoreData.push(discover);
			_doMoreData.push(backdrop);
			_doMoreData.push(guest);
			_doMoreData.push(mirror);
			_doMoreData.push(cast);

			dispatch(new ApplicationModelEvent(ApplicationModelEvent.ON_SETUP_DO_MORE_MENU));
		}

		
		public function updateVisitedSection(sectionId: String) : void
		{
			var evt : ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_SECTION_SELECTED);
			evt.selectedSection = sectionId;
			dispatch(evt);
		}
		
		//1. set new section
		public function setNewSection(state : ISectionState) : void
		{
			//logger.info("[INCOMING 1]: setNewSection");
			
			_newSection = state;
			_newSection.addEventListener(SectionEvent.SECTION_CONTINUE, onSectionContinue);
			_newSection.addEventListener(SectionEvent.SECTION_END, onSectionEnd);
			
			var evt : ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_UPDATE_SECTION);
			evt.selectedSection = _newSection.sectionName;
			dispatch(evt);
			
			nextView();
		}
		
		public function nextView() : void
		{
			_direction = INCOMING_VIEW_FROM_RIGHT;
			if (_isReturningFromPreviousSection)
			{
				_direction = INCOMING_VIEW_FROM_LEFT;
				_isReturningFromPreviousSection = false;
			}
			_newSection.nextView();
		}
		
		public function prevView() : void
		{
			_direction = INCOMING_VIEW_FROM_LEFT;
			_newSection.prevView();
		}
		
		private function onSectionContinue(event:SectionEvent):void
		{
			//logger.info("[INCOMING 3]: onSectionContinue");
			var viewName : String = _newSection.getViewName(_newSection.viewIndex);
			
			if (viewName == ViewList.AR_VIEW)
			{
				dispatch(new AppEvent(AppEvent.DISPLAY_USER_FEEDBACK_VIEW));
				prepareIncomingAugRealityView();
			}
			else
			{
				//logger.info("[INCOMING 3]: prepare incoming view");
				var evt : ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_PREPARE_INCOMING_VIEW);
				evt.viewName = viewName;
				evt.direction = _direction;
				dispatch(evt);
				setCurrentView(viewName);
			}
			
			if (isMenuOpen == true)
			{
				closeMenu();
			}
		}
		
		private function setCurrentView(incomingView : String) : void
		{
			//logger.info("[OUTGOING 1]: setCurrentView");
			
			if (_currentView == null)
			{
				_currentView = incomingView;
				return;
			}
			
			//logger.info("[OUTGOING 2]: dispatch outgoing event");
			
			if (_currentView == ViewList.AR_VIEW)
			{
				prepareOutgoingAugRealityView();
				_currentView = incomingView;
			}
			else
			{
				var evt : ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_PREPARE_OUTGOING_VIEW);
				evt.viewName = _currentView;
				evt.direction = _direction;
				dispatch( evt );
				
				if (_currentView == ViewList.CHOOSE_DEVICE_VIEW_A
					|| _currentView == ViewList.CHOOSE_DEVICE_VIEW_B
					|| _currentView == ViewList.CHOOSE_DEVICE_VIEW_C)
				{
					var trackingVo : TrackingVo = new TrackingVo();
					trackingVo.code = "SELECT_DEVICE";
					trackingVo.parameter = "Device";
					trackingVo.value = selectedDevice;
					
					var floxEvt : AppEvent = new AppEvent(AppEvent.TRACK_INTERACTION);
					floxEvt.trackingVo = trackingVo;
					dispatch(floxEvt);
				}
				
				_currentView = incomingView;
			}
		}
		
		private function onSectionEnd(event:SectionEvent):void
		{
			//logger.info("[INCOMING 4]: onSectionEnd");
			
			if (_newSection.viewIndex == _newSection.getNumberOfViews()-1)
			{
				logger.info("[END OF SECTION]");
				_newSection.isComplete = true;
				goToNextSection();
			}
			
			else if (_newSection.viewIndex == 0)
			{
				logger.info("[START OF SECTION]");
				goToPrevSection();
			}
		}
		
		private function goToPrevSection():void
		{
			var sectionName : String = null;
			
			switch (_newSection.sectionName)
			{
				case SectionList.CONNECT_LAPTOP_SECTION:
				case SectionList.CONNECT_DEVICE_SECTION:
					sectionName = SectionList.CONNECT_SECTION;
					break;
			}
			
			if (sectionName == null)
			{
				//end of section reached prompt user for action
				//throw new Error("When going to the next section, the sectionName name cannot be null");
				
				if (isMenuOpen == false)
				{
					openMenu();
				}
				
				return;
			}
			_isReturningFromPreviousSection = true;
			
			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			evt.sectionName = sectionName;
			dispatch(evt);
		}
		
		private function goToNextSection():void
		{
			var sectionName : String = null;
			
			switch (_newSection.sectionName)
			{
				case SectionList.INTRO_SECTION:
					sectionName = SectionList.AR_SECTION;
					break;
				case SectionList.CONNECT_SECTION:
						if (selectedDevice == DeviceTypeVo.LAPTOP)
						{
							sectionName = SectionList.CONNECT_LAPTOP_SECTION;
						}
						else
						{
							sectionName = SectionList.CONNECT_DEVICE_SECTION;
						}
					break;
			}
			
			if (sectionName == null)
			{
				//end of section reached prompt user for action
				//throw new Error("When going to the next section, the sectionName name cannot be null");
				
				if (isMenuOpen == false)
				{
					openMenu();
				}
				
				return;
			}
			var evt : AppEvent = new AppEvent(AppEvent.UPDATE_SECTION);
			evt.sectionName = sectionName;
			dispatch(evt);
		}
		
		private function prepareIncomingAugRealityView() : void
		{
			//this event has been moved to user feedback view.
//			var evt : ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_PREPARE_AUG_REALITY_VIEW);
//			evt.direction = _direction;
//			dispatch(evt);
			setCurrentView(ViewList.AR_VIEW);
		}
		
		private function prepareOutgoingAugRealityView() : void
		{
			var evt : ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_DISPOSE_AUG_REALITY_VIEW);
			evt.direction = _direction;
			dispatch(evt);
		}
		
		public function getSection(sectionName : String) : ISectionState
		{
			var section : ISectionState = null;
			switch (sectionName)
			{
				case SectionList.INTRO_SECTION:
					section = introState;
					break;
				case SectionList.AR_SECTION:
					section = arState;
					break;
				case SectionList.INSTRUCTIONS_SECTION:
					section = instructionsState;
					break;
				case SectionList.ENJOY_SECTION:
					section = enjoySection;
					break;
				case SectionList.CONNECT_SECTION:
					section = connectSection;
					break;
				case SectionList.CONNECT_LAPTOP_SECTION:
					section = connectLaptop;
					break;
				case SectionList.CONNECT_DEVICE_SECTION:
					section = connectDevice;
					break;
				case SectionList.PLUG_IN_SECTION:
					section = plugInSection;
					break;
				case SectionList.DO_MORE_SECTION:
					section = doMoreSection;
					break;
				case SectionList.BACKDROP_SECTION:
					section = backdropSection;
					break;
				case SectionList.DISCOVER_MORE:
					section = discoverMore;
					break;
				case SectionList.GUEST_MODE_SECTION:
					section = guestModeSeciton;
					break;
				case SectionList.CAST_CONTENT_SECTION:
					section = castContent;
					break;
				case SectionList.MIRROR_DEVICE_SECTION:
					section = mirrorDeviceSection;
					break;
				case SectionList.EXIT_SECTION:
					section = exitSection;
					break;
			}
			
			return section;
		}
		
		public function get selectedDevice():String
		{
			return _selectedDevice;
		}
		
		public function set selectedDevice(value:String):void
		{
			_selectedDevice = value;
			
			var evt :ApplicationModelEvent = new ApplicationModelEvent(ApplicationModelEvent.ON_UPDATE_DEVICE);
			evt.device =_selectedDevice;
			dispatch(evt);
		}
		
		public function get navigationBtnData():Array
		{
			return _navigationBtnData;
		}
		
		public function set navigationBtnData(value:Array):void
		{
			_navigationBtnData = value;
		}
		
		public function closeMenu() : void
		{
			dispatch(new ApplicationModelEvent(ApplicationModelEvent.CLOSE_MENU));
			isMenuOpen = false;
		}

		public function openMenu() : void
		{
			dispatch(new ApplicationModelEvent(ApplicationModelEvent.OPEN_MENU));
			isMenuOpen = true;
		}
		
		public function get newSection():ISectionState
		{
			return _newSection;
		}
		
		public function set newSection(value:ISectionState):void
		{
			_newSection = value;
		}
		
		public function get isMenuOpen():Boolean
		{
			return _isMenuOpen;
		}
		
		public function set isMenuOpen(value:Boolean):void
		{
			_isMenuOpen = value;
		}
		
		public function get currentSection() : ISectionState
		{
			return _newSection;
		}


		public function get direction():String
		{
			return _direction;
		}

		public function set direction(value:String):void
		{
			_direction = value;
		}


		public function get doMoreData():Array
		{
			return _doMoreData;
		}

		public function set doMoreData(value:Array):void
		{
			_doMoreData = value;
		}
	}
}
