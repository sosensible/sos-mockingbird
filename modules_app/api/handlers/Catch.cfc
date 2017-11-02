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
			structDelete(SESSION,'handler');
		}
		this.setDefaultHandlers();
		/*** matchLen can only be less than pattern for ? cases ***/
		try{
			retValue = this.match( route, SESSION.handler.active, verb );
			
			if(retValue.statusCode = 999) {
				this.addMissingHandler(SESSION.handler.missing, route, verb);
				// dump(var:session.handler, format:'classic', label: 'handler sets');
				rc.missingHandlers = SESSION.handler.missing;
				event.setView( 'mockingbird/missing' );
			} else {
				event.renderData(data: retValue.response, statusCode: retValue.statusCode, type="json");
			}
		} catch (e){
			dump(var:e, format:'classic');
			dump(var:session.handler, format:'classic', label: 'handlers');
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
		// dump(var: response, format: 'classic', label:'response value');
		// match first handler that aligns with the route.
		// dump(var: handlers, format: 'classic', label:'handlers preloop');

		for (handler in handlers) {
			match = false;
			matchLen = arrayLen(handler.pattern);
			matchSet = [];

			try{
				if(!handler.verb.len() || handler.verb.contains(verb)) {
					if(routeLen >= handler.matchLen) {
						// writeOutput('<hr>handler (#handler.matchLen#) LTE route (#routeLen#)<hr>');
						match = true;
						rc = {};
						for(i = 1; i <= matchLen; i++){
							item = handler.pattern[i];
							// writeOutput('<hr>#route[i]# : #item#<br>');
							if(right(item, 1) == '?') {
								if(left(item, 1) == ':') {
									item = right(item, len(item) -1);
									rc[item] = route[i];
								}
							}  else {
								// writeOutput('<hr>no ?<br>');
								if(route[i] != item) {
									// writeOutput('<hr>item not match<br>');
									if(left(item, 1) == ':') {
										// writeOutput('<hr>substite<br>');
										// writeOutput('<hr>#item# as #route[i]#<hr>');
										item = right(item, len(item) -1);
										rc[item] = route[i];
									} else {
										// writeOutput('<hr>match item<br>');
										// writeOutput('#item#<br>');
										match = false;
										i = matchLen;
									}
								} else {
									// writeOutput('#item#<br>');
								}
							}
							if(i == matchLen && match) {
								response = handler.response;
								return { response:response.content, statusCode: response.statusCode, rc: rc };
							}
						}
						// writeOutput('<hr>');
					} else {
						// writeOutput('<hr>handler len GT route len<hr>');
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
		
		// writeOutput('<hr>end match check<hr>');

		return { response:response.content, statusCode: response.statusCode, rc: rc };
	}

	private void function addMissingHandler(missingHandlers, route, verb) {
		// dump(var:missingHandlers, format: 'classic', label: 'missingHandlers');abort;
		verb = 'POST';
		LOCAL.handler = [];
		LOCAL.routesMatch = false;
		LOCAL.i = 0;
		for(i=1; i <= missingHandlers.len(); i++){
			// writeOutput('start handler loop check (#i#)');
			// cfflush();
			handler =  missingHandlers[i];
			// writeOutput('<hr>');
			// cfflush();
			// dump(var:{logic: true || handler.matchlen, count: missingHandlers.len(), route:route, handler:handler, verb: handler.verb, route:handler.pattern}, format: 'classic', label: 'missHandler[#i#]');
			// cfflush();
			// if( i == 3 ) {
			// 	dump(var:{logic:this.doRoutesMatch(route, handler.pattern, handler.matchLen)}, format: 'classic', label: 'logic');
			// 	cfflush();
				// abort; 
			// }
			// handler.matchlen && 
			// if( i == 3 ) { return; }
			routesMatch = this.doRoutesMatch(route, handler.pattern, handler.matchLen);
			// writeOutput(routesMatch);
			// cfflush();
			if( routesMatch ){
				// return;
				// dump(var:{ route:route, handler:handler, verb: handler.verb, routeSet:handler.pattern}, format: 'classic', label: 'missHandler[#i#]');
				if( !handler.verb.findNoCase( verb ) ){
					handler.verb.append( verb );
				}
				// abort;
				return;
			}
			// writeOutput('<br>end handler loop check (#i#)');
			// cfflush();
			// if( i == 3 ) { return; }
		}
		// writeOutput('post handler loop check');
		// cfflush();
		// return;
		session.handler.missing.append({
			'id': createGUID(),
			'pattern': route,
			'matchlen': route.len(),
			'verb': [ verb ],
			'response': {},
			'route': '{pattern:"/#route.toList('/')#", handler:"handlerName", action:"#route.first()#"}'
		});
	}

	private any function doRoutesMatch(endPointRoute, checkRoute, matchLen) {
		LOCAL.i = 0;
		// dump(
		// 	var:{
		// 		args:arguments, 
		// 		epr: endPointRoute.len(), 
		// 		cr: checkRoute.len()
		// 	}, 
		// 	format:'classic', 
		// 	label:'doRoutesMatch'
		// );
		if( endPointRoute.len() <> checkRoute.len() ){
			return false;
		} else {
			for(i=1; i <= endPointRoute.len(); i++){
				// dump(var: {ep: endPointRoute[i], cr: checkRoute[i]}, format:'classic');
				if(endPointRoute[i] != checkRoute[i]){
					return false;
				}
			}
		}
		return true;
	}

	private void function setDefaultHandlers() {
		
		if(!structKeyExists(session, 'handler')){
			SESSION['handler'] = {
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
