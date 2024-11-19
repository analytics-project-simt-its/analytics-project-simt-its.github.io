### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ 9f91e097-0f0a-47a4-9e81-bffc86c2201f
begin
	using PlutoUI
	using TikzPictures
	TableOfContents()
end

# ╔═╡ 2b039809-c303-4e23-b8ff-14a7305bd2be
html"""
<style>
    a {
        color: #da5616;
        text-decoration: none; 
    }
    a:hover {
        text-decoration: underline; 
    }
	.edit_or_run { 
		display: none; 
	}
</style>
"""

# ╔═╡ 85bebb22-b258-4419-b9cd-6b19d442d73e
html"""
<style>
    a {
        color: #da5616;
        text-decoration: none; 
    }
    a:hover {
        text-decoration: underline; 
    }
	.edit_or_run { 
		display: none; 
	}
</style>

<div style="text-align: center;">
    <a href="https://analytics-project-simt-its.github.io/"><img src="https://mansurarief.github.io/assets/img/simt-header.png" alt="header" width="400"/></a>
</div>
"""

# ╔═╡ b8c24aa2-6b09-4be7-9d5d-27cfdd92906e
md"""

# Analytics Project, Gasal 2024 - Part 2

**Instructor**: [Mansur M. Arief, Ph.D.](https://mansurarief.github.io/)

"""

# ╔═╡ 4e5808df-0df5-43f0-98e5-856f5f12eb00
TikzPicture("""
\\begin{tikzpicture}[>=stealth, node distance=4cm, auto]
	\\useasboundingbox (-1, -2) rectangle (15, 9);
	
	% Define styles
	\\tikzstyle{pred}=[circle, thick, draw=black!75, fill=blue!20, minimum size=50mm, align=center, label=below:, draw opacity=0.1, fill opacity=0.5]
	\\tikzstyle{pres}=[circle, thick, draw=black!75, fill=red!20, minimum size=50mm, align=center, label=below:, draw opacity=0.1, fill opacity=0.5]
	\\tikzstyle{desc}=[circle, thick, draw=black!75, fill=yellow!20, minimum size=50mm, align=center, label=below:, draw opacity=0.1, fill opacity=0.5]

 	\\node[pred, label=below:Predictive (Week 1-8)] (A) at (4,0) {};	
  	\\node[desc, label=below:Descriptive (Week 1-8)] (C) at (8,0) {};
	\\node[pres, label=above:Prescriptive (Week 9-16)] (B) at (6,3.4) {};

	 %\\node at (4,0) {Predictive Analytics (Part 1)};
		 \\node at (4,-0.5) {Decision trees};
		 \\node at (4,-1) {Random forest};
		 \\node at (4,-1.5) {...};
	 %\\node at (6,3.4) {Prescriptive Analytics (Part 2)};
		 \\node at (6,3.9) {Linear Programming};
		 \\node at (6,4.4) {Nonlinear Programming};
		 \\node at (6,3.4) {...};
     %\\node at (8,0) {Descriptive Analytics (Part 1)};
		 \\node at (8,-0.5) {Exploratory Data Analysis};
		 \\node at (8,-1) {Principal Component Analysis};
		 \\node at (8,-1.5) {...};

	 \\node at (6,1.2) {NeuralNet};
	 \\node at (7.8,1.8) {Rule-based};
	 \\node at (4.6,1.8) {Simulation};
	 \\node at (6,0.4) {Clustering};

	\\end{tikzpicture}""", options="scale=1.0", preamble="")

# ╔═╡ cff36f3e-fe45-11ee-10dd-b16376ef96a6
md"""
This graduate course digs into the application of analytics to projects based on (semi)realistic datasets, guided by theories and algorithmic principles. In Part 2 of the course, students will focus on **prescriptive analytics approaches** (including linear and nonlinear programming one-shot decisions as well as sequential decisions), with a particular emphasis on optimization and decision-making algorithms. Building on the foundations laid in Part 1 (descriptive and predictive analytics), the course continues to prioritize hands-on group projects. This approach creates a sandbox learning environment where students can collaboratively apply their skills in ideation, modeling, and communication to solve complex, real-world challenges. 
"""

# ╔═╡ 8c54025c-771f-4c97-bfae-816603c3f718
md"""
## Course objectives

Upon the completion of the course, the students are able to

1. **identify** real life problems that require analytics
2. choose the **appropriate** methods or tools applicable to a certain problem
3. **apply** tool and methods to address certain problem
4. showcase the skills in **presenting** to results and **explain** the insights obtained from the projects
"""

