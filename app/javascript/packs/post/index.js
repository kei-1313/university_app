'use strict'

import { data } from "jquery";

{
  const rankingNumbers = document.querySelectorAll('.ranking-number');

  rankingNumbers[0].style.backgroundColor = 'gold';
  rankingNumbers[1].style.backgroundColor = 'silver';
  rankingNumbers[2].style.backgroundColor = '#815a2b';
  rankingNumbers[3].style.backgroundColor = 'springgreen';
  rankingNumbers[4].style.backgroundColor = 'skyblue';
  
}

{
  const keepTime = 50 * 1000;
  const today = new Date();
  const getTodayTime = today.getTime();
  const getTodaySecondTime = getTodayTime / (24 * 60 * 60 * 1000)
  const newMark = document.querySelector('.new-mark');
  console.log(today);
  console.log(getTodaySecondTime);
  console.log(keepTime);

  if (getTodayTime <= keepTime){
    newMark.textContent = '新着';
  }

}