<cfscript>
firstRoutes = [
    // Module Entry Point
    { pattern="/", handler="home", action="index" },
    { pattern="/test", handler="home", action="test" }
];

lastRoutes = [
    { pattern="/:handler/:action?" }
];

// include additional routes and append as done below to the routes array
include "catcher.cfm";

arrayEach(firstRoutes, function(element, index){
	routes.prepend(element);
});
arrayEach(lastRoutes, function(element, index){
	routes.append(element);
});

</cfscript>