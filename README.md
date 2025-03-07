# Synchronized Tufte-Style Slide Presentation System

A modern, elegant slide presentation system built with Jekyll that features real-time synchronization capabilities powered by Firebase. This system combines Edward Tufte's design principles with modern web technologies to create beautiful, information-rich presentations that can be synchronized across multiple devices.

## Features

- **Real-time Synchronization**: Presenters can control slides across all connected viewers
- **Tufte-Inspired Design**: Clean, information-dense slides with sidenotes and proper typography
- **Responsive Layout**: Works on all devices from phones to projectors
- **Presenter Mode**: Special controls and notes visible only to the presenter
- **Smooth Transitions**: Beautiful CSS transitions between slides
- **Markdown Support**: Write presentations in simple Markdown with Jekyll front matter
- **Firebase Integration**: Cloud-based synchronization for remote presentations

## Getting Started

### Prerequisites

- [Jekyll](https://jekyllrb.com/docs/installation/) (3.9.0 or higher)
- [Firebase Account](https://firebase.google.com/) (Free tier works fine)

### Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/tufte-slides.git
   cd tufte-slides
   ```

2. Install dependencies:
   ```
   bundle install
   ```

3. Configure Firebase:
   - Create a new Firebase project at [firebase.google.com](https://firebase.google.com/)
   - Enable the Realtime Database
   - Update the Firebase configuration in `assets/js/firebase-config.js`
   - Set appropriate database rules (see below)

4. Start the Jekyll server:
   ```
   bundle exec jekyll serve
   ```

5. Visit `http://localhost:4000` in your browser

### Firebase Database Rules

For testing, you can use these permissive rules (not recommended for production):

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

For production, use more restrictive rules:

```json
{
  "rules": {
    "presentations": {
      "$presentationId": {
        ".read": true,
        ".write": "auth != null && auth.uid === $presentationId.split('_')[0]"
      }
    }
  }
}
```

## Creating Presentations

1. Create a new Markdown file in the root directory with the `.md` extension
2. Add Jekyll front matter:
   ```
   ---
   layout: slide
   title: "Your Presentation Title"
   permalink: your-presentation-url
   ---
   ```
3. Add slides using the following structure:
   ```html
   <div class="slide">
     <div class="slide-content">
       <h2>Slide Title</h2>
       <p>Slide content goes here.</p>
     </div>
   </div>
   ```

4. Add custom styles if needed using a `<style>` tag at the end of your file

See `sample-presentation-sync.md` for a complete example.

## Usage

### Presenter Mode

To enter presenter mode:
- Press `Alt+Shift+P` to toggle presenter mode
- In presenter mode, you'll see additional controls and information

### Keyboard Shortcuts

- `Right Arrow` or `Space`: Next slide
- `Left Arrow`: Previous slide
- `Home`: First slide
- `End`: Last slide
- `Alt+Shift+P`: Toggle presenter mode
- `Alt+Shift+S`: Toggle synchronization

### Synchronization

When synchronization is enabled:
- The presenter controls the slides for all connected viewers
- Viewers automatically follow the presenter's current slide
- The presenter can disable synchronization to allow viewers to navigate independently

## Components

The system consists of several JavaScript modules:

- **SlideController**: Manages slide navigation and keyboard shortcuts
- **SlideUI**: Handles the user interface elements
- **SlideSync**: Manages Firebase synchronization
- **SlidePresentation**: Coordinates all components

## Customization

### CSS Classes

- `.slide`: Base class for all slides
- `.slide-content`: Container for slide content
- `.active`: Applied to the currently visible slide
- `.animated-list`: List with items that appear one by one
- `.sidenote`: Small text notes that appear alongside content
- `.footnote`: Notes that appear at the bottom of slides
- `.note`: Highlighted notes with a background color
- `.presenter-controls`: Controls visible only in presenter mode

See `assets/css/slide-transitions.css` for more styling options.

## Browser Support

- Chrome (recommended for presenting)
- Firefox
- Safari
- Edge

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by [Edward Tufte's](https://www.edwardtufte.com/tufte/) design principles
- Built with [Jekyll](https://jekyllrb.com/) and [Firebase](https://firebase.google.com/)
