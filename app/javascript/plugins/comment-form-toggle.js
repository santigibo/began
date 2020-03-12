
const form_toggle = () => {

  const post_sections = document.querySelectorAll('.post_partie')

  post_sections.forEach((post_section) => {
      const btn = post_section.querySelector('.comment_toggle')

    btn.addEventListener('click', () => {
      const comment = post_section.querySelector('.comment_part');
      comment.classList.toggle('d-none');
    });
  });
};

export { form_toggle };
