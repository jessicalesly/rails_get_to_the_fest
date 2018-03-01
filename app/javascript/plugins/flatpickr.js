import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import "flatpickr/dist/themes/confetti.css"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr("#range_start", {
  dateFormat: "d-m-Y\\Z", // Displays: 2017-01-22Z
  locale: "France",
  altInput: true,
  plugins: [new rangePlugin({ input: "#range_end"})]
})


// flatpickr(".datepicker", {})
