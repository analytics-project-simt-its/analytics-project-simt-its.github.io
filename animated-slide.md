---
layout: slide
title: "Demo Slide"
permalink: slide-demo
fullwidth: true
presentation_id: demo-123
---

{% include slide_layouts/title.html 
  title="Animated Tufte Presentation" 
  subtitle="With synchronized bullet points and sidenotes" 
  author="Your Name" 
  date="January 2024" 
%}

{% include slide_layouts/tufte_animated.html 
  title="Key Concepts" 
  content="
* First important point <span class='sidenote'>This is additional context about the first point that will appear alongside it.</span>
* Second key concept <span class='sidenote'>Here's some detailed explanation about the second concept.</span>
* Third crucial idea <span class='sidenote'>Extra information about the third idea that appears when the point is revealed.</span>
* Fourth insight <span class='sidenote'>Final sidenote that appears with the last point.</span>
  "
  footnote="Use arrow keys to reveal points and their associated sidenotes"
%}

{% include slide_layouts/tufte_animated.html 
  title="Animated Slide with Image" 
  image="/assets/img/hello_world.jpeg"
  image_alt="Description of the image"
  content="
* First point with note <span class='sidenote'>This is the first sidenote that will appear with the point.</span>
* Second point <span class='sidenote'>Another detailed explanation that appears with its point.</span>
* Image and points can be revealed together <span class='sidenote'>The image is also animated and will appear with the first point.</span>
  "
  footnote="Use arrow keys to navigate through the points"
%}

{% include slide_layouts/tufte_animated.html 
  title="Another Example" 
  content="
* Main principle <span class='sidenote'>Each bullet point will appear one at a time.</span>
* Supporting evidence <span class='sidenote'>The sidenotes will fade in with their associated points.</span>
* Final conclusion <span class='sidenote'>Use left arrow to go backwards through the points.</span>
  "
  footnote="The animations help control the flow of information"
%}
