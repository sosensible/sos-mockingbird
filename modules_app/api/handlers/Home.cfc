/**
* A normal ColdBox Event Handler
*/
component{

	function index(event,rc,prc){
		event.setView( "home/index" );
	}

	function data(event,rc,prc){
		event.renderData(data: session, statusCode: 200, type="json");
	}

	function impress(event,rc,prc){
		event.setView( "home/impress" );
	}
	
	function test(event,rc,prc){
		event.setView( "home/test" );
	}

	function onInvalidEvent(event, rc, prc){
		event.setView( "home/test" );
	}

}
