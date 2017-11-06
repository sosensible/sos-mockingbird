/**
* A normal ColdBox Event Handler
*/

component{

	property name="MockData" inject="MockData@MockDataCFC";

	function index(event,rc,prc){
		local.params = {num:'rnd:7',user:"name", email:"email"};
		prc['person'] = mockData.mock(argumentcollection:params);

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
