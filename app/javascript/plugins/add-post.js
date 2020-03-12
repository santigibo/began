const post_form_toggle = () => {

  const new_post = document.getElementById('add_a_post')

  new_post.addEventListener('click', (event) => {
    event.currentTarget.classList.add('d-none')
    const post_form = document.querySelector('.form_part');
    post_form.classList.remove('d-none');
  });

  const cross = document.getElementById('close')

  cross.addEventListener('click', () => {
    new_post.classList.remove('d-none')
    const post_form = document.querySelector('.form_part');
    post_form.classList.add('d-none');
  });
}

export { post_form_toggle };
