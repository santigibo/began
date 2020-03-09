import "bootstrap";
import { showExplanation } from "../plugins/questions"
import { iconToggle } from "../plugins/heart-toggle"
import { form_toggle } from "../plugins/comment-form-toggle"

showExplanation();
iconToggle();
form_toggle();

$('#diet-carousel').carousel({
  interval: false
});

$('#recipe-carousel').carousel({
  interval: false
});
