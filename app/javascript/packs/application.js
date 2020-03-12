import "bootstrap";
import { showExplanation } from "../plugins/questions"
import { iconToggle } from "../plugins/heart-toggle"
import { form_toggle } from "../plugins/comment-form-toggle"
import { cookbook_card_toggle } from "../plugins/heart-cookbook-toggle"
import { post_form_toggle } from "../plugins/add-post"
import { dragg } from "../plugins/draggable-item"
import { striking } from "../plugins/striking"

showExplanation();
striking();
iconToggle();
form_toggle();
cookbook_card_toggle();

if(window.location.pathname === '/posts'){
  post_form_toggle();
  dragg();
};


$('#diet-carousel').carousel({
  interval: false
});

$('#recipe-carousel').carousel({
  interval: false
});

