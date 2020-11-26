const initExpandableSearch = () => {
const openSearch = document.querySelector('.iconsearch');
const inputBar = document.querySelector('.search-input');
const srchBtn = document.querySelector('.iconsearch2');

// Add listener to open search from click & render search icon invisible
 // & search btn visible
  openSearch.addEventListener('click',() =>{
    openSearch.classList.toggle('remove');
    inputBar.classList.toggle('active');
    srchBtn.classList.toggle('visible');

  })

}

export { initExpandableSearch };
