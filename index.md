---
layout: course
title: "Analytics Projects"
subtitle: "SIMT ITS"
description: "A graduate course on prescriptive analytics approaches, focusing on optimization and decision-making algorithms through hands-on group projects."
keywords: "analytics project, prescriptive analytics, optimization, decision-making, SIMT ITS, data science"
instructor: "Mansur M. Arief"
og_image: "https://mansurarief.github.io/assets/img/simt-header.png"
last_updated: "Dec 31, 2024"
toc: true
auto_toc: true
---

# Analytics Projects

**Instructor(s)**: [Mansur M. Arief, Ph.D.](https://mansurarief.github.io/) (Week 9-16), [R. Mohamad Atok, Ph.D.](https://www.its.ac.id/statistika/dosen-staff/daftar-dosen/r-mohamad-atok/) (Week 1-8)


<div class="course-diagram">
{% include_relative assets/svg/course-diagram.svg %}
</div>

This graduate course digs into the application of analytics to projects based on (semi)realistic datasets, guided by theories and algorithmic principles. In Part 2 of the course, students will focus on **prescriptive analytics approaches** (including linear and nonlinear programming one-shot decisions as well as sequential decisions), with a particular emphasis on optimization and decision-making algorithms. Building on the foundations laid in Part 1 (descriptive and predictive analytics), the course continues to prioritize hands-on group projects. This approach creates a sandbox learning environment where students can collaboratively apply their skills in ideation, modeling, and communication to solve complex, real-world challenges.

## Course objectives {#course-objectives}

Upon the completion of the course, the students are able to

1. **identify** real life problems that require analytics
2. choose the **appropriate** methods or tools applicable to a certain problem
3. **apply** tool and methods to address certain problem
4. showcase the skills in **presenting** to results and **explain** the insights obtained from the projects

## Lectures {#lectures}
- The lectures are on Fridays, 6:30-8:10pm WIB in Zoom (link posted in MyITS classroom). 
- Attendance is required (by SIMT and ITS).
- Active participation is highly encouraged.

## Office hours {#office-hours}

Office hours (optional) are Saturday, 8am-9am WIB. During this time, feel free to use the **Office Hours** Zoom link to chat with me. If you want to meet with me outside of these hours, use this [calendar](https://mansurarief.github.io/calendar/).

## Textbooks {#textbooks}

NO required textbook for this course. I will provide reading materials in MyITS classrooms from chapters of the book we are currently preparing for this course. It is useful to consult materials from the following sources:

1. Algorithms for Optimization (M. J. Kochenderfer and T. A. Wheeler) textbook ([chapters available for free](https://algorithmsbook.com/optimization/)), 
2. Algorithms for Decision Making (Mykel J. Kochenderfer, Tim A. Wheeler, and Kyle H. Wray) [available for free](https://algorithmsbook.com/#download).

A great additional resource is the Engineering Design Optimization (Joaquim Martins and Andrew Ning) [also available for free](http://websites.umich.edu/~mdolaboratory/pdf/Martins2021.pdf).

## Other Resources {#other-resources}

- [Jupyter Notebook Examples](https://drive.google.com/drive/folders/16iH4A39rBLvV7AHJK97SuMvefr3EGzx0?usp=sharing)
- [Prescriptive Analytics Project (Book Draft)](https://drive.google.com/file/d/1etdEPF0Sk_IZ1FpGHhg0sevBoPK0kMnE/view?usp=drive_link)
- [Project Webpage Template](https://colab.research.google.com/drive/1jC-uPCJsBEE-OUNbxAqs9MYOjy45zyCu?usp=sharing)
- Previous Projects Gallery

## Grading and assignments {#grading}

<table class="table-schedule">
  <thead>
    <tr>
      <th style="text-align: left">Assignment</th>
      <th style="text-align: center">Weight</th>
      <th style="text-align: center">Cumulative</th>
    </tr>
  </thead>
  <tbody>
    {% for assignment in site.data.assignments %}
    <tr>
      <td style="text-align: left">{% if assignment.link != "" %}<a href="{{ assignment.link }}">{{ assignment.name }}</a>{% else %}{{ assignment.name }}{% endif %}</td>
      <td style="text-align: center">{{ assignment.weight }}</td>
      <td style="text-align: center">{{ assignment.cumulative }}</td>
    </tr>
    {% endfor %}
  </tbody>
</table>

Please submit your assignments either by filling the form online or by uploading them in your MyITS. If it is a group assignment, only one submission is enough. The rubric for each assignment is linked in the table above and is also posted in MyITS classroom.

## Schedule {#schedule}

<table class="table-schedule">
  <thead>
    <tr>
      <th style="text-align: center">Week</th>
      <th style="text-align: center">Date</th>
      <th style="text-align: left">Session Details*</th>
      <th style="text-align: left">Assignment Due**</th>
    </tr>
  </thead>
  <tbody>
    {% for week in site.data.schedule %}
    <tr>
      <td style="text-align: center">{{ week.week }}</td>
      <td style="text-align: center">{{ week.date }}</td>
      <td style="text-align: left">
        {% for detail in week.details %}
          {% if detail.link %}
            <a href="{{ detail.link }}">{{ detail.name }}</a>
          {% else %}
            {{ detail.name }}
          {% endif %}
          {% if detail.type %}<strong>({{ detail.type }})</strong>{% endif %}
          {% unless forloop.last %}, {% endunless %}
        {% endfor %}
      </td>
      <td style="text-align: left">{{ week.assignment }}</td>
    </tr>
    {% endfor %}
  </tbody>
</table>

<div class="legend">*Legend: <strong>L</strong> = Lecture, <strong>P</strong> = (Student) Presentation, <strong>O</strong> = Open-ended Session</div>

<div class="legend"><emph>**All assignments are due at 11:59pm (AOE - Anywhere on Earth)</emph></div>

## AI usage policy {#ai-policy}

We are committed to fostering an environment where the responsible use of generative AI tools can enhance both learning and creativity. Here are the general guidelines to help you in integrating AI responsibly into the coursework:

- **Freedom to Use AI**: You are encouraged to use AI tools as you see fit. This trust is based on your demonstrated responsibility and initiative as learners adept at managing advanced technologies.
- **Ethical and Responsible Use**: It is essential to ensure that AI-generated content is accurate, unbiased, and respectful. You are expected to scrutinize the AI output for any issues such as plagiarism, bias, or inappropriate content and rectify these problems before submission.
- **Transparency and Reflection in Usage**: Every piece of work that includes AI assistance must have an accompanying [AI Usage and Reflection Form](https://mansurarief.github.io/ai-usage-and-reflection-form.docx).
- **Seek Consent for Sensitive Data**: Always secure consent before entering private, sensitive, or copyrighted information into any AI system, ensuring compliance with ethical standards and respect for privacy.
- **Support and Resources**: If you have any uncertainties about this policy or require assistance with AI tools, please do not hesitate to contact the teaching team. We are here to support your academic journey and ensure you can use AI effectively and ethically.
  
These guidelines are intended to enable you to contribute to a learning environment that values integrity, innovation, and critical examination. These practices not only enhance our academic endeavors but also prepare us for the ethical use of technology. 
I look forward to seeing how you **creatively** and **responsibly** integrate AI into your work, and I am always available to discuss any aspect of AI usage in your projects.

## Late policy {#late-policy}

Because of unexpected events, illnesses, work commitments, etc., there is a 0% penalty for 48 hours (no questions asked) after each assignment deadline (not presentations)--- after which you receive 0 credit. Presentations do not have late days. 

## Disabilities {#disabilities}

Students who may require academic accommodations due to a disability are encouraged to initiate their request with the SIMT course staff. The SIMT course staff will assess the request based on the provided documentation, recommend appropriate accommodations. It is advisable for students to contact the SIMT course staff as early as possible, as timely notification is essential to facilitate the coordination of accommodations.

## Contact {#contact}

I'm here to help you! If you have any questions or concerns:
- please email me at **mansur (dot) maturidi (at) its (dot) ac (dot) id**, or 
- visit during office hours for a chat on Zoom.

I look forward to assisting you!

## Acknowledgment {#acknowledgment}

- Most contents are adopted from the [previous semester's webpages](/previous). 
- Some contents are paraphrased using ChatGPT with the prompt "*revise any grammatical errors and improve clarity*".
- The web layout is composed by Github Copilot and Claude via Cursor's composer.
- The AI usage policy is customized based on [Stanford CTL workshop "AI in Education: Creating Your Course Policy"](https://docs.google.com/presentation/d/1XgN7uLrYvxYrZoKAVrlKL05Ng_uIxl_Y/edit?usp=sharing&ouid=109376912442294374565&rtpof=true&sd=true) by Kenji Ikemoto. 