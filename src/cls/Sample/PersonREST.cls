Class Sample.PersonREST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/:id" Method="GET" Call="GetPerson"/>
<Route Url="/:id" Method="PUT" Call="UpdatePerson"/>
<Route Url="/:id" Method="DELETE" Call="DeletePerson"/>
<Route Url="/" Method="POST" Call="CreatePerson"/>
</Routes>
}

/// This method returns the class text for the named class
ClassMethod GetPerson(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException


    #; Set the response header to plain text
    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set person = ##class(Sample.Person).%OpenId(id)

    if '$IsObject(person) Quit ..Http404()

    d person.%JSONExport()

    Quit tSC
}

ClassMethod CreatePerson() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    set person=##class(Sample.Person).%New()
    set data={}.%FromJSON(%request.Content)
    

    $$$TOE(tSC,person.%JSONImport(data))
    $$$TOE(tSC,person.%Save())
    
    set %response.Status=204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    //d data.%ToJSON()
    d person.%JSONExport()

    Quit tSC
}

ClassMethod UpdatePerson(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    set person=##class(Sample.Person).%OpenId(id)
    if '$IsObject(person) Return ..Http404()
    set data={}.%FromJSON(%request.Content)
    

    $$$TOE(tSC,person.%JSONImport(data))
    $$$TOE(tSC,person.%Save())
    
    set %response.Status=200

    Set %response.ContentType = ..#CONTENTTYPEJSON
    d person.%JSONExport()

    Quit tSC
}

ClassMethod DeletePerson(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    set person=##class(Sample.Person).%OpenId(id)
    if '$IsObject(person) Return ..Http404()
    
    $$$TOE(tSC,person.%DeleteId(id))
    
    set %response.Status=200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

}
