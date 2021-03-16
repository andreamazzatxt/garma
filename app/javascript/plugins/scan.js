import { BrowserMultiFormatReader } from '@zxing/library';


const searchBarcode = (barcode) => {
  const id = document.getElementById('startButton').dataset.brandId
  fetch(`/brands/${id}/search`, {
  method: 'post',
  body: JSON.stringify({barcode: barcode}),
  headers: {
    'Content-Type': 'application/json',
      },
      credentials: 'same-origin'
    }).then(function(response) {
      return response.json();
    }).then(function(data) {
      if (data.url !== null)
      {
        window.location.href = data.url
      }
    });

}

const startScanner = () => {

  const start = document.getElementById('startButton')
  const reset = document.getElementById('resetButton')
  let selectedDeviceId;
  if (start){
      // Initialize new Scanner
      const scanner = new BrowserMultiFormatReader()
      scanner.getVideoInputDevices()
          .then((videoInputDevices) => {
              selectedDeviceId = videoInputDevices[0].deviceId
              start.addEventListener('click', () => {

                  start.classList.add('scan-hide');
                  reset.classList.remove('scan-hide');
                  scanner.decodeOnceFromVideoDevice(selectedDeviceId, 'video').then((result) => {

                      alert(result)
                      searchBarcode(result);
                      scanner.reset();
                      start.classList.remove('scan-hide');
                      reset.classList.add('scan-hide');
                  }).catch((err) => {
                    // only For testing than pass Error in the console
                      scanner.reset();
                      start.classList.remove('scan-hide');
                  })
              })

              reset.addEventListener('click', () => {
                  start.classList.remove('scan-hide');
                  reset.classList.add('scan-hide');
                  scanner.reset();
              })

          })
          .catch((err) => {
              console.log(err)
          })
        }
}

export { startScanner }

//run rails s with this to test on any mobiles on local host!:)
//rails s -b 'ssl://0.0.0.0:3000?key=localhost.key&cert=localhost.crt'
