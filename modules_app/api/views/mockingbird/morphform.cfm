<cfoutput>
<form action="/api/build" encrypt="multipart/form-data" method="POST">
    <h1>API Endroute Builder Form</h1>
    <h2>morph (#ucase(rc.catchset)#) set</h2>
    
    <!--- <table>
        <caption>Updates for _.cfc routes file.</caption>
        <thead>
            <tr>
                <th>routes/_.cfc</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <textArea class="fullwidth"></textArea>
                </td>
            </tr>
        </tbody>
    </table>
    <br> --->
    <cfloop item="segment" collection="#prc.set#">
    <h3>Segment: #segment#</h3>
    
    <label for="seg_#segment#">
        <input type="checkbox" name="routes" value="#segment#" id="seg_#segment#" checked="1">
        Include #segment# segment
    </label>
    <table class="seg_#segment# fullwidth">
        <caption>Route file.</caption>
        <thead>
            <tr>
                <th colspan="2" class="sec_head">
                    routes/#segment#.cfc
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>
                    Handler
                </th>
                <td>
                    <input type="text" name="#segment#_handler" class="fullwidth" value="#prc.set[segment].handler.name#">
                </td>
            </tr>
        <tbody>
            <tr>
                <th>
                    Action
                </th>
                <td>
                    <input type="text" name="#segment#_action" class="fullwidth" value="#prc.set[segment].handler.action#">
                </td>
            </tr>
        <tbody>
            <tr>
                <th>
                    Verb
                </th>
                <td>
                    <input type="text" name="#segment#_verb" class="fullwidth" value="#prc.set[segment].handler.verb#">
                </td>
            </tr>
        </tbody>
        <thead>
            <tr class="sec_head">
                <th colspan="2">handlers/#segment#.cfm</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>
                    EndPath (Pattern)
                </th>
                <td>
                    <input type="text" name="#segment#_endpath" class="fullwidth" value="#prc.set[segment].route.endpath#">
                </td>
            </tr>
        </tbody>
    </table>
    <br>
    </cfloop>
    <input type="submit" value="Build Code">

</form>
<!--- <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script> --->
<!--- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> --->
<script><cfloop item="segment" collection="#prc.set#">
    jQuery('##seg_#segment#').on('click',function(){
        jQuery('.seg_#segment#').toggle();
    });</cfloop>
</script>

</cfoutput>
<style>
table {
    width: 100%;
    border: solid black 1px;
}

table td, table th {
    padding: 6px;
}
.sec_head {
    color: blue;
}

.fullwidth {
    width: 100%;
}

textArea {
    min-height:160px;
}

input[type=submit] {
    float:right;
}
</style>