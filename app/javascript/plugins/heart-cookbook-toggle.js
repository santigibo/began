const cookbook_card_toggle = () => {

  const cookbook_cards = document.querySelectorAll('.recipe-card-cookbook')

  cookbook_cards.forEach((cookbook_card) => {
    const btn = cookbook_card.querySelector('.fa-heart')

    btn.addEventListener('click', () => {

      cookbook_card.classList.add('d-none');
    });
  });
};

export { cookbook_card_toggle };
