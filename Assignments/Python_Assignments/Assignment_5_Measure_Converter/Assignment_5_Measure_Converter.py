# Assignment_5_Measure_Converter
# This script takes temperature in Celsius then converts the entered value into Fahrenheit and prints the result.
# This script takes distance in kilometers then converts the entered value into miles and prints the result.

celcius = float(input("What is the temperature in Celcius = "))
fahrenheit = celcius * 180 / 100 + 32
print ("Temperature in Fahrenheit", fahrenheit)
print()

kilometers = float(input("What is the distance in km = "))
miles = kilometers / 1.609
print ("Distance in Miles", miles)