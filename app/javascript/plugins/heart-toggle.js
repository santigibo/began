const iconToggle = () => {
  const icons = document.querySelectorAll('.fa-heart')
  icons.forEach((icon) => {
    icon.addEventListener( 'click', (event) => {
      event.currentTarget.classList.toggle('fas');
      event.currentTarget.classList.toggle('far');
    });
  });
};

export { iconToggle };
