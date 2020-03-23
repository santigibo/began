const iconToggle = () => {
  const icons = document.querySelectorAll('.fa-heart')
  icons.forEach((icon) => {
    icon.addEventListener( 'click', (event) => {
      event.currentTarget.classList.toggle('fas');
      event.currentTarget.classList.toggle('far');

      const added_notif = document.querySelector('#add_recipe')
      const removed_notif = document.querySelector('#remove_recipe')

      if (icon.classList.contains('far')) {
        removed_notif.classList.add('add_notif');
        setTimeout(function(){
          removed_notif.classList.remove('add_notif');
        }, 2500);
      } else {
        added_notif.classList.add('add_notif');
        setTimeout(function(){
          added_notif.classList.remove('add_notif');
        }, 2500);
      }
    });
  });
};

export { iconToggle };
