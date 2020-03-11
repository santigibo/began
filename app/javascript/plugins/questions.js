const showExplanation = () => {
  const answers = document.querySelectorAll('.answer');
  answers.forEach((answer) => {
    answer.querySelector('.form-check .form-check-input').addEventListener('click', (event) => {
      // event.preventDefault();
      // const checkbox = event.currentTarget.firstElementChild
      // checkbox.disabled = true;
      const explanation = answer.querySelector('.explanation')
      explanation.classList.toggle('d-none')
      // if (checkbox.checked === true) {
      //   checkbox.checked = false;
      // } else {
      //   checkbox.checked = true;
      // }

    });
  });
};

export { showExplanation };
