import Typed from 'typed.js';

function loadDynamicText() {
  new Typed('#loader-typed-text', {
    strings: ["We have 401 festivals for you", "15 fit with your tastes", "it's gonna be crazy...", "Wait for it...", "Stay focus...", "...Don't look at your phone", "Let's GOOOO"],
    typeSpeed: 65,
    loop: true
  });
}

export { loadDynamicText };
