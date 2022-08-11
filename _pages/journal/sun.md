---
layout: page
title: sun journal
emoji: ☀️
permalink: /journal/sun/
menu: journal
---
the focus of the mighty sun illuminates each and every small nook·

<ul markdown="0">
    {% for post in site.posts %}
        <li>
            <time datetime="{{ post.date | date: "%Y-%m-%d" }}">{{ post.date | date: "%Y-%m-%d" }}</time>
            <a href="{{ post.url }}">{{ post.title }}{% if post.emoji %} {{ post.emoji }}{% endif %}</a></li>
    {% endfor %}
</ul>

---

subscribe via [atom](https://blog.miso.town/atom?url=https://markza.cafe/journal/sun/) or read at the [neon kiosk](https://kiosk.nightfall.city/blogs.html)

[![valid html blog]({% link /assets/images/html_blog_valid.png %}){:.image-filter}](https://blog.miso.town/)