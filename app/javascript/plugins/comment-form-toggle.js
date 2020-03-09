
const form_toggle = () => {

  const btns = document.querySelectorAll('.fa-comments')

  btns.forEach((btn) => {
    btn.addEventListener('click', () => {
      const comment = document.querySelector('#comment_form')
      const form = document.querySelector('#comments_display')
      form.classList.toggle('d-none');
      comment.classList.toggle('d-none');
    });
  });
};

export { form_toggle };
