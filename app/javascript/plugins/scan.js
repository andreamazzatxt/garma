import { BrowserMultiFormatReader } from '@zxing/library';


const searchBarcode = (barcode) => {
  const id = document.getElementById('scanner-container').dataset.brandId
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
        window.location.href = data.url;
      }else{
        alert(' 🕵️  Article not found!')
        window.location.reload();
      }
    });

}

const startScanner = () => {

  const video = document.getElementById('video')
  const videoWrapper = document.getElementById('scanner-container')
  const exit = document.getElementById('scan-exit')
  let selectedDeviceId;
  if (videoWrapper){
      // AddEventListener to show the focus bar only when the video stream is loaded
      video.addEventListener('loadstart', () => {
        videoWrapper.classList.remove('scan-hide');
      })
      // Initialize new Scanner
      const scanner = new BrowserMultiFormatReader()
      scanner.getVideoInputDevices()
          .then((videoInputDevices) => {
              selectedDeviceId = videoInputDevices[0].deviceId
              // start.addEventListener('click', () => {

                  scanner.decodeOnceFromVideoDevice(selectedDeviceId, 'video').then((result) => {
                      scanner.reset();
                      searchBarcode(result);
                  }).catch((err) => {
                      console.log(err)

                  })
              // })

           exit.addEventListener('click', () => {
                window.location.href = '/brands'
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
