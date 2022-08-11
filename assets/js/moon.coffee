---
---
getJulianDate = (date = new Date()) ->
    time = date.getTime()
    tzoffset = date.getTimezoneOffset()
    return (time / 86400000) - (tzoffset / 1440) + 2440587.5

normalize = (value) ->
    value -= Math.floor(value);
    if value < 0
        value = value + 1 
    return value

getLunarAge = (date = new Date()) ->
    lunarMonth = 29.530588853
    percent = normalize((getJulianDate(date) - 2451550.1) / lunarMonth)
    return percent * lunarMonth

getLunarPhase = (date = new Date()) ->
    age = getLunarAge(date)
    if age < 1.84566
        return 0
    else if age < 5.53699
        return 1
    else if age < 9.22831
        return 2
    else if age < 12.91963
        return 3
    else if age < 16.61096
        return 4
    else if age < 20.30228
        return 5
    else if age < 23.99361
        return 6
    else if age < 27.68493
        return 7
    return 0

moonEmoji = ["🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘"]
moonNames = [
    "new",
    "waxing crescent",
    "first quarter",
    "waxing gibbous",
    "full",
    "waning gibbous",
    "last quarter",
    "waning crescent"
]
moonWisdoms = [
    "now is a good time for introspection and self-care",
    "now is a good time for manifestation and setting goals",
    "now is a good time for overcoming barriers",
    "now is a good time for expectation and celebration",
    "now is a good time for powerful magic and healing",
    "now is a good time for letting things go",
    "now is a good time for finding a balance",
    "now is a good time for recharging and looking after yourself"
]

document.addEventListener "DOMContentLoaded", () =>
    phase = getLunarPhase()
    document.querySelector("#moonEmoji").innerHTML = moonEmoji[phase]
    document.querySelector("#moonName").innerHTML = moonNames[phase]
    document.querySelector("#moonWisdom").innerHTML = moonWisdoms[phase]