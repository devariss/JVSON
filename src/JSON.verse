JSON<public> := module:
    # Extension module for Unreal Engine's JSON module with string builders.

    using { /UnrealEngine.com/JSON }

    # Type that represents a json value.
    json_value<public> := value

    # Parses a string to a json value. Fails if 'Str' is not a valid JSON string.
    (Str: string).AsValue<public>()<decides><transacts>: json_value = Parse[Str]

    # Mutable json object string builder.
    json_object_builder<public> := class:
        var Properties<private>: [string]string = map{}

        Build<public>()<transacts>: string =
            Length := Properties.Length
            var JSONString: string = "\{"
            var Index: int = 0
            for (Key->Value : Properties):
                set JSONString += "\"{Key}\":{Value}" + if (Index < Length - 1) then "," else ""
                set Index += 1
            JSONString + "\}"

        Set<public>(Key: string, Value: int)<transacts>: json_object_builder = SetProperty(Key, "{Value}")
        
        Set<public>(Key: string, Value: float)<transacts>: json_object_builder = SetProperty(Key, "{Value}")

        Set<public>(Key: string, Value: string)<transacts>: json_object_builder = SetProperty(Key, "\"{Value}\"")

        Set<public>(Key: string, Value: json_array_builder)<transacts>: json_object_builder = SetProperty(Key, Value.Build())

        Set<public>(Key: string, Value: json_object_builder)<transacts>: json_object_builder = SetProperty(Key, Value.Build())

        SetProperty<private>(Key: string, Value: string)<transacts>: json_object_builder = 
            (set Properties[Key] = Value) or ()
            Self

    # Mutable json array string builder.
    json_array_builder<public> := class:
        var Properties<private>: [string]void = map{}

        Build<public>()<transacts>: string =
            Length := Properties.Length
            var JSONString: string = "["
            var Index: int = 0
            for (Value->None : Properties):
                set JSONString += "{Value}" + if (Index < Length - 1) then "," else ""
                set Index += 1
            JSONString + "]"

        Append<public>(Value: int)<transacts>: json_array_builder = AppendValue("{Value}")
        
        Append<public>(Value: float)<transacts>: json_array_builder = AppendValue("{Value}")

        Append<public>(Value: string)<transacts>: json_array_builder = AppendValue("\"{Value}\"")

        Append<public>(Value: json_array_builder)<transacts>: json_array_builder = AppendValue(Value.Build())

        Append<public>(Value: json_object_builder)<transacts>: json_array_builder = AppendValue(Value.Build())

        AppendValue<private>(Value: string)<transacts>: json_array_builder = 
            (set Properties[Value] = void) or ()
            Self
