<cfscript>
// routes for the catcher
catchRoutes = [
    { pattern="/morph/:id/:catchset?", handler="catch", action="morph" },
    { pattern="/build", handler="catch", action="build" }
];

// replace default general handler
lastRoutes = [
    { pattern="/:catch?", handler="catch", action="all" }
];

arrayEach(catchRoutes, function(element, index){
	routes.append(element);
});

</cfscript>