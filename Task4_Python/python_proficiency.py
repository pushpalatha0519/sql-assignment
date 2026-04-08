1 : def convert_minutes(minutes):
    hours = minutes // 60
    remaining_minutes = minutes % 60
    result = f"{hours} hr{'s' if hours != 1 else ''} {remaining_minutes} minute{'s' if remaining_minutes != 1 else ''}"
    return result

# Take input from user
minutes_input = int(input("Enter the number of minutes: "))
print("Converted Time:", convert_minutes(minutes_input))

OUTPUT : 
Enter the number of minutes: 130
Converted Time: 2 hrs 10 minutes

==================================================================================

2 : def remove_duplicates(s):
    unique_chars = ""
    for char in s:
        if char not in unique_chars:
            unique_chars += char
    return unique_chars

# Take input from user
string_input = input("Enter a string: ")
print("Unique String:", remove_duplicates(string_input))

OUTPUT : 
Enter a string: programming
Unique String: progamin
