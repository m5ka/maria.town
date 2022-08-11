---
---
document.addEventListener "DOMContentLoaded", () =>
    collapsible = document.querySelector(".collapsible")
    document.querySelector(".collapse-button").addEventListener "click", (event) =>
        event.preventDefault()
        collapsible.classList.toggle("show")