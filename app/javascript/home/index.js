'use strict'
{
  document.addEventListener('DOMContentLoaded', () => {
    function getScrolled() {
      return (window.pageYOffset !== undefined ) ? window.pageYOffset: document.documentElement.scrollTop;
    }

    function scrollTop() {
      const scrolled = getScrolled();
      window.scrollTo(0, Math.floor(scrolled / 2));
      if (scrolled > 0) {
        window.setTimeout(scrollTop, 50)
      }
    }

    const topBtn = document.getElementById('top-btn');

      window.addEventListener('scroll', () => {
        if(getScrolled() > 300) {
          topBtn.classList.add('fadein');
        } else {
          topBtn.classList.remove('fadein');
        }
      });

      topBtn.addEventListener('click', () => {
        scrollTop();
      });
  });
}


//header fadeout
// {
//   document.addEventListener('DOMContentLoaded', () => {
//     const header = document.getElementById('header');
//     window.addEventListener('scroll', () => {
//       const getSrolled = window.pageYOffset || document.documentElement.scrollTop;

//       const windowHeight = window.innerHeight;

//       if(getSrolled > windowHeight - 100) {
//         header.classList.add('scroll-hidden');
//       } else {
//         header.classList.remove('scroll-hidden');
//       }
//     });
//   });
// }

//humbergermenu
{
  document.addEventListener('DOMContentLoaded', () => {
    //turbolinksを無効化している（リロードしなくての動くように)
    document.addEventListener("turbolinks:load", () => { 
      const menuIcon = document.getElementById('menu-icon');
      const menuContent = document.getElementById('menu-content');
      menuIcon.addEventListener('click', () => {
        menuIcon.classList.toggle('active');
        menuContent.classList.toggle('show');
      });
    });
  });
}
