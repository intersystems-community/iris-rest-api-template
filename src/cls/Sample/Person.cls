Class Sample.Person Extends (%Persistent, %JSON.Adaptor, %Populate)
{

Property Name As %VarString [ Calculated, SqlComputeCode = {set {Name}={FirstName}_" "_{LastName}}, SqlComputed ];

Property LastName As %VarString;

Property FirstName As %VarString;

Property Phone As %VarString;

Property DOB As %Date(MAXVAL = "$piece($horolog, "","", 1)");

/// Index for LastName,FirstName
Index NameIndex On (LastName, FirstName);

/// Index for property DOB
Index DOBIndex On DOB;

ClassMethod AddTestData(amount As %Integer)
{
    d ..Populate(amount)
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>LastName</Value>
</Value>
<Value name="3">
<Value>FirstName</Value>
</Value>
<Value name="4">
<Value>Phone</Value>
</Value>
<Value name="5">
<Value>DOB</Value>
</Value>
</Data>
<DataLocation>^Sample.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^Sample.PersonD</IdLocation>
<IndexLocation>^Sample.PersonI</IndexLocation>
<StreamLocation>^Sample.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
