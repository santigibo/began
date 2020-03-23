const striking = () => {
  const wrongAnswers = document.querySelectorAll('.answer-wrong');
    wrongAnswers.forEach((clickedAnswer) => {
      clickedAnswer.querySelector('.fa-square').addEventListener('click', (event) => {
      wrongAnswers.forEach((answer) => {
        console.log(answer);
        const answerContent = clickedAnswer.querySelector("#to-strike");
        answerContent.classList.add('strike');
        const checkbox = answer.querySelector(".fa-square");
        checkbox.classList.add('far');
        checkbox.classList.remove('fas');
      });
    });
  });
};

export { striking };
