import "bootstrap";
import { showExplanation } from "../plugins/questions"
import { iconToggle } from "../plugins/heart-toggle"

showExplanation();
iconToggle();

$('#diet-carousel').carousel({
  interval: false
});
