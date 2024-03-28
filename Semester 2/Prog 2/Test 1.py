x = ["20", "Nov", "1994"]

def parse_date(date):
    monats_dict = {
        "Jan": 1, "Feb": 2, "Mar": 3, "Apr": 4,
        "May": 5, "Jun": 6, "Jul": 7, "Aug": 8,
        "Sep": 9, "Oct": 10, "Nov": 11, "Dec": 12
    }
    result = f"{date[0]}.{monats_dict[date[1]]}.{date[2]}"
    return result


y = parse_date(x)
print(y)