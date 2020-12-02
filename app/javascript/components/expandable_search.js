const initExpandableSearch = () => {
const openSearch = document.querySelector('.search-icon');
const inputBar = document.querySelector('.search-input');
const srchBtn = document.querySelector('.search-button');

// Add listener to open search from click & render search icon invisible
 // && search btn visible
  openSearch.addEventListener('click', () =>{
    openSearch.classList.toggle('remove');
    inputBar.classList.toggle('active');
    srchBtn.classList.toggle('visible');
    inputBar.focus();
  })
// Reset when clicking anywhere except input bar & visible search btn
  document.addEventListener('click', (event) =>{
    let isClickOnSearch = openSearch.contains(event.target);
    let isClickOnInput = inputBar.contains(event.target);
    if (!isClickOnSearch && !isClickOnInput){
    inputBar.classList.remove('active');
    srchBtn.classList.remove('visible');
    openSearch.classList.remove('remove');
  }
  })

}

export { initExpandableSearch };
