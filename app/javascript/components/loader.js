function bindLoaderToSpotifyConnectButton(button) {
  const loaderContainer = document.getElementById('loader-container');
  loaderContainer.style.display = "none";
  button.addEventListener('click', (event) => {
    loaderContainer.style.display = "block";

    function randomIntFromInterval(min,max) {
      return Math.floor(Math.random()*(max-min+1)+min);
    }

    TweenMax.set('svg', {
      visibility: 'visible'
    });

    // Loader 1
    const loader1Bar1Heights = [20,45,57,80,64,32,66,45,64,23,66,13,64,56,34,34,2,23,76,79,20];
    const loader1Bar1Timeline = new TimelineMax({repeat:-1});
    const loader1Bar2Heights = [80,55,33,5,75,23,73,33,12,14,60,80];
    const loader1Bar2Timeline = new TimelineMax({repeat:-1});
    const loader1Bar3Heights = [50,34,78,23,56,23,34,76,80,54,21,50];
    const loader1Bar3Timeline = new TimelineMax({repeat:-1});
    const loader1Bar4Heights = [30,45,13,80,56,72,45,76,34,23,67,30];
    const loader1Bar4Timeline = new TimelineMax({repeat:-1});

    function tlArrayStep(element, timeline, duration, array) {
      for (let i = 0, length = array.length; i < length; i++) {
        timeline.to(element, duration, {height: array[i]});
      }
    }

    tlArrayStep('.loader1 rect:nth-child(1)', loader1Bar1Timeline, (4.3 / loader1Bar1Heights.length), loader1Bar1Heights);
    tlArrayStep('.loader1 rect:nth-child(2)', loader1Bar2Timeline, (2 / loader1Bar2Heights.length), loader1Bar2Heights);
    tlArrayStep('.loader1 rect:nth-child(3)', loader1Bar3Timeline, (1.4 / loader1Bar3Heights.length), loader1Bar3Heights);
    tlArrayStep('.loader1 rect:nth-child(4)', loader1Bar4Timeline, (2 / loader1Bar4Heights.length), loader1Bar4Heights);
  })
}
export { bindLoaderToSpotifyConnectButton };
