const showExplanation = () => {
  const answers = document.querySelectorAll('.answer');
  answers.forEach((clickedAnswer) => {
    clickedAnswer.querySelector('.fa-square').addEventListener('click', (event) => {
      answers.forEach((answer) => {
        const checkbox = answer.querySelector(".fa-square");
        checkbox.classList.add('far');
        checkbox.classList.remove('fas');
        const explanation = answer.querySelector('.explanation');
        explanation.classList.add('d-none');
      });

      const checkbox = clickedAnswer.querySelector(".fa-square");
      checkbox.classList.toggle('far');
      checkbox.classList.toggle('fas');
      const explanation = clickedAnswer.querySelector('.explanation');
      explanation.classList.toggle('d-none');
    });
  });
};

export { showExplanation };
