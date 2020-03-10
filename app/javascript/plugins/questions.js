const showExplanation = () => {
  const answers = document.querySelectorAll('.answer');
  answers.forEach((answer) => {
    answer.querySelector('.form-check').addEventListener('click', (event) => {
      event.preventDefault();
      const explanation = answer.querySelector('.explanation')
      explanation.classList.toggle('d-none');
    });
  });
};

export { showExplanation };
