# Integration Guide: Adding the Slide System to Your Jekyll Site

This guide will help you integrate the Synchronized Tufte-Style Slide Presentation System into your existing Jekyll site.

## Step 1: Copy Required Files

Copy the following files from this repository to your Jekyll site:

```
assets/
├── css/
│   └── slide-transitions.css
├── js/
│   ├── firebase-config.js
│   ├── slide-controller.js
│   ├── slide-presentation.js
│   ├── slide-sync.js
│   └── slide-ui.js
└── _layouts/
    └── slide.html
```

## Step 2: Configure Firebase

1. Create a Firebase project at [firebase.google.com](https://firebase.google.com/) if you don't already have one
2. Enable the Realtime Database
3. Update the Firebase configuration in `assets/js/firebase-config.js` with your project details:

```javascript
// Replace these values with your Firebase project configuration
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
  databaseURL: "https://YOUR_PROJECT_ID.firebaseio.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT_ID.appspot.com",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID"
};
```

4. Set appropriate database rules in your Firebase console:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

## Step 3: Update Your Jekyll Configuration

Add the following to your `_config.yml` file:

```yaml
# Slide presentation settings
slide_presentation:
  enabled: true
  firebase:
    apiKey: "YOUR_API_KEY"
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com"
    databaseURL: "https://YOUR_PROJECT_ID.firebaseio.com"
    projectId: "YOUR_PROJECT_ID"
    storageBucket: "YOUR_PROJECT_ID.appspot.com"
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID"
    appId: "YOUR_APP_ID"
```

## Step 4: Create Your First Presentation

Create a new Markdown file in your Jekyll site with the following front matter:

```markdown
---
layout: slide
title: "Your First Synchronized Presentation"
permalink: /presentations/first-presentation/
---

<div class="slide">
  <div class="slide-content">
    <h1>Your First Slide</h1>
    <p>This is your first synchronized presentation!</p>
  </div>
</div>

<div class="slide">
  <div class="slide-content">
    <h2>Second Slide</h2>
    <p>Content for your second slide goes here.</p>
  </div>
</div>

<!-- Add more slides as needed -->
```

## Step 5: Test Your Presentation

1. Start your Jekyll server:
   ```
   bundle exec jekyll serve
   ```

2. Visit `http://localhost:4000/presentations/first-presentation/` in your browser

3. Open the same URL in another browser or device to test synchronization

## Step 6: Customize Your Presentation

### Adding Custom Styles

You can add custom styles to your presentation by including a `<style>` tag at the end of your Markdown file:

```html
<style>
  /* Custom styles for this presentation only */
  .slide-content {
    background-color: #f5f5f5;
    border-radius: 8px;
  }
  
  h1 {
    color: #2c3e50;
  }
</style>
```

### Using Sidenotes and Footnotes

```html
<div class="slide">
  <div class="slide-content">
    <h2>Slide with Sidenotes</h2>
    <p>This is the main content <span class="sidenote">This is a sidenote that provides additional context</span></p>
    <p class="footnote">This is a footnote at the bottom of the slide</p>
  </div>
</div>
```

### Creating Animated Lists

```html
<div class="slide">
  <div class="slide-content">
    <h2>Animated List</h2>
    <ul class="animated-list">
      <li>This item appears first</li>
      <li>This item appears second</li>
      <li>This item appears third</li>
    </ul>
  </div>
</div>
```

## Step 7: Advanced Integration

### Adding Presenter Notes

```html
<div class="slide">
  <div class="slide-content">
    <h2>Slide with Presenter Notes</h2>
    <p>This content is visible to everyone</p>
    <div class="presenter-notes">
      <p>These notes are only visible in presenter mode</p>
      <p>Press Alt+Shift+P to toggle presenter mode</p>
    </div>
  </div>
</div>
```

### Customizing the Layout

If you need to customize the slide layout, you can create a copy of `_layouts/slide.html` and modify it to suit your needs. Be sure to update your presentation's front matter to use your custom layout:

```markdown
---
layout: your-custom-slide-layout
title: "Custom Layout Presentation"
permalink: /presentations/custom-layout/
---
```

### Integrating with Jekyll Collections

You can organize your presentations as a Jekyll collection by adding the following to your `_config.yml`:

```yaml
collections:
  presentations:
    output: true
    permalink: /presentations/:path/
```

Then create a `_presentations` directory and add your presentation files there.

## Troubleshooting

### Firebase Connection Issues

If you're having trouble connecting to Firebase:

1. Check that your Firebase configuration is correct
2. Ensure your database rules allow read/write access
3. Check the browser console for any error messages
4. Try disabling any ad blockers or privacy extensions that might block Firebase connections

### Slide Navigation Issues

If slides aren't transitioning correctly:

1. Check that your HTML structure follows the required format
2. Ensure all required JavaScript files are included
3. Check the browser console for any JavaScript errors

### Synchronization Issues

If synchronization isn't working between devices:

1. Ensure both devices are connected to the internet
2. Check that both devices are using the same presentation ID
3. Verify that one device is set as the presenter and the other as a viewer
4. Check Firebase database rules to ensure they allow the necessary access

## Need More Help?

If you encounter any issues not covered in this guide, please:

1. Check the README.md file for additional information
2. Look for error messages in your browser's developer console
3. Open an issue on the GitHub repository with details about your problem

Happy presenting! 