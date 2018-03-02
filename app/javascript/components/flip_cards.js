
const cards_black = document.querySelectorAll(".card-black")
cards_black.forEach (function(card_black) {
  card_black.addEventListener("mouseenter", (event) => {
    event.currentTarget.classList.toggle("flip");
  });
});
cards_black.forEach (function(card_black) {
  card_black.addEventListener("mouseleave", (event) => {
    event.currentTarget.classList.toggle("flip");
  });
});
