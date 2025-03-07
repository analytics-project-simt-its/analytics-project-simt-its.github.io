---
layout: slide
title: "Data-Driven Optimization Modeling"
permalink: lecture-2
fullwidth: true
presentation_id: lecture-2
---

{% include slide_layouts/title.html 
  title="Data-Driven Optimization Modeling" 
  subtitle="Analytics Projects, SIMT ITS 2024/2025" 
  author="Mansur M. Arief" 
  date="07 March 2025" 
%}


{% include slide_layouts/iframe_embed.html
  iframe_src="https://pollev-embeds.com/multiple_choice_polls/Fa8bTSSJ3OkKSjYnIMpg9/respond"
  width="100%"
  height="500px"
%}


{% include slide_layouts/tufte_animated.html 
  title="Agenda" 
  content="
* Reflection 1 due today<span class='sidenote'>Please submit your reflection: <a href='https://forms.gle/NjzMwFMCCvCRMMym6'>https://forms.gle/NjzMwFMCCvCRMMym6</a></span>
* What is data-driven optimization modeling?<span class='sidenote'>Here, optimization model == prescriptive analytics model (used interchangeably).</span>
* What are the components of an optimization model?
* How to approach an optimization modeling project?
* Where to start our group project?
"
  footnote="Please stop me and ask questions at any point during the lecture."
%}

{% include slide_layouts/tufte_animated.html 
  title="Data-Driven Optimization Modeling" 
  image="/assets/img/data-driven-model.png"
  image_alt="Description of the image"
  content="
* A flexible model that dynamically adapts to the data<span class='sidenote'>If the data is small, the model will be small. If the data is large, the model will also be large.</span>
* Example: Exercise 2.4 (Production Planning)<span class='sidenote'>See <a href='https://docs.google.com/spreadsheets/d/1HVhl0wZYh_oodzzbnEd35SYFuESIehCg_J6yK0_z8sU/edit?usp=sharing'>this spreadsheet</a>.</span>
* Objective: minimize the total profit from selling products.
* Number of products: 3 (small)
* What is your optimal solution? What is your optimal profit?
"
%}

{% include slide_layouts/iframe_embed.html
  iframe_src="https://pollev-embeds.com/free_text_polls/zM2S1hayHZZkG6HOpONcT/respond"
  width="100%"
  height="500px"
%}


{% include slide_layouts/tufte_animated.html 
  title="Using a Model to Solve PPC Problems" 
  content="
* Tried solving manually<span class='sidenote'>Used <a href='https://docs.google.com/spreadsheets/d/1HVhl0wZYh_oodzzbnEd35SYFuESIehCg_J6yK0_z8sU/edit?usp=sharing'>this spreadsheet</a>.</span>
* Try the prototype<span class='sidenote'>Visit <a href='https://huggingface.co/spaces/mansurarief/data_driven_ppc'>https://huggingface.co/spaces/mansurarief/data_driven_ppc</a></span>
* Test with small data<span class='sidenote'><a href='https://docs.google.com/spreadsheets/d/1rPRaSdfid14Omo5d09jetije-MEeUAbzBSsuBO5ZFvI/edit?usp=sharing'>Small PPC Dataset (3 products)</a></span>
* Test with large data<span class='sidenote'><a href='https://docs.google.com/spreadsheets/d/1x-qYyP8_QoDqO0PRRmfWDfixvY55SymOGfErTzj2_Rk/edit?usp=sharing'>Large PPC Dataset (1000 products)</a></span>
"
%}


{% include slide_layouts/tufte_animated.html 
  title="Components of an Optimization Model" 
  content="
* Objective function <span class='sidenote'>What we want to optimize.</span>
* Decision variables <span class='sidenote'>What we can control.</span>
* Constraints <span class='sidenote'>What we must satisfy.</span>
* Parameters <span class='sidenote'>What data we can use.</span>
"
%}

{% include slide_layouts/tufte_animated.html 
  title="Major Steps in an Optimization Modeling Project" 
  content="
* Define the problem<span class='sidenote'>What is the problem we want to solve? Why is it important?</span>
* Formulate the model<span class='sidenote'>What are the model components?</span>
* Solve the model<span class='sidenote'>What is the optimal solution and its value? What can we use as a benchmark?</span>
* Verify and validate the model<span class='sidenote'>How do we know that the model is correct?</span>
* Analyze the results<span class='sidenote'>What does the optimal solution mean?</span>
* Serve/deploy the model (optional)<span class='sidenote'>How do we use the model to make decisions?</span>
"
%}

{% include slide_layouts/tufte_animated.html 
  title="First Step: Define the Problem" 
  content="
* Meet with your group<span class='sidenote'>Fill this <a href='https://docs.google.com/document/d/11NwpGeLX1ZkPcExyttSLHKCUEFz1H3szT3Ac6vkTaC8/edit?usp=sharing'>Google Doc</a> to discuss the problem you want to solve.</span>
* Discuss why does the problem require analytics? 
* Discuss why this problem is important
* Discuss everyone's roles in the project
* Discuss the next steps (optional)
"
%}



{% include slide_layouts/tufte_animated.html 
  title="Questions?" 
  content="
* Please send me an email with your group's meeting notes <span class='sidenote'>Send to: <a href='mailto:mansur.maturidi@its.ac.id'>mansur.maturidi@its.ac.id</a>, cc all group members</span>
* Next week, we will start with the second step: Formulate the model.
* Any questions?
"
%}