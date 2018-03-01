function bindLoaderToSpotifyConnectButton(button) {
  loaderContainer = document.getElementById('loader-container');
  loaderContainer.style.display = "none";
  button.addEventListener('click', (event) => {
    loaderContainer.style.display = "block";
    // alert("Clicked!")
  })
}

export { bindLoaderToSpotifyConnectButton };
