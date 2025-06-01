# VJSON
'UnrealEngine.com/JSON' module extension.

# Example
```
# Creating an array to represent a weapon
WeaponBuilder := json_array_builder{}
    .Append("Scar") # Appends to the array
    .Append(5)
    .Append(36.0)

# Creating an object to represent a character
CharacterBuilder := json_object_builder{}
    .Set("name", "Jonesy") # Sets a property in the object
    .Set("age", 32)
    .Set("weapon", WeaponBuilder) # Calls .Build

# Returns a json object string
JSONStr := CharacterBuilder.Build()

# Parsing the object and array
if:
    Obj := JSONStr.AsValue[].AsObject[]
    Name := Obj["name"].AsString[]
    Age := Obj["age"].AsInt[]

    # Getting and parsing the array
    Weapon := Obj["weapon"].AsArray[]
    WeaponName := Weapon[0].AsString[]
    WeaponRarity := Weapon[1].AsInt[]
    WeaponDamage := Weapon[2].AsFloat[]
```
