function flip_cards() {

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

}

export { flip_cards };


//   const card = document.querySelector(".card-black")

// card.addEventListener("click", (event) => {
//   // tab_left.classList.remove("active");
//   // tab_right.classList.add("active");
//   // tab_center.classList.remove("active");
//   // container_left.style.display = "none";
//   // container_center.style.display = "none";
//   // container_right.style.display = "block";
//   console.log(event);
// });

// }


