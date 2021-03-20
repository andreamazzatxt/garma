const save = () => {
  const container = document.getElementById('heart');
  const id = container.dataset.id
  fetch(
    `/products/${id}/garderobe_items`,
    {
      method: 'post',
      headers: {
        'Content-Type': 'application/json',
      }
    }).then((response) => response.json())
      .then((data) => {
        container.setAttribute('data-garderobe-id', data.id)
      })
}

const unsave = () => {
  const container = document.getElementById('heart');
  const id = container.dataset.garderobeId
  fetch(
    `/garderobe_items/${id}}`,
    {
      method: 'delete',
      headers: {
        'Content-Type': 'application/json',
      }
    }).then((response) => response.json())
      .then(data => {
        console.log(data)
      })
}

const heartSave = () => {
  const container = document.getElementById('heart');
  if(container){
    const heartOn = document.getElementById('heart-on');
    const heartOff = document.getElementById('heart-off');
    let saved = container.dataset.saved === 'true';
    // display current status on first load
    container.appendChild(saved ? heartOn : heartOff);
    container.addEventListener('click', () => {
      saved ? unsave() : save();
      container.removeChild(saved ? heartOn : heartOff);
      saved = !saved;
      container.appendChild(saved ? heartOn : heartOff);
    })
  }

}

export { heartSave }
