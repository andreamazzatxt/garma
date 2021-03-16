const start = document.getElementById('startButton')
const reset = document.getElementById('resetButton')
let selectedDeviceId;

  // Initialize new Scanner
  const scanner = new ZXing.BrowserBarcodeReader()
  scanner.getVideoInputDevices()
      .then((videoInputDevices) => {
          selectedDeviceId = videoInputDevices[0].deviceId
          start.addEventListener('click', () => {

              start.classList.add('hide');
              reset.classList.remove('hide');
              scanner.decodeOnceFromVideoDevice(selectedDeviceId, 'video').then((result) => {

                  alert(result);
                  scanner.reset();
                  start.classList.remove('hide');
                  reset.classList.add('hide');
              }).catch((err) => {
                // only For testing than pass Error in the console
                  alert(err);
                  scanner.reset();
                  start.classList.remove('hide');
              })
          })

          reset.addEventListener('click', () => {
              scanner.reset();
          })

      })
      .catch((err) => {
          alert(err)
      })
