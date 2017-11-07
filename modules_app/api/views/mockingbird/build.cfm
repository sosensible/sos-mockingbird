<cfoutput>
    <h1>API Endroute Builder</h1>
    <h2>morph build</h2>
    <p>##</p>
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
                    <textArea class="fullwidth"></textArea>
                </td>
            </tr>
        </tbody>
    </table>
    <br>
    <h3>Route: ##</h3>
    <table>
        <caption>Route file.</caption>
        <thead>
            <tr>
                <th>routes/##.cfc</th>
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
    <h3>Handler: ##</h3>
    <table>
        <caption>Handler file.</caption>
        <thead>
            <tr>
                <th>handlers/##.cfm</th>
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