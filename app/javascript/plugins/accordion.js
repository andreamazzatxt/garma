
const wrappers = document.querySelectorAll('.product-card-wrapper')


  const accordion = () => {

    if (wrappers){
       wrappers.forEach((wrapper) => {
        const card = wrapper.querySelector('.product-card')
        const closeBtn = wrapper.querySelector('.arrow-open-close')

      card.addEventListener('click',()=>{
        const content = wrapper.querySelector('.product-content')
        const arrow = wrapper.querySelector('#arrow')

    if (content.classList.contains('disabled')){
      content.classList.remove('disabled')
      content.classList.add('active')
      arrow.classList.remove('fa-caret-down')
      arrow.classList.add('fa-caret-up')
    }else {
      content.classList.add('disabled')
      content.classList.remove('active')
      arrow.classList.add('fa-caret-down')
      arrow.classList.remove('fa-caret-up')
    }

  });

      closeBtn.addEventListener('click',()=>{
        const content = wrapper.querySelector('.product-content')
        content.classList.add('disabled')
        content.classList.remove('active')
      });
    })
  }
}




export { accordion }


