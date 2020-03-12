const post_form_toggle = () => {

  const new_post = document.getElementById('add_a_post')

  new_post.addEventListener('click', () => {
    const post_form = document.querySelector('.form_part');
    post_form.classList.remove('d-none');
  });
}

export { post_form_toggle };
