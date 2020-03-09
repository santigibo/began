const showExplanation = () => {
  const answers = document.querySelectorAll('.answer');
  answers.forEach((answer) => {
    answer.querySelector('a').addEventListener('click', (event) => {
      event.preventDefault();
      const explanation = answer.querySelector('.explanation')
      explanation.classList.toggle('d-none');
    });
  });
};

export { showExplanation };
