<cfoutput>
    <h1>API Endroute Builder</h1>
    <h2>morph build</h2>
    
    <table>
        <caption>Updates for _.cfc routes file.</caption>
        <thead>
            <tr>
                <th>routes/_.cfc</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <textArea class="fullwidth"><cfloop item="handler" collection="#prc.handler#">include "#handler#.cfm";
</cfloop></textArea>
                </td>
            </tr>
        </tbody>
    </table>
            <!--- <cfdump var="#handler#"><cfabort> --->
<cfloop item="handler" collection="#prc.handler#">

    <br>
    <h3>Route: #handler#</h3>
    <table>
        <caption>Route file.</caption>
        <thead>
            <tr>
                <th>routes/#handler#.cfc</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <textArea class="fullwidth"><cfloop item="action" collection="#prc.handler[handler]#">
    function #action#(event,rc,prc){
        local.data = {
            'result': '#handler#/#action# results'
        };
        // event.setView( "#handler#/#action#" );
        event.renderData( data: data, statusCode: 200, type="json", statusMessage: "#handler#/#action#" );
    }
</cfloop></textArea>
                </td>
            </tr>
        </tbody>
    </table>
    <br>
    <h3>Handler: #handler#</h3>
    <table>
        <caption>Handler file.</caption>
        <thead>
            <tr>
                <th>handlers/#handler#.cfm</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <textArea class="fullwidth">&lt;cfscript><cfloop item="action" collection="#prc.handler[handler]#"><cfset endpath = prc.handler[handler][action]>
{ pattern: "#endpath.pattern#", handler: "#endpath.handler#", action: "#endpath.action#" },</cfloop>
&lt;/cfscript>
                    </textArea>
                </td>
            </tr>
        </tbody>
    </table>
</cfloop>
</cfoutput>
<style>
table {
    width: 100%;
    border: solid black 1px;
}

table td, table th {
    padding: 6px;
}

.fullwidth {
    width: 100%;
}

textArea {
    min-height:160px;
}