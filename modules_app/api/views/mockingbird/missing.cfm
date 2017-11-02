<h1>Welcome to my cool Mockingbox missing route page!</h1>
<table class="routes">
    <thead>
        <tr>
            <th>Route</th>
            <th>Count</th>
            <th>Response</th>
            <th>Verbs</th>
            <th>Action</th>
            <th>Route</th>
        </tr>
    </thead>
<cfloop index="handler" array="#rc.missingHandlers#">
    <tbody>
        <tr>
            <td><cfdump var="#handler.pattern#"></td>
            <td><cfoutput>#handler.matchlen#</cfoutput></td>
            <td><cfdump var="#handler.response#"></td>
            <td><cfdump var="#handler.verb#"></td>
            <td><cfoutput><a href="/api/morph/#handler.id#">Morph</a></cfoutput></td>
            <td><cfoutput>#handler.route#</cfoutput></td>
        </tr>
    </tbody>
</cfloop>
</table>

<style>
.routes { min-width: 600px; }
.routes td {
    border: solid black 1px;
    padding: 6px;
    vertical-align: top;
}
</style>
