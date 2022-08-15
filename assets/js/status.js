document.addEventListener("DOMContentLoaded", function() {
    const emoji = document.querySelector(".status-emoji");
    const time = document.querySelector(".status-time");
    const content = document.querySelector(".status-content");
    fetch("https://status.cafe/users/marzka/status.json")
        .then((r) => r.json())
        .then((r) => {
            if (!r.content.length) {
                content.innerHTML = "no status yet";
                return;
            }
            emoji.innerHTML = r.face;
            time.innerHTML = r.timeAgo;
            content.innerHTML = r.content;
        })
        .catch(() => {
            emoji.innerHTML = "⚠️";
            content.innerHTML = "something went wrong fetching status :("
        });
});