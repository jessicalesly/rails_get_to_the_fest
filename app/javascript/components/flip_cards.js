function flip_cards() {

// const artists_top_div_all = document.querySelectorAll('.collapse-content-top')
// const artists_saved_div_all = document.querySelectorAll('.collapse-content-saved')
// const artists_related_div_all = document.querySelectorAll('.collapse-content-related')


// artists_top_div_all.forEach (function(div){
//  div.style.display = "none";
// });
// artists_saved_div_all.forEach (function(div){
//  div.style.display = "none";
// });
// artists_related_div_all.forEach (function(div){
//  div.style.display = "none";
// });

// const cards_black = document.querySelectorAll(".card-black .back")
// const flip_btns = document.querySelectorAll(".btn-get-turn")
// cards_black.forEach (function(card_black) {
//   card_black.addEventListener("click", (event) => {
//     event.currentTarget.closest(".card_black").classList.toggle("flip");
//   });
// });

const line_ups = document.querySelectorAll('.line-up')

const flip_btns = document.querySelectorAll(".btn-get-turn")
flip_btns.forEach (function(flip_btn) {
  flip_btn.addEventListener("click", (event) => {
    flip_btn.closest(".card-black").classList.toggle("flip");
    if ($(".line-up-close")[0]) {
      flip_btn.closest(".card-black").querySelector(".line-up").classList.remove("line-up-close");
      flip_btn.closest(".card-black").querySelector(".line-up-content").classList.remove("line-up-content-close");
    }
    flip_btn.closest(".card-black").querySelector(".line-up").classList.add("line-up-open");
    flip_btn.closest(".card-black").querySelector(".line-up-content").classList.add("line-up-content-open");
  });
});

const flip_btns2 = document.querySelectorAll(".btn-get-line-up")
flip_btns2.forEach (function(flip_btn2) {
  flip_btn2.addEventListener("click", (event) => {
    flip_btn2.closest(".card-black").querySelector(".line-up").classList.remove("line-up-open");
    flip_btn2.closest(".card-black").querySelector(".line-up-content").classList.remove("line-up-content-open");
    flip_btn2.closest(".card-black").querySelector(".line-up").classList.add("line-up-reclose");
    flip_btn2.closest(".card-black").querySelector(".line-up-content").classList.add("line-up-content-reclose");
    setTimeout(function(){
      flip_btn2.closest(".card-black").classList.toggle("flip");
      flip_btn2.closest(".card-black").querySelector(".line-up").classList.remove("line-up-reclose");
      flip_btn2.closest(".card-black").querySelector(".line-up-content").classList.remove("line-up-content-reclose");
      flip_btn2.closest(".card-black").querySelector(".line-up").classList.add("line-up-close");
      flip_btn2.closest(".card-black").querySelector(".line-up-content").classList.add("line-up-content-close");
    }, 800);
  });
});

const angles_down = document.querySelectorAll(".fa-angle-down")
angles_down.forEach (function(angle_down) {
  angle_down.addEventListener("click", (event) => {
    angle_down.closest(".line-up").querySelector(".line-up-content").classList.add(".scroll_down");
  });
});

// const artists_top_number = event.currentTarget.children[2].firstChild.firstChild
// const artists_saved_number = event.currentTarget.children[2].children[2].firstChild
// const artists_related_number = event.currentTarget.children[2].children[3].firstChild
// const artists_top_div = event.currentTarget.children[3]
// const artists_saved_div = event.currentTarget.children[4]
// const artists_related_div = event.currentTarget.children[5]

// artists_top_number.addEventListener('click', (event) => {
//     artists_top_div.style.display = "block";
//     artists_saved_div.style.display = "none"
//     artists_related_div.style.display = "none"
//   });


// artists_saved_number.addEventListener('click', (event) => {
//     artists_saved_div.style.display = "block";
//     artists_top_div.style.display = "none"
//     artists_related_div.style.display = "none"
//   });

// artists_related_number.addEventListener('click', (event) => {
//     artists_related_div.style.display = "block";
//     artists_saved_div.style.display = "none"
//     artists_top_div.style.display = "none"
//   });




// cards_black.forEach (function(card_black) {
//   card_black.addEventListener("mouseleave", (event) => {
//     event.currentTarget.classList.toggle("flip");
//   });
// });

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


