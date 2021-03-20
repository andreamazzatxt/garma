const flashTimer = () => {
  const flashes = document.querySelectorAll('.alert')
  if(flashes.length !== 0){
    setTimeout( () => {
      flashes.forEach((flash) => {
        flash.remove()
      })
    }, 3000)
  }
}

export { flashTimer }
