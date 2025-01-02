---
layout: course
title: "Previous Classes"
subtitle: "SIMT ITS"
description: "Archive of previous Analytics Project courses at SIMT ITS"
keywords: "analytics project, course history, SIMT ITS, data science education"
toc: false
auto_toc: false
---
# Previous Classes

Browse through our previous Analytics Project courses. Each semester brings unique projects and learning experiences.

<div class="course-grid">
{% for course in site.data.courses %}
  <div class="course-card">
    <div class="course-card-content">
      <h3>{{ course.title }}</h3>
      <p class="course-semester">{{ course.semester }}</p>
      <p class="course-description">{{ course.description }}</p>
      <div class="course-stats">
        <span><strong>{{ course.students }}</strong> Students</span>
        <span><strong>{{ course.projects }}</strong> Projects</span>
      </div>
      <a href="{{ course.url }}" class="course-link">Course Details</a>
      <a href="{{ course.gallery }}" class="course-link">Project Gallery</a>
    </div>
  </div>
{% endfor %}
</div>
