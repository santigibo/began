
const form_toggle = () => {

  const post_sections = document.querySelectorAll('.post_partie')

  post_sections.forEach((post_section) => {
      const btn = post_section.querySelector('.fa-comments')

    btn.addEventListener('click', () => {
      const comment = post_section.querySelector('.comment_form');

      const form = post_section.querySelector('.comments_display')
      form.classList.toggle('d-none');
      comment.classList.toggle('d-none');
    });
  });
};

export { form_toggle };
