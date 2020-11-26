const initSidenavOnClick = () => {
  let closeBtn = document.querySelector('.fa-times');
  let openBtn = document.querySelector('.fa-bars');
  let sideBarMenu = document.querySelector('#sideBarNav')

  // Add listener to open sidenav from avatar
  openBtn.addEventListener('click',() =>{
    sideBarMenu.style.width = "80%";
  })

  // Add listener to close sidenav from X icon
  closeBtn.addEventListener('click', () =>{
    sideBarMenu.style.width = "0";
  })

}

export { initSidenavOnClick };
