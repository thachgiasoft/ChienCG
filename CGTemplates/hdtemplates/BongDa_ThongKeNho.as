﻿package  {
	
	import flash.display.MovieClip;
	import se.svt.caspar.template.CasparTemplate;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	import flash.text.TextFieldType;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	import flash.filters.*;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.display.DisplayObject;
	import flash.net.URLRequest;
	import flash.sampler.Sample;
	import flash.globalization.NumberFormatter;
	import flash.globalization.LocaleID;
		
	public class BongDa_ThongKeNho extends CasparTemplate{
		
		private var txtGroup:MovieClip = new MovieClip();
					
		public var thongsonhoChu:TextField = new TextField();
		public var thongsonhoKhach:TextField = new TextField();
		public var doichuShort:TextField = new TextField();
		public var doikhachShort:TextField = new TextField();	
		public function BongDa_ThongKeNho() {
			// constructor code
			super();							
			this.txtGroup.addChild(thongsonhoChu);
			this.txtGroup.addChild(thongsonhoKhach);
			this.txtGroup.addChild(doichuShort);
			this.txtGroup.addChild(doikhachShort);
			
			this.addChild(txtGroup);
			ExternalInterface.addCallback("UpdateData", UpdateData);
			ExternalInterface.addCallback("GetProperties", GetProperties);			
		}		
		
		private function Add(xmlStr:String, str:String, txt:TextField){
			xmlStr='<'+ str + ' id="'+ str + '"><data value="' + txt.text + '"/></' + str +'>';
			return xmlStr;
		}
		function GetProperties()
		{
			var xmlStr:String = "<Track_Property>";
			xmlStr +=Add(xmlStr, "thongsonhoChu", thongsonhoChu);
			xmlStr +=Add(xmlStr, "thongsonhoKhach", thongsonhoKhach);
				
			xmlStr += "</Track_Property>";
			
			ExternalInterface.call("Properties", xmlStr);
			return xmlStr;
		}
		function UpdateData(str:String)
		{
			var xml:XML = new XML(str);
			this.SetData(xml);
		}
		
		override public function SetData(xml:XML):void{
			for each (var element:XML in xml.children())
			{
				var property:String = element.@id;
				var data:String = element.data.@value;
				switch(property.toLowerCase())
				{						
					case "thongsonhoChu".toLowerCase():
						this.thongsonhoChu.text = data.toUpperCase();
						break;
					case "thongsonhoKhach".toLowerCase():
						this.thongsonhoKhach.text = data.toUpperCase();
						break;		
					case "doichuShort".toLowerCase():						
						this.doichuShort.text = data.toUpperCase();
						break;
					case "doikhachShort".toLowerCase():						
						this.doikhachShort.text = data.toUpperCase();
						break;
				}
			}
		}
		public override function Play():void{
			gotoAndPlay('start');
		}
		public override function Stop():void{
			gotoAndPlay('stop');
		}		
	}
	
}
