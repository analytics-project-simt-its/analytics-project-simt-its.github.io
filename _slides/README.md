# Tufte-Style Slides

This directory contains slides with Tufte-style sidenotes, fullscreen toggle, and dark mode support.

## Features

- **Responsive Design**: Works on all screen sizes
- **Fullscreen Toggle**: Click the fullscreen button or press 'F' to enter presentation mode
- **Dark Mode Toggle**: Click the dark mode button or press 'D' to toggle dark mode
- **Tufte-Style Sidenotes**: Add contextual information without interrupting the main text flow
- **Markdown Content**: Write slides using Markdown for easy authoring

## How to Create a Slide Deck

1. Create a new Markdown file in the `_slides` directory with the following front matter:

```yaml
---
layout: tufte-slides
title: "Your Slide Deck Title"
subtitle: "Optional subtitle"
---
```

2. Add slides using the following structure:

```html
<div class="slide">
  <h1>Slide Title</h1>
  <p>Slide content goes here.</p>
  <p>Add a sidenote reference: <span class="sidenote-ref" data-sidenote="sidenote-id"></span></p>
  <div id="sidenote-id">This is the sidenote content.</div>
</div>
```

3. Add as many slides as needed, each in its own `<div class="slide">` container.

## Sidenotes

Sidenotes are a key feature of Tufte-style design. They allow you to add contextual information without interrupting the main text flow.

To add a sidenote:

1. Add a reference in the main text:
   ```html
   <span class="sidenote-ref" data-sidenote="unique-id"></span>
   ```

2. Add the sidenote content:
   ```html
   <div id="unique-id">Sidenote content goes here.</div>
   ```

The sidenote will appear in the margin on large screens and inline on small screens.

## Keyboard Shortcuts

- **F**: Toggle fullscreen mode
- **D**: Toggle dark mode
- **ESC**: Exit fullscreen mode

## Example

See `tufte-slide-demo.md` for a complete example of a slide deck with Tufte-style sidenotes.

## Customization

You can customize the appearance of the slides by modifying the following files:

- `assets/css/tufte-slides.css`: Styles for the slides
- `assets/js/tufte-slides.js`: JavaScript functionality for the slides

## Credits

This slide system is inspired by Edward Tufte's design principles, which emphasize clarity, precision, and the efficient presentation of information. 