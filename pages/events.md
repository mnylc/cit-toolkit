---
title: Events
permalink: /events/
layout: posts

use_tag: "event"
---

<ol class="posts">
{% assign evs = site.data.events.events | sort: "start.local" %}
{% for e in site.data.events.events %}
<li>
    <h3>
	<a href="{{ e.url }}">
      {{ e['name']['html'] }}
    </a>
	</h3>
	<div class="post-date">{{ e.start.local | date: "%a, %b %d, %Y, %R %p" }}</div>
	<br/>
	<div class="post-excerpt">{{ e.description.text | truncatewords:75 }} </div>
	<br/>
	<div><a href="{{ e.url }}">Register</a>
	</li>
{% endfor %}
</ol>
