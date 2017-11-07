/**
* A normal ColdBox Event Handler
*/
component{

	function all(event,rc,prc){
		LOCAL.routePath = event.getCurrentRoutedURL();
		LOCAL.route = listToArray(routePath,"/");
		LOCAL.verb = event.getHTTPMethod();
		LOCAL.retValue = {};
		this.setDefaultHandlers();
		if(arrayLen(route) && route[1] == event.getCurrentModule()) {
			route.deleteAt(1);
		}
		if(route.first() == 'clear'){
			structDelete(application,'handler');
		}
		this.setDefaultHandlers();
		/*** matchLen can only be less than pattern for ? cases ***/
		try{
			retValue = this.match( route, application.handler.active, verb );
			
			if(retValue.statusCode = 999) {
				this.addMissingHandler(application.handler.missing, route, verb);
				// dump(var:application.handler, format:'classic', label: 'handler sets');
				rc.missingHandlers = application.handler.missing;
				event.setView( 'mockingbird/missing' );
			} else {
				event.renderData(data: retValue.response, statusCode: retValue.statusCode, type="json");
			}
		} catch (e){
			dump(var:e, format:'classic');
			dump(var:application.handler, format:'classic', label: 'handlers');
			dump(var:retValue, format:'classic');
			abort;
		}
	}

	private function match(route, handlers, verb) {
		LOCAL.handler = {};
		LOCAL.i = "";
		LOCAL.match = true;
		LOCAL.matchLen = 0;
		LOCAL.routeLen = arrayLen(route);
		LOCAL.minMatchLoops = min(arrayLen(handler),routeLen);
		LOCAL.rc = {};
		LOCAL.response = {
			content: "",
			statusCode = 999
		};
		LOCAL.handler = {};
		LOCAL.matchSet = [];

		for (handler in handlers) {
			match = false;
			matchLen = arrayLen(handler.pattern);
			matchSet = [];

			try{
				if(!handler.verb.len() || handler.verb.contains(verb)) {
					if(routeLen >= handler.matchLen) {
						match = true;
						rc = {};
						for(i = 1; i <= matchLen; i++){
							item = handler.pattern[i];
							if(right(item, 1) == '?') {
								if(left(item, 1) == ':') {
									item = right(item, len(item) -1);
									rc[item] = route[i];
								}
							}  else {
								if(route[i] != item) {
									if(left(item, 1) == ':') {
										item = right(item, len(item) -1);
										rc[item] = route[i];
									} else {
										match = false;
										i = matchLen;
									}
								} 
							}
							if(i == matchLen && match) {
								response = handler.response;
								return { response:response.content, statusCode: response.statusCode, rc: rc };
							}
						}
					}
				} else {
					return {
						response: 'no matching endpoint for type ( #verb# )',
						statusCode: 409,
						rc: rc
					};
				}
			} catch(e) {
				dump(var: handler, format: 'classic', label: 'handler');
				dump(var: route, format: 'classic', label: 'route');
				dump(var: i, format: 'classic', label: 'i');
				dump(var: routeLen, format: 'classic', label: 'routeLen');
				abort;
			}
		}

		return { response:response.content, statusCode: response.statusCode, rc: rc };
	}

	private void function addMissingHandler(missingHandlers, route, verb) {
		verb = 'POST';
		LOCAL.handler = [];
		LOCAL.routesMatch = false;
		LOCAL.i = 0;
		for(i=1; i <= missingHandlers.len(); i++){
			handler =  missingHandlers[i];
			routesMatch = this.doRoutesMatch(route, handler.pattern, handler.matchLen);
			if( routesMatch ){
				if( !handler.verb.findNoCase( verb ) ){
					handler.verb.append( verb );
				}
				return;
			}
		}
		application.handler.missing.append({
			'id': createGUID(),
			'pattern': route,
			'matchlen': route.len(),
			'verb': [ verb ],
			'response': {},
			'route': '{pattern:"/#route.toList('/')#", handler:"handlerName", action:"#route.first()#"}'
		});
	}

	function morph(event,rc,prc){
		if(structKeyExists(rc,'catchset')){
			local.template = {};
			try {
				include "../template/#rc.catchset#.cfm";
				event.setView( "mockingbird/morphform" );
			} catch(e) {
				writeOutput('Invalid address');
				abort;
			}
		}
		// writeDump(var: rc, format: 'classic');
		// abort;
	}

	function build(event,rc,prc){

		event.setView( "mockingbird/build" );
	}

	private function pickOutHandler(handlers:APPLICATION.handler, id){

	}

	private any function doRoutesMatch(endPointRoute, checkRoute, matchLen) {
		LOCAL.i = 0;
		if( endPointRoute.len() <> checkRoute.len() ){
			return false;
		} else {
			for(i=1; i <= endPointRoute.len(); i++){
				if(endPointRoute[i] != checkRoute[i]){
					return false;
				}
			}
		}
		return true;
	}

	private void function setDefaultHandlers() {
		
		if(!structKeyExists(application, 'handler')){
			application['handler'] = {
				'missing': [],
				'active': [
					{
						'pattern': [
							"fred",
							"asdf"
						],
						'matchLen': 2,
						'verb': [],
						'response': {
							'content':'QUI',
							'statusCode': 400
						}
					},
					{
						'pattern': [
							"fred",
							":reply"
						],
						'matchLen': 2,
						'verb': [],
						'response': {
							'content':'another',
							'statusCode': 201
						}
					},
					{
						'pattern': [
							"fred"
						],
						'matchLen': 1,
						'verb': ['GET'],
						'response': {
							'content':'yes',
							'statusCode': 200
						}
					}
				]
			};
		}
	}

}
