---
---
# timeAgo function courtesy of https://muffinman.io/blog/javascript-time-ago-function/ with some modifications #
timeAgo = (dateParam) ->
    if !dateParam
        return null

    date = if typeof dateParam == 'object' then dateParam else new Date(dateParam)
    DAY_IN_MS = 86400000; # 24 * 60 * 60 * 1000
    today = new Date()
    yesterday = new Date(today - DAY_IN_MS)
    seconds = Math.round((today - date) / 1000)
    minutes = Math.round(seconds / 60)
    isToday = today.toDateString() == date.toDateString()
    isYesterday = yesterday.toDateString() == date.toDateString()
    isThisYear = today.getFullYear() == date.getFullYear()

    if seconds < 5
        return "now"
    else if seconds < 60
        return "#{ seconds } seconds ago"
    else if seconds < 90
        return "about a minute ago"
    else if minutes < 60
        return "#{ minutes } minutes ago"
    else if isToday
        t = date.toLocaleString "en-gb", {hour: "2-digit", minute: "2-digit"}
        return "today at #{t}"  # Today at 10:20
    else if isYesterday
        t = date.toLocaleString "en-gb", {hour: "2-digit", minute: "2-digit"}
        return "yesterday at #{t}"  # Yesterday at 10:20
    else if isThisYear
        d = date.toLocaleString "en-gb", {day: "numeric", month: "long"}
        t = date.toLocaleString "en-gb", {hour: "2-digit", minute: "2-digit"}
        return "#{d} at #{t}"  # 10 January at 10:20

    d = date.toLocaleString "en-gb", {day: "numeric", month: "long", year: "numeric"}
    t = date.toLocaleString "en-gb", {hour: "2-digit", minute: "2-digit"}
    return "#{d} at #{t}"  # 10 January 2017 at 10:20

document.addEventListener "DOMContentLoaded", () =>
    target = "https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=zeeonbees&limit=1&api_key=8593a81dd2f1069b64528adcd184e9b2&format=json"
    nowlistening = document.querySelector("#nowlistening")
    nowlisteningdate = document.querySelector("#nowlisteningdate")
    fetch(target)
    .then (res) ->
        return res.json()
    .then (body) ->
        track = body.recenttracks.track[0]
        trackDate = if (track["@attr"] and track["@attr"].nowplaying) then "now playing" else timeAgo(track.date["#text"]+" UTC").toLowerCase()
        nowlistening.innerHTML = "#{track.artist['#text'].toLowerCase()} ─ #{track.name.toLowerCase()}"
        nowlistening.href = track.url
        nowlisteningdate.innerHTML = "• #{trackDate}"
    .catch (err) -> 
        console.log err 
        nowlistening.innerHTML = "oops"
        nowlisteningdate.innerHTML = "error happened trying to talk to last.fm :("