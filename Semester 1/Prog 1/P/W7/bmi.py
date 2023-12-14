def bmi (bodyweight, bodylength):
    """inputs:
     bodyweight in kg
     bodylength in cm"""
    result = bodyweight/(bodylength/100)**2
    return result

bodyweight = int(input("input your bodyweight in kg:"))
bodylength = int(input("input your bodylength in cm:"))
print("your bmi is: ", bmi(bodyweight, bodylength))
