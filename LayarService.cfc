<!--- 
	Name: LayarService.cfc
	Purpose: A Layar Service Provider template CFC. Creates the JSON request needed for Layar. 
	Notes:
	The Layar API currently accepts only JSON response format. 
	Visit http://layar.pbworks.com/ to learn more about Layar
	Visit my blog to learn how to create you own Layer 
	http://www.cfcoffee.co.uk/index.cfm/2010/7/4/Creating-a-simple-Layar-with-ColdFusion-a-step-by-step-tutorial
	any feedback welcome!
 --->
<cfcomponent output="false" hint=" A Layar Service Provider Example">
	<cffunction
		name="GetPointsOfInterest"
		access="remote"
		returntype="struct"
		returnformat="JSON"
		output="false"
		hint="This call is used to request the points of interest to be displayed for a particular layer">
		

		<!--- Data from Layar --->
		<cfargument name="userId"
    	 hint="Unique ID of the end-user, anonymized"
    	 required="yes" 
   	     type="string">
   	      	     
   	     <cfargument name="developerId"
    	 hint="Developer Id"
    	 required="yes" 
   	     type="string">
   	     
   	     <cfargument name="developerHash"
    	 hint="This hash is passed in the request as a simple method to verify the authenticity of the request"
    	 required="yes" 
   	     type="string">
   	     
   	     <cfargument name="timestamp"
    	 hint="Unique timestamp to hash the key timestamp=1242207092430"
    	 required="yes" 
   	     type="numeric">
   	     
   	     <cfargument name="layerName"
    	 hint="Identifier of the layer"
    	 required="yes" 
   	     type="string">
   	     
   	     <cfargument name="lat"
    	 hint="Latitude of current position (GPS coordinate)"
    	 required="yes" 
   	     type="string">
   	     
   	     <cfargument name="lon"
    	 hint="Longitude of current position (GPS coordinate"
    	 required="yes" 
   	     type="string">
   	     
   	     <cfargument name="accuracy"
    	 hint="Optional: the accuracy of the current location, as given by the device."
    	 required="no" 
   	     type="numeric">
   	     
   	     <cfargument name="radius"
    	 hint="Optional: the optionid corresponding to the value of the radio button list option selected by the user"
    	 required="no" 
   	     type="numeric">

			<cfscript>
			var response  = StructNew();
			var obj = {};
			var objAct = {};
			response['hotspots'] = [];

			//Place First POI START:
			
			//The distance of the POI to the current location
			obj['distance'] = "0"; 
			//A unique id for the POI within the layer, this is used to track the POI's when refreshing the list.
			obj['id']= "1";
			//Altitude in meters of the object with respect to the user's altitude.
			obj['relativeAlt']= "0";
			//The first line in the BIW, larger font, underlined, using titleColor.
			obj['title']= "Example Layer for Layar!";
			//The second line in the BIW
			obj['line2']= "Second Line Text";
			//The third line in the BIW,
			obj['line3']= "Third Line text";
			//The fourth line in the BIW
			obj['line4']= "Fourth Line Text";
			//The last line in the BIW, small font using textColor
			obj['attribution'] ="Look I Have A Layer!";
			
			//The integer value of the longitude/latitude for the POI: divide by 10^6 to get the decimal 
			//GPS coordinate value. Can be negative. In this example 4.882420
			
			//Latitude of current position (GPS coordinate) example takes user current location
			obj['lat']= "#ceiling((arguments.lat * 1000000)+ 50)#";
			//longitude of current position (GPS coordinate)example takes user current location
			obj['lon']= "#ceiling((arguments.lon * 1000000)+ 50)#";
			//The location of the image to be displayed inside the BIW
			obj['imageURL']= "http://www.domain.co.uk/image.png";
			//Altitude in meters of the object with respect to the user's altitude.
			obj['alt']= "0";
			//he type of POI, from which the client determines which CIW to use if custom CIWs are defined. 
			//0 = default CIW. 1-3 = use the custom CIW icons specified in the layer definition (custom_ciws)
			obj['type']= "1";
			//The size of the object in m. This is the length of the edge of the smallest cube in which 
			//the object can fit. This is used by the client to determine when it can switch from 'icon' 
			//to 'reduced' to 'full'. So it's not required to be very precise.
			obj['size']= "1";                         
      	    //2D 3D Suppoted in v3 ONLY!
            obj['dimension']= "1";
			
				//2D and 3D example if dimension above is 2 or 3 
	/*          obj['object']=  [];
				//The URL to base the paths to the various objects on
	            objAct['baseURL'] = "http://www.domain.co.uk/";
				//The 2d object representation when it is far away. This is just an icon and won't use the direction vector. 
				//Use a 32x32 PNG file here.
	            objAct['icon'] = "bluesilhouetteTEST.png";
				//The object representation when it is closes to the user (full view of the object, up to about 50 m). 
				//The relative path to the file or relative URL to call in order to fetch the object.
	            //objAct['full'] = "test.l3d";
				//Size of object
				objAct['size'] = "30";
	            obj['object'] = objAct;  
	            objAct = {};
				                                 
	            // v3 Transform 
	            obj['transform']=  [];
				//If this value is true, the rotation is calculated relative to the position of the user: 
				//the object will always face the user in the same way regardless of the absolute direction. 
				//In most cases angle will be 0 when rel is true
	            objAct['rel'] = "true";
				//Rotation angle in degrees to rotate the object around the z-axis.
	            objAct['angle'] = "45";]
				//The size of 3d objects is determined by the object themselves (unit of the coordinate system is 1m). 
				//For 2d objects, 200 pixels is 1m. This scale factor is to be used to scale the object to different sizes.
	            objAct['scale'] = "1.0";
				
	            obj['transform'] = objAct;  
	            objAct = {};*/


			//Actions upto 3-4 actions per POI
			obj['actions']=  [];
			objAct['uri'] = "http://www.google.co.uk";
			//If specified, the text will be displayed in the button corresponding to the action.
			objAct['label'] = "Visit Google";
			arrayAppend(obj['actions'],objAct);  
			

		    //MORE POI's AND ACTIONS HERE
			
			//END

			//END OF HOTSPOTS
			arrayappend(response['hotspots'],obj);
			

			//Settings
			//The name of the layer for which the POI's are returned
			response['layer'] = "myLayer";
			//If an error condition occurs, this will be notified using the error code.
			response['errorString']='ok'; 
			//(optional) Whether more pages can be fetched.
 			response['morePages']='false';
			//f an error condition occurs, this will be notified using the error code. N
			response['errorCode']= '0'; 
			//(optional) The key to the page being returned. Pass this key to the page parameter in the request if the next page is requested.
			response['nextPageKey']='null';

			</cfscript>
		<!--- Return response  --->
		<cfreturn response  />
	</cffunction>
</cfcomponent>