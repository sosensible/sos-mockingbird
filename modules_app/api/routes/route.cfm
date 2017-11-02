<cfscript>
routes = [];
firstRoutes = [
    // Module Entry Point
    { pattern="/", handler="home", action="index" },
    { pattern="/test", handler="home", action="test" },
    {pattern:"/one/more/time",handler:"home",action:"test"},
    {pattern:"/show/the/wife", handler:"home", action:"impress"},
    {pattern:"/show/the/wife/data", handler:"home", action:"data"}
];
// include additional routes and append as done below to the routes array
// include "other-routes.cfm";
lastRoutes = [
    // Convention Route
    // { pattern="/:handler/:action?" },
    { pattern="/:catch?", handler="catch", action="all" }
];
arrayEach(firstRoutes, function(element, index){
	routes.prepend(element);
});
arrayEach(lastRoutes, function(element, index){
	routes.append(element);
});
</cfscript>