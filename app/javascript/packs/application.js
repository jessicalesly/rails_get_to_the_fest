import "../plugins/flatpickr";
import "bootstrap";
import '../components/burger';
import {flip_cards} from '../components/flip_cards';
import { bindLoaderToSpotifyConnectButton } from '../components/loader';

const spotifyConnectButton = document.getElementById('connect-spotify');
if (spotifyConnectButton) {
  bindLoaderToSpotifyConnectButton(spotifyConnectButton);
}

const cards_black = document.querySelectorAll(".card-black");
if(cards_black) {
  flip_cards();
}

