
const form_toggle = () => {

  const btns = document.querySelectorAll('.fa-comments')

  btns.forEach((btn) => {
    btn.addEventListener('click', () => {
      const form = document.querySelector('#comment_form')
      form.classList.toggle('d-none');
    });
  });
};

export { form_toggle };
