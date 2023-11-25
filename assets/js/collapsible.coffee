---
---
document.addEventListener "DOMContentLoaded", () =>
    header = document.querySelector(".container > header")
    document.querySelector(".hamburger-open").addEventListener "click", (event) =>
        event.preventDefault()
        header.classList.toggle("open")
    document.querySelector(".hamburger-close").addEventListener "click", (event) =>
        event.preventDefault()
        header.classList.remove("open")