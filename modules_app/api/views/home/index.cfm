<h1>Welcome to my cool Mockingbox API page!</h1>
<p>Stuff</p>
<cfoutput>
<ol><cfloop item="i" collection="#prc.person#">
    <li>#prc.person[i].user# (email: #prc.person[i].email#)</li>
</cfloop></ol>
</cfoutput>
