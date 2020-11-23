{
  const tabmenuBtns = document.querySelectorAll('.tabmenu-btn');
  const tabmenuContents = document.querySelectorAll('.tabmenu-content');

  tabmenuBtns.forEach(clickedtabmenuBtn => {
    clickedtabmenuBtn.addEventListener('click', () => {
      //is-active-tabを一回全部外す
      tabmenuBtns.forEach(tabmenubtn => {
        tabmenubtn.classList.remove('is-active-tab');
      })
      clickedtabmenuBtn.classList.add('is-active-tab');

       //is-active-contentを一回全部外す
      tabmenuContents.forEach(tabmenuContent => {
        tabmenuContent.classList.remove('is-active-content')
      });
      document.getElementById(clickedtabmenuBtn.dataset.id).classList.add('is-active-content');
    });
  });
}
