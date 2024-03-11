dotnet
{
    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Collections.Generic.List`1"; "List_Of_T")
        {
        }
    }

    assembly("System.Xml")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Xml.XmlProcessingInstruction"; "XmlProcessingInstruction")
        {
        }

        type("System.Xml.XmlDocument"; "XmlDocument")
        {
        }

        type("System.Xml.XmlNode"; "XmlNode")
        {
        }
    }

}