# ╔═╡ 1ba74b45-232e-4e2b-80dd-8a3d568fbfda
md"""
## Lectures
- The lectures are on Fridays, 6:30-8:10pm WIB in Zoom (link posted in MyITS classroom). 
- Attendance is required (by SIMT and ITS).
- Active participation is highly encouraged.
"""

# ╔═╡ ee97365d-668b-43fc-a0d3-5279ac4646c4
md"""
## Office hours

Office hours (optional) are Saturday, 8am-9am WIB. During this time, feel free to use the "Office Hours" Zoom link to chat with me. If you want to meet with me outside of these hours, use this [calendar](https://mansurarief.github.io/calendar/).
"""

# ╔═╡ f6f2d1b3-fc6c-4af8-8e20-b81687ebb591
md"""
## Textbooks

NO required textbook for this course. I will provide reading materials in MyITS classrooms from chapters of the book we are currently preparing for this course. It is useful to consult materials from the following sources:

1. **Algorithms for Optimization (M. J. Kochenderfer and T. A. Wheeler) textbook** ([chapters available for free](https://algorithmsbook.com/optimization/)), 
2. **Algorithms for Decision Making (Mykel J. Kochenderfer, Tim A. Wheeler, and Kyle H. Wray)** [available for free](https://algorithmsbook.com/#download).

A great additional resource is the **Engineering Design Optimization (Joaquim Martins and Andrew Ning)** [also available for free](http://websites.umich.edu/~mdolaboratory/pdf/Martins2021.pdf).
"""

# ╔═╡ 78a0601f-b649-4e0e-8ca2-b0a0d858c581
md"""
## Grading and assignments

Here is the grade breakdown for this course

| Assignment           | Weight | Cumulative |
|:---------------------|:------:|:----------:|
| Reflections (1 and 2)| 10%    | 10% |
| [Proposal presentation](https://docs.google.com/document/d/1Un62s0U9jwrVVOQ03iipmCRprsh3jK5__RQc7DHLCjc)| 10%    | 20% |
| [Peer review](https://docs.google.com/document/d/16a_A-K7vaBM6H_N6oB1-jLCbn4spvaQKpL03cI7XQ-g)          | 10%    | 30% |
| [Midterm report](https://docs.google.com/document/d/1cNyAea4Xl-RgAwayCl1EwN4-xF3OD9drA5GSBpF9huo)       | 15%    | 45% |
| [Final report](https://docs.google.com/document/d/1TCu1Xw7nJJPmGjWG22evxDxiZjPmNxWZwivlEDozZ84)         | 25%    | 70% |
| [Final presentation](https://docs.google.com/document/d/1YKBGs6npD6Dc4vPZMYA7lskuXOBf0SbuFBmmrvbTtww)   | 30%    | 100% |
| Project repo/website | 5%      | (extra point) |

Please submit your assignments either by filling the form online or by uploading them in your MyITS. If it is a group assignment, only one submission is enough. The rubric for each assignment is linked in the table above and is also posted in MyITS classroom.
"""

# ╔═╡ 590c941c-86a9-43a6-beb7-4ff6e080b6d5
md"""
## Schedule

| Week |  Date    | Session Details*                             | Assignment Due** |
|:----:|:--------:|:--------------------------------------------|:----------------|
|  8   | Oct 18    | [Overview](#), [Prescriptive Analytics Projects](/assets/pdf/2024-week-1-intro.pdf) **(L)**          | -    |
|  10  | Nov 1   | [Optimization Modeling](/assets/pdf/2024-week-2-opt-model.pdf) **(L)**    | [Reflection 1](https://forms.gle/38kh5oDHYgAkg1MZ9)               |
|  11  | Nov 8   | Data Collection **(L)**, Discussion **(O)**                      | -               |
|  12  | Nov 15   | Group 1 & 2 Proposal **(P)**, Discussion **(O)**                      | Midterm report  |  
|  13  | Nov 22   | Group 3 & 4 Proposal **(P)**, Model Gallery **(L)**     | [Peer review](https://forms.gle/yKfLKLNLf5NNULNp6)     |
|  14  | Nov 29   | Group 5 Proposal, V&V, Solver, and Eval **(L)**         | [Midterm feedback](https://stanforduniversity.qualtrics.com/jfe/form/SV_cAsySHDev5GTUvc) |
|  15  | Dec 6  | Monitoring **(L)**, In-class OH **(O)**                        | -               |
|  16  | Dec 13  | Final Presentation **(P)**                  | Final presentation            | -               |
|    |          |      | Final report       |
|    |          |      | Reflection 2       |

*Legend: **(L)** = Lecture, **(P)** = Student Presentation, **(O)** = Open-ended Session

\**All assignments are due at 11:59pm (AOE - Anywhere on Earth) 

"""

