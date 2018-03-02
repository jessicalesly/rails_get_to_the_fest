function divAppear(){
const artists_top_div_all = document.querySelectorAll('.collapse-content-top')
const artists_saved_div_all = document.querySelectorAll('.collapse-content-saved')
const artists_related_div_all = document.querySelectorAll('.collapse-content-related')

const artists_top_number = document.querySelector('.artists-top-number')
const artists_top_div = document.querySelector('.collapse-content-top')
const artists_saved_number = document.querySelector('.artists-recently-listened-number')
const artists_saved_div = document.querySelector('.collapse-content-saved')
const artists_related_number = document.querySelector('.artists-you-could-like-number')
const artists_related_div = document.querySelector('.collapse-content-related')

artists_top_div_all.forEach (function(div){
 div.style.display = "none";
});
artists_saved_div_all.forEach (function(div){
 div.style.display = "none";
});
artists_related_div_all.forEach (function(div){
 div.style.display = "none";
});

artists_top_number.addEventListener('click', (event) => {
    artists_top_div.style.display = "block";
    artists_saved_div.style.display = "none"
    artists_related_div.style.display = "none"
  });


artists_saved_number.addEventListener('click', (event) => {
    artists_saved_div.style.display = "block";
    artists_top_div.style.display = "none"
    artists_related_div.style.display = "none"
  });

artists_related_number.addEventListener('click', (event) => {
    artists_related_div.style.display = "block";
    artists_saved_div.style.display = "none"
    artists_top_div.style.display = "none"
  });
}

export {divAppear};
