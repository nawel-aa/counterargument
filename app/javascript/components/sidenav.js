const initSidenavOnClick = () => {
  // Main menu
  const closeBtn = document.querySelector('.fa-times');
  const openBtn = document.querySelector('.openav');
  const sideBarMenu = document.querySelector('#sideBarNav')

  // Add listener to open sidenav from avatar
  openBtn.addEventListener('click',() =>{
    sideBarMenu.style.right = "0";
  })

  // Add listener to close sidenav from X icon
  closeBtn.addEventListener('click', () =>{
    sideBarMenu.style.right = "-80%";
  })

  // Filters
  const closeBtnFilters = document.querySelector('.closeFilters');
  const openBtnFilters = document.querySelector('.openFilters');
  const sideBarMenuFilters = document.querySelector('#filters')

  // Add listener to open sidenav from avatar
  if(openBtnFilters) {
    openBtnFilters.addEventListener('click',() =>{
      sideBarMenuFilters.style.right = "0";
    })
  
    // Add listener to close sidenav from X icon
    closeBtnFilters.addEventListener('click', () =>{
      sideBarMenuFilters.style.right = "-80%";
    })
  };

}

export { initSidenavOnClick };
