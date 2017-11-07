<cfscript>
// routes for the catcher
catchRoutes = [
    { pattern="/morph/:id/:catchset?", handler="catch", action="morph" }
];

// replace default general handler
lastRoutes = [
    { pattern="/:catch?", handler="catch", action="all" }
];

arrayEach(catchRoutes, function(element, index){
	routes.append(element);
});

</cfscript>