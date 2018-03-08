import "gsap";
import "../plugins/flatpickr";
import "bootstrap";
// import {divAppear} from '../components/collapse';


import '../components/burger';
import {flip_cards} from '../components/flip_cards';
import { bindLoaderToSpotifyConnectButton } from '../components/loader';

import { loadDynamicText } from '../components/typed-text';

const spotifyConnectButton = document.getElementById('connect-spotify');
if (spotifyConnectButton) {
  loadDynamicText();
  bindLoaderToSpotifyConnectButton(spotifyConnectButton);
}

const cards_black = document.querySelectorAll(".card-black");
if(cards_black) {
  flip_cards();
}

// divAppear();
