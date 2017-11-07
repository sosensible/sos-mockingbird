<cfoutput>
<form action="/api/build" encrypt="multipart/form-data" method="POST">
    <h1>API Endroute Builder</h1>
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
    <table class="seg_#segment#">
        <caption>Route file.</caption>
        <thead>
            <tr>
                <th>routes/#segment#.cfc
                </th>
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
    <br>
    <table class="seg_#segment#">
        <caption>Handler file.</caption>
        <thead>
            <tr>
                <th>handlers/#segment#.cfm</th>
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