# ╔═╡ 690cc65a-2d23-451b-bb43-6ed4d847ca64
md"""
## AI usage policy

We are committed to fostering an environment where the responsible use of generative AI tools can enhance both learning and creativity. Here are the general guidelines to help you in integrating AI responsibly into the coursework:

- **Freedom to Use AI**: You are encouraged to use AI tools as you see fit. This trust is based on your demonstrated responsibility and initiative as learners adept at managing advanced technologies.
- **Ethical and Responsible Use**: It is essential to ensure that AI-generated content is accurate, unbiased, and respectful. You are expected to scrutinize the AI output for any issues such as plagiarism, bias, or inappropriate content and rectify these problems before submission.
- **Transparency and Reflection in Usage**: Every piece of work that includes AI assistance must have an accompanying [AI Usage and Reflection Form](https://mansurarief.github.io/ai-usage-and-reflection-form.docx).
- **Seek Consent for Sensitive Data**: Always secure consent before entering private, sensitive, or copyrighted information into any AI system, ensuring compliance with ethical standards and respect for privacy.
- **Support and Resources**: If you have any uncertainties about this policy or require assistance with AI tools, please do not hesitate to contact the teaching team. We are here to support your academic journey and ensure you can use AI effectively and ethically.
  
These guidelines are intended to enable you to contribute to a learning environment that values integrity, innovation, and critical examination. These practices not only enhance our academic endeavors but also prepare us for the ethical use of technology. 
I look forward to seeing how you **creatively** and **responsibly** integrate AI into your work, and I am always available to discuss any aspect of AI usage in your projects.

"""

# ╔═╡ e4442912-0bc7-46e9-8f17-e2c5319228ac
md"""

## Late policy

Because of unexpected events, illnesses, work commitments, etc., there is a 0% penalty for 48 hours (no questions asked) after each assignment deadline (not presentations)--- after which you receive 0 credit. Presentations do not have late days. 
"""

# ╔═╡ d93080fa-952f-41c3-96cc-ed662d4530d1
md"""
## Disabilities

Students who may require academic accommodations due to a disability are encouraged to initiate their request with the SIMT course staff. The SIMT course staff will assess the request based on the provided documentation, recommend appropriate accommodations. It is advisable for students to contact the SIMT course staff as early as possible, as timely notification is essential to facilitate the coordination of accommodations.
"""

# ╔═╡ c3103bab-8c31-4981-a430-b5e50022af31
md"""
## Contact

I'm here to help you! If you have any questions or concerns:
- please email me at **mansur (dot) maturidi (at) its (dot) ac (dot) id**, or 
- visit during office hours for a chat on Zoom.

I look forward to assisting you!
"""

# ╔═╡ 7690ee64-e273-499a-86e0-e2398e787107
md"""
## Acknowledgment

- This page is created using [Pluto notebook](https://plutojl.org/). 
- Some contents are edited from ChatGPT with the prompts "*revise any grammatical errors and for better clarity*" and Github Copilot auto complete. 
- Most contents are adopted from the previous semester's [Analytics Project course webpage](https://analytics-project-simt-its.github.io/2024-genap). 
- The AI usage policy section is customized based on [Stanford CTL workshop "AI in Education: Creating Your Course Policy"](https://docs.google.com/presentation/d/1XgN7uLrYvxYrZoKAVrlKL05Ng_uIxl_Y/edit?usp=sharing&ouid=109376912442294374565&rtpof=true&sd=true) by Kenji Ikemoto.
"""

