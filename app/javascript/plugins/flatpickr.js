import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import "flatpickr/dist/themes/confetti.css"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"
import { autocomplete } from '../components/autocomplete'


flatpickr("#range_start", {
  altInput: true,
  // plugins: [new rangePlugin({ input: "#range_end"})]
  plugins: [new rangePlugin({ input: "#secondRangeInput"})]

})

autocomplete();