# ╔═╡ 4b20f6ef-0b98-4740-a029-f0a90951636a
md"""
*Last updated: Nov 19, 2024*
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
TikzPictures = "37f6aa50-8035-52d0-81c2-5a1d08754b2d"

[compat]
PlutoUI = "~0.7.58"
TikzPictures = "~3.5.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "7d9caf115c2239cefd77e8c0e5b3bdd29485ff7a"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a2f1c8c668c8e3cb4cca4e57a8efdb09067bb3fd"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.0+2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c6317308b9dc757616f0b5cb379db10494443a7"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.2+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "db16beca600632c95fc8aca29890d83788dd8b23"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.96+0"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "5c1d8ae0efc6c2e7b1fc502cbe25def8f661b7bc"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.2+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "7c82e6a6cd34e9d935e9aa4051b66c6ff3af59ba"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.2+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.HarfBuzz_ICU_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "HarfBuzz_jll", "ICU_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "6ccbc4fdf65c8197738c2d68cc55b74b19c97ac2"
uuid = "655565e8-fb53-5cb3-b0cd-aec1ca0647ea"
version = "2.8.1+0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.ICU_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "20b6765a3016e1fca0c9c93c80d50061b94218b7"
uuid = "a51ab1cf-af8e-5615-a023-bc2c838bba6b"
version = "69.1.0+0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c84a835e1a09b289ffcd2271bf2a337bbdda6637"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e16271d212accd09d52ee0ae98956b8a05c4b626"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "17.0.6+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "70c5da094887fd2cae843b8db33920bac4b6f07d"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.2+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "9fd170c4bbfd8b935fdc5f8b7aa33532c991a673"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.11+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fbb1f2bef882392312feb1ede3615ddc1e9b99ed"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.49.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0c4f9c4f1a50d8f35048fa0532dabbadf702f81e"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.1+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "5ee6203157c120d79034c748a2acba45b82b8807"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.1+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LittleCMS_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pkg"]
git-tree-sha1 = "110897e7db2d6836be22c18bffd9422218ee6284"
uuid = "d3a379c0-f9a3-5b72-a4c0-6bf4d2e8af0f"
version = "2.12.0+0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenJpeg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libtiff_jll", "LittleCMS_jll", "Pkg", "libpng_jll"]
git-tree-sha1 = "76374b6e7f632c130e78100b166e5a48464256f8"
uuid = "643b3616-a352-519d-856d-80112ee9badc"
version = "2.4.0+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a12e56c72edee3ce6b96667745e6cbbe5498f200"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "35621f10a7531bc8fa58f74610b1bfb70a3cfc6b"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.43.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.Poppler_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "OpenJpeg_jll", "Pkg", "libpng_jll"]
git-tree-sha1 = "02148a0cb2532f22c0589ceb75c110e168fb3d1f"
uuid = "9c32591e-4766-534b-9725-b71a8799265b"
version = "21.9.0+0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TikzPictures]]
deps = ["LaTeXStrings", "Poppler_jll", "Requires", "tectonic_jll"]
git-tree-sha1 = "79e2d29b216ef24a0f4f905532b900dcf529aa06"
uuid = "37f6aa50-8035-52d0-81c2-5a1d08754b2d"
version = "3.5.0"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "1165b0443d0eca63ac1e32b8c0eb69ed2f4f8127"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "a54ee957f4c86b526460a720dbc882fa5edcbefc"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.41+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d2d1a5c49fae4ba39983f63de6afcbea47194e85"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "47e45cd78224c53109495b3e324df0c37bb61fbe"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+0"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "bcd466676fef0878338c61e655629fa7bbc69d8e"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e678132f07ddb5bfa46857f0d7620fb9be675d3b"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.6+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d7015d2e18a5fd9a4f47de711837e980519781a4"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.43+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.tectonic_jll]]
deps = ["Artifacts", "Fontconfig_jll", "FreeType2_jll", "Graphite2_jll", "HarfBuzz_ICU_jll", "HarfBuzz_jll", "ICU_jll", "JLLWrappers", "Libdl", "OpenSSL_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "54867b00af20c70b52a1f9c00043864d8b926a21"
uuid = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"
version = "0.13.1+0"
"""

# ╔═╡ Cell order:
# ╟─9f91e097-0f0a-47a4-9e81-bffc86c2201f
# ╟─2b039809-c303-4e23-b8ff-14a7305bd2be
# ╟─85bebb22-b258-4419-b9cd-6b19d442d73e
# ╟─b8c24aa2-6b09-4be7-9d5d-27cfdd92906e
# ╟─4e5808df-0df5-43f0-98e5-856f5f12eb00
# ╟─cff36f3e-fe45-11ee-10dd-b16376ef96a6
# ╟─8c54025c-771f-4c97-bfae-816603c3f718
# ╟─1ba74b45-232e-4e2b-80dd-8a3d568fbfda
# ╟─ee97365d-668b-43fc-a0d3-5279ac4646c4
# ╟─f6f2d1b3-fc6c-4af8-8e20-b81687ebb591
# ╟─78a0601f-b649-4e0e-8ca2-b0a0d858c581
# ╟─590c941c-86a9-43a6-beb7-4ff6e080b6d5
# ╟─690cc65a-2d23-451b-bb43-6ed4d847ca64
# ╟─e4442912-0bc7-46e9-8f17-e2c5319228ac
# ╟─d93080fa-952f-41c3-96cc-ed662d4530d1
# ╟─c3103bab-8c31-4981-a430-b5e50022af31
# ╟─7690ee64-e273-499a-86e0-e2398e787107
# ╟─4b20f6ef-0b98-4740-a029-f0a90951636a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